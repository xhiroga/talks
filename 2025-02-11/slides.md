## マルチモーダル理解と生成の統一の取り組み. DeepSeek Janus

- Janus-Pro: Unified Multimodal Understanding and Generation with Data and Model Scaling
- [arXiv:2501.17811](https://arxiv.org/abs/2501.17811)

---

# 目次

- はじめに
- Janusとは？
- モデルの概要
  - マルチモーダル理解の特徴
  - 生成の特徴
  - 触ってみよう
- Janusを知ると何が嬉しいか
  - 視覚エンコーディング分離
  - 学習戦略
- マルチモーダルLLMの展望
  - Chameleon
  - 統一画像トークナイザー
- 参考文献など

---
layout: image-right
image: https://cdn.bsky.app/img/avatar/plain/did:plc:et47te5fb7uv64pbltu37lcc/bafkreihfnrk5dlh43swtcstq7io6ox32z5jflucd6afirfpfm3j4zbvrnm@jpeg
---

# はじめに: 自己紹介

- 名前: 小笠原寛明
- Twitter: [@xhiroga](https://twitter.com/xhiroga)
- Bluesky: [@hiroga.bsky.social](https://bsky.app/profile/hiroga.bsky.social)
- 興味関心: お絵描き, 3D, CG, CV, マルチモーダルモデル
- **フォロー**すると、開発や調べ物の様子が見えます！

---

# はじめに: どうしてJanusについて調べたの？

- オープンウェイトな自己回帰モデルで、最先端の画像生成に追随するモデルが遂に出てきたため。
- マルチモーダルLLMのトレンドを、この機会に整理したいと思ったため！

---

# マルチモーダル理解・生成モデルの何が嬉しいのか？

- LLMが図表ありで応答できるようになる！
- Visual Chat & Interleaved Text/Image Generationの例 (Chameleon)

<img class="h-80" src="/chameleon-figure-7.png">

---

# DeepSeek Janus (Pro)とは？

- DeepSeek-LLMを基盤モデルとして、マルチモーダル対応の学習を追加で行ったモデル。
- 2024年10月にJanus-1.3Bが公開された
- 2025年1月にJanus Pro 1B/7Bが公開された

---
layout: image-right
image: https://upload.wikimedia.org/wikipedia/commons/f/f4/Janus-Vatican.JPG
---

# トリビア: ヤーヌスとは？

ローマ神話の出入口の扉の守護神。入口の神なので、1年の始まり＝1月(January)の守護神でもある。[^Wikipedia_ヤーヌス]

[^Wikipedia_ヤーヌス]:https://ja.wikipedia.org/wiki/%E3%83%A4%E3%83%BC%E3%83%8C%E3%82%B9

---

## Janus Proのアーキテクチャ（理解）

```mermaid
flowchart LR
    t([プロンプト 💬])
    i[画像 🏞️]
    t-->sft([SFT形式に変換])
    sft--トークナイザー-->token_without_image([トークン<br/>（画像のための空きスペースあり）])
    token_without_image-->token[トークン（画像つき）]
    i-->token
    
    token--LLM-->token
    token -- デコーダー--> res[レスポンス 💬]
```

---

## Janus Proのアーキテクチャ（生成）

```mermaid
flowchart LR
    t([プロンプト 💬])
    t-->sft([SFT形式に変換])
    sft-->with_image_start_tag([image_start_tagを付与])
    with_image_start_tag--トークナイザー-->token([トークン])
    
    token--LLM-->token
    token -- デコーダー--> o[出力画像 🏞️]
```

### 補足

- SFT形式: `[{'role': '<|User|>', 'content': prompt}, {'role': '<|Assistant|>', ...}]`
- image_start_tag: `<begin_of_image>`

---
layout: two-cols-header
---

## 触ってみよう！

::left::

## HuggingFace (Janus-Pro-7B)

https://huggingface.co/spaces/deepseek-ai/Janus-Pro-7B

::right::

## Google Colab

https://github.com/xhiroga/til/blob/main/software-engineering/deepseek-ai/Janus/_src/sandbox/Janus_Pro_1B.ipynb

---

# Janusを知ると何が嬉しいか: 視覚エンコーディングの分離

- マルチモーダル理解・生成タスクでは、それぞれ必要な理解度が異なる
  - 理解タスクでは画像の概要が掴めれば良い
  - 生成タスクではピクセルレベルの細部を知る必要がある
- Janusでは、理解と生成で別々のトークナイザーを用いている

---

# SigLIP

- Googleが改良したCLIP
- 画像とテキストの類似性を確率で見ることができる

<img class="h-80" src="/tsutof-siglip.png">

引用: [日本語にも対応するマルチモーダルAIモデルSigLIPでゼロショット画像分類を試す / tsutof](https://zenn.dev/tsutof/articles/f53f035f8df9f3)

---

# LlamaGen

前回の発表もご覧ください！

<img class="h-100" src="/llamagen-thumbnail.png">

---

# Janusを知ると何が嬉しいか: 学習戦略

- 単一のモデルで理解と生成を行う場合、学習のバランスが重要になる
- Janusでは理解系のタスク（VQAなど）を重視し、徐々に画像生成タスクの比率を上げたと推測される

---

# マルチモーダルLLMの展望: Chameleon

- Janus以前から登場していたマルチモーダル理解・生成モデル
- 理解と生成で同一の画像トークナイザーを用いている

<img class="h-80" src="/chameleon-figure-4.png">

---

# マルチモーダルLLMの展望: 統一画像トークナイザー

- 理解と生成で同一のトークナイザーを用いつつも、タスクごとに異なる特性を発揮させるアーキテクチャが提案されている
- TokenFlowは、意味的な特徴とピクセルレベルの詳細に対応した、リンクする2つのコードセットを持つトークナイザーを提案している
- TURINGが提案したOne-D-Pieceでは、画像の重要な情報をベクトルの先頭に集中させることで、先頭のケタを用いれば必要な解像度が得られるようにしている

---

# おすすめ！！！

[![One-D-Piece](https://pbs.twimg.com/card_img/1886991035404050435/A65mMgoo?format=png&name=medium)](https://zenn.dev/turing_motors/articles/6d77c5a3b3712e)

---

# まとめ

- マルチモーダル理解・生成モデルの改善が続いている
- DeepSeek Janusは理解・生成のトークナイザーを別々にするアプローチを取った
- 可変の画像トークナイザーが提案されつつあり、今後のマルチモーダルLLMに組み込まれることが予想される

---

# 参考文献 (1)

- C. Wu et al., “Janus: Decoupling Visual Encoding for Unified Multimodal Understanding and Generation,” Oct. 17, 2024, arXiv: arXiv:2410.13848. doi: 10.48550/arXiv.2410.13848.
- Y. Ma et al., “JanusFlow: Harmonizing Autoregression and Rectified Flow for Unified Multimodal Understanding and Generation,” Nov. 12, 2024, arXiv: arXiv:2411.07975. doi: 10.48550/arXiv.2411.07975.
- X. Chen et al., “Janus-Pro: Unified Multimodal Understanding and Generation with Data and Model Scaling,” Jan. 29, 2025, arXiv: arXiv:2501.17811. doi: 10.48550/arXiv.2501.17811.

---

# 参考文献 (2)

- X. Zhai, B. Mustafa, A. Kolesnikov, and L. Beyer, “Sigmoid Loss for Language Image Pre-Training,” Sep. 27, 2023, arXiv: arXiv:2303.15343. doi: 10.48550/arXiv.2303.15343.
- P. Sun et al., “Autoregressive Model Beats Diffusion: Llama for Scalable Image Generation,” Jun. 10, 2024, arXiv: arXiv:2406.06525. doi: 10.48550/arXiv.2406.06525.
- C. Team, “Chameleon: Mixed-Modal Early-Fusion Foundation Models,” May 16, 2024, arXiv: arXiv:2405.09818. doi: 10.48550/arXiv.2405.09818.
- L. Qu et al., “TokenFlow: Unified Image Tokenizer for Multimodal Understanding and Generation,” Dec. 04, 2024, arXiv: arXiv:2412.03069. doi: 10.48550/arXiv.2412.03069.
- K. Miwa, K. Sasaki, H. Arai, T. Takahashi, and Y. Yamaguchi, “One-D-Piece: Image Tokenizer Meets Quality-Controllable Compression,” Jan. 17, 2025, arXiv: arXiv:2501.10064. doi: 10.48550/arXiv.2501.10064.

---

# 関連情報

- [Once you think they're done, Deepseek releases Janus-Series: Unified Multimodal Understanding and Generation Models](https://www.reddit.com/r/StableDiffusion/comments/1ibdhct/once_you_think_theyre_done_deepseek_releases/)
- [論文解説 : Janus-Pro: Unified Multimodal Understanding andGeneration with Data and Model Scaling](https://note.com/atakana/n/nd1cb35aa5fe2)
- [@itnavi2022](https://x.com/itnavi2022/status/1883942016754843868)
- [可変品質での圧縮を実現する画像トークナイザ「One-D-Piece」を公開しました](https://zenn.dev/turing_motors/articles/6d77c5a3b3712e)
