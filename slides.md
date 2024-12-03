## LlamaGen: LlamaのNext-Token予測を使った画像生成【論文】 🦙

---

# はじめに

近年の画像生成AIは高品質な一方、大規模言語モデルとの統合は限定的。ChatGPTの画像生成はDALL-Eを呼び出すだけ。🤔

これはアーキテクチャの違いが原因。拡散モデルは高品質だが計算コストが高い。自己回帰モデルは高速だが、高解像度画像には不向き。

**LlamaGen** はLLMであるLlamaを自己回帰型画像生成に応用！画像をトークン化し、Llamaで予測生成することで高品質を実現。✨

将来は、図入り画像の前処理なし学習も可能になるかも？！

---

# 発表のお知らせ📢

この記事の内容を、2024-12-03に行われる[松尾研LLMコミュニティ【Paper & Hacks】#28](https://matsuolab-community.connpass.com/event/338122/) にて発表します！

---

# ソースコード

LlamaGenはオープンソース！🎉
動かすのに苦労したので、フォークして`uv`で動くように整えたリポジトリを公開しました。💪

[FoundationVision/LlamaGen](https://github.com/FoundationVision/LlamaGen)

[xhiroga/LlamaGen](https://github.com/xhiroga/LlamaGen/tree/chore/uv)


---

# 関連研究

自己回帰モデルによる画像生成は、拡散モデル以前から存在していました。

* **PixelCNN (2016):** マスク畳み込みで自己回帰を実現
* **ImageGPT (2020):** Transformerを用いた自己回帰型画像生成
* **ViT (2020):** 画像認識のためのTransformer
* **DALL-E (2021):** Transformerを用いた画像生成、VAEでトークン化
* **VQGAN (2021):** ベクトル量子化とTransformerを用いた高解像度画像生成
* **DiT (2023):** Transformerを用いた拡散モデル

LlamaGenの貢献は、LLMのノウハウを画像生成に適用し、高品質を実現した点！

---

# LlamaGenのアーキテクチャ

2つの主要モジュール:

1. **Image Tokenizer:** 画像をトークン列に変換 (VQGANベース)
2. **Llama:** トークン列から自己回帰的に画像生成

```mermaid
graph LR
    i[画像 🏞️]
    t[テキスト・クラス 💬]
    
    i --> enc[エンコーダー<br/>量子化器]
    subgraph Image Tokenizer
    enc --コードブックを参照--> token([グリッドトークン<br/>🟦 🟩 ⬜️ 🟩 ...])
    token --> dec[デコーダー]
    end

    t --> llm[Llama 🦙]
    token --> llm
    llm --> token

    dec --> o[出力画像 🏞️]
```

---

# LlamaGen vs. ViT

どちらもTransformerを使うが、役割は違う！

| 特徴 | LlamaGen | ViT |
|---|---|---|
| タスク | 画像生成 | 画像分類 |
| アーキテクチャ | Transformer Decoder | Transformer Encoder |
| トークン化対象 | 画像パッチ | 画像パッチ |
| トークン化方法 | ベクトル量子化 | パッチ埋込み |


---

# Image Tokenizer 🔎

高解像度画像をトークン列に変換する重要モジュール。Transformerの計算コストを抑える🔑

* **エンコーダー:** 画像を低次元特徴マップに変換
* **量子化器:** 特徴マップをコードブックのベクトルに置き換え (トークン化)
* **デコーダー:** トークン列から画像を再構成

VQGANと同じアーキテクチャを採用。

---
layout: image-right
image: https://github.com/CompVis/taming-transformers/blob/master/assets/teaser.png?raw=true
---

# Image Tokenizer (VQGAN)

VQGANのアーキテクチャ。LlamaGenとほぼ同じで、自己回帰モデルがTransformerかLlamaかの違い。

---


# ベクトル量子化

連続ベクトル空間を離散コードブックで表現する手法。VQ-VAE等で利用され、高次元データを効率的に圧縮。

[分かりやすい記事](https://www.softech.co.jp/mm_120704_pc.htm)


---

# Image Tokenizer パラメータ

* **ダウンサンプル比:** 画像の解像度を下げる比率 (例: 8, 16)
* **コードブックの語彙数:** トークンの種類 (例: 4096, 32768)

256x256画像をダウンサンプル比8でトークン化 → 1024トークン

Llama3のボキャブラリーは128Kトークンなので、まだ桁が違う。


---

# Image Tokenizer 訓練

生成画像が入力画像に近づくよう、以下の損失関数を最小化:

$L_{AE} = L_2 (x, \widehat{x}) + L_P (x, \widehat{x}) + \lambda_G L_G (\widehat{x})$

* $L_2$: 平均二乗誤差
* $L_P$: 知覚的損失 (LPIPS)
* $L_G$: 敵対的損失 (PatchGAN)


---


# Next-Token予測による画像生成

Image Tokenizerで生成されたトークン列をLlamaに入力し、自己回帰的に次のトークンを予測。文章生成と同様のアプローチ。

PixelCNNやImageGPTも同様の手法だが、LlamaGenはLLMを使用することでスケーラビリティと生成品質を向上。


---

# CFG (Classifier-Free Guidance)

LlamaGenはStable Diffusion同様、CFGを用いて条件付き画像生成を実現。

テキスト条件付けでは、T5でテキストを埋め込みに変換し、画像トークン埋め込みと連結して入力に使用。

[CFG解説記事](https://cake-by-the-river.hatenablog.jp/entry/stable_diffusion_8)


---

# Next-Token予測の訓練

大規模言語モデルの事前学習と同様。予測トークンに対する交差エントロピー誤差を計算、逆伝播。

CFGでは、条件付き損失と条件なし損失を組み合わせて最終的な損失を計算。


---

# 評価指標

* **IS (Inception Score):** 生成画像の品質と多様性
* **FID (Fréchet Inception Distance):** 生成画像と実画像の分布の距離
* **rFID (Reconstruction FID):** Image Tokenizerの性能
* **sFID:** FIDの改良版
* **Precision/Recall:** 生成画像の多様性とプロンプト適合性
* **PSNR/SSIM:** 画質の客観的評価


---


# IS (Inception Score)

InceptionNetを用いて、生成画像の品質を評価。値が高いほど良い。

[IS解説記事](https://data-analytics.fun/2021/12/12/understanding-inception-score/)

---

# FID (Fréchet inception distance)

生成画像と実画像の分布の距離を測る。値が小さいほど良い。

---

# スケール則

LlamaGenもLLMと同様に、パラメータ数増加で高品質化。スケール則ばんざい！🙌

---

# LLMエコシステム🚀

LlamaGenはLLMの最適化技術(AdamW, 勾配クリッピング等)とvLLMによる高速推論を活用。


---


# まとめ

LlamaGenはLLMを自己回帰型画像生成に応用した新モデル。高品質なImage Tokenizerと効率的な訓練で拡散モデルに匹敵する品質を実現。LLMのスケール則にも従い、今後の発展に期待大！


---

# 今後の課題🤔

* トークン数の制御
* マルチモーダルへの拡張

これらの課題解決で、LlamaGenは更なる進化を遂げるでしょう！


---

# Q&A

ご清聴ありがとうございました！
質問等あればお気軽にどうぞ！🙋‍♀️
