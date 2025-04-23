# Blender用MCP拡張機能を自作して得た学び

- 発表者：小笠原寛明 (xhiroga)  
- @アニメシステムコミュニティ LT — 2025/04/23

---

# ⚠️ 開発中の断り書き

- 本プラグインは現在開発中の α 版です  
- 仕様変更・バグ含む可能性があります  
- ご意見・コラボ大歓迎！

---
layout: iframe
url: https://www.youtube.com/embed/VmnWe3MHN3c?si=5H31EaQ-OH-gijxU
---

## 目次

- MCPとは？
  - Blender MCP
  - Unity MCP
- 開発の動機
- ライセンス
- RAG
- まとめ
- お話しましょう！

---

# MCP とは何か？
- **Model Context Protocol** の略
- Anthoropic社が提唱した、LLMがソフトウェアを用いる際のオープン規格
- ソフトウェア側は、「リソース」「ツール」「プロンプト」を提示できる

---

# Blender MCP

- 実は、BlenderのためのMCPサーバーはすでに存在する
- LLMに指示をして3Dオブジェクトを作成することが可能

<img class="h-80" src="/image-from-yt_lCyQ717DuzQ.png">

---

# Unity MCP

- LLMを通じてUnityを操作

<img class="h-80" src="/image-unity-mcp.png">

---

# 開発の動機

**「知らないことを知らないまま調べる」**  
- Blenderの操作ログをLLMに読み取らせることで、操作の名称などをユーザーが知らなくても検索できるように
- 公式ドキュメント・Web情報（ゆくゆくは社内ナレッジ）を即取得
- そのほか、お手本を作る、手間のかかる作業を自動化するなど

---

# 構成

- MCPサーバーはLLMが起動するサブプロセス
  - 標準入力でコマンドを送り、標準出力で結果を返す
- Blender上の拡張機能は、BlenderのUIを描画するPythonプロセスがイベントループ中に実行する処理のひとつ
  - したがって、サーバーの待ち受けは別スレッドで行う必要がある（そうしないと画面が止まる）
- 2025-03にMCPの新たな仕様が提案され、将来的には拡張機能がMCPサーバーを兼ねることができる予定
  - Streamable HTTP

<img class="h-50" src="/architecture.jpg">

---

# ライセンスと配布
- 本体: **GPL ライセンス**  
  - Blender公式ドキュメント等を参照しているため
- 事業などで利用を希望される方には、異なるライセンスで頒布します（お問い合わせください）
  - Blender公式ドキュメントへの依存は削除します

---

# MCP開発の知見

- 特に理由がなければTypeScriptのSDKを用いるのが良い（最重要）
  - 新仕様がもっとも先に実装されるのがTypeScript版
  - 公式の参照実装はTypeScriptとPythonで実装されているが、Pythonは体感3割に満たない
- LLMに接続する前にJSON-RPCで実験するのが良い
  - JSONを用いて外部プロセスを呼ぶための規格
  - LLMもJSON-RPCを投げているに過ぎない
  - LLMサービス毎のMCP実装はどれも癖がある状態で、別のトラブルを踏む可能性が高い

---

# RAGとは？

- Retrieval Augmented Generationの略
- 検索拡張生成とも

---
layout: iframe
url: https://www.youtube.com/embed/iBOGhhyx6mg?si=fMBqZEcqS8VszF39
---

# RAG 実装のポイント

1. 評判の良いモデルの選定
  - 今回は`sentence-transformers/all-MiniLM-L6-v2`を選定
  - 日本語特化ならより良いモデルが存在しそう
  - Meilisearchなどの検索まで一体化したOSSを選定してしまうのも手
2. チャンク化
  - 文書をどの単位でベクトル化するか

---

# まとめと次の一歩

- 初心者支援にMCPの検討はいかがでしょうか？
- α 版フィードバック募集！  

---

# お話しましょう！

本日はBlender MCP拡張機能の開発についてでしたが、それ以外にも様々な取り組みをしております。

---
layout: iframe-right
url: https://www.youtube.com/embed/hS4kRE3OmGs?si=9O_tk_Dr-84pz-Tj
---

## 実績: GPU仮想環境構築

- NVIDIAのGPUをより利用しやすいよう、仮想環境まで構築してご提供いたします。
- 実際に私自身が自宅で運用しています。
- 環境のバックアップ・複製などが容易に可能です。

---
layout: iframe-right
url: https://speakerdeck.com/player/8bdd5491280842ddba1dce789a44c831
---

## 実績: AWSコスト削減ハンズオン

- スタートアップ企業向けのイベント内で、AWSのコスト削減ハンズオンを行いました。
- 実際に手を動かして無駄なリソースをチェックいただき、参加者の9割がその場で何らかのコスト削減を行うことができました。

---
layout: iframe-right
url: https://www.youtube.com/embed/Iaw0m6rAdrI?si=QZeO9OwoxQxpYoEs
---

## 研究: 中割りの自動生成

- オープンな動画生成AIを用いて、開始フレームと終了フレームから中割り画像を生成できます。

---
layout: iframe-right
url: https://www.youtube.com/embed/onCWChnwhHI?si=T6JvLuqaJdLwqmen
---

## 研究: 最新論文の紹介

- 松尾研LLMコミュニティにて、画像生成に関する最新の論文の紹介を行いました。
- コミュニティには研究者以外の方も多いため、分かりやすいご紹介を心がけました。

---

お気軽にお声がけください！
