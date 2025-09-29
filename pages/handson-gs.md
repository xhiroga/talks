## まずはスプラットを作ってみよう

スマートフォンに[Scaniverse](https://scaniverse.com/)をインストールし、実際に小物をスキャンしてみましょう。

<img class="h-80 place-self-center" src="https://img.youtube.com/vi/8tyxiiu5EC8/maxresdefault.jpg">[^sawara]

[^sawara]: [Scaniverse (筆者デモ)](https://www.youtube.com/watch?v=8tyxiiu5EC8)

---

## スプラットをエクスポートしてみよう

Scaniverseで作成したスプラットは、PLY/SPZとしてエクスポートすることができます。

<img class="h-80 place-self-center" src="https://img.youtube.com/vi/cMenWEiXUdw/maxresdefault.jpg">[^sawara]

[^sawara]: [Scaniverse (筆者デモ)](https://www.youtube.com/watch?v=cMenWEiXUdw)

---

## 作成したスプラットを共有してみよう

PLYファイルなどの点群データは、SuperSplat上で公開できます。

「リスト」にチェックを入れるまではリンクを知っている人しか見られません。自分のスプラットは[Manage](https://superspl.at/manage)から確認できます。

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/Qzc6cUJFCZ8/maxresdefault.jpg">[^sawara]

[^sawara]: [SuperSplat (筆者デモ)](https://www.youtube.com/watch?v=Qzc6cUJFCZ8)

---
layout: two-cols-header
---

## Gaussian Splatting の制作ソフトウェア

<p/>

::left::

### OSS

- **[nerfstudio](https://github.com/nerfstudio-project/nerfstudio)**: NeRFや3D Gaussian Splattingなど、写真からの3D再構成の様々な手法をサポートする
- [gsplat](https://github.com/nerfstudio-project/gsplat): nerfstudioにおける3DGSのコア。PyPIからインストール可能（`pip install gsplat`）
- [Inria 3DGS](https://github.com/graphdeco-inria/gaussian-splatting): 元祖3DGSの論文 "3D Gaussian Splatting for Real-Time Radiance Field Rendering" の公式実装

::right::

### 商用ソフトウェア

 - **postshot**: Windows向け3DGS対応ソフト。無料で試用できるが、PLYなどの書き出しは有料。
 - **Scaniverce**: Pokemon GO でおなじみ Niantic が手がける3Dスキャニングアプリ。Photogrammetry / 3D Gaussian Splatting の両方に対応
 - **LumaAI**: iOS/Androidアプリで撮影した素材をクラウド処理し、約20〜30分で3DGSを生成。Gaussian Splat向けのPLYやOBJ/USDZなどへ書き出せる

---
references:
- https://chatgpt.com/c/68d9c3b5-af40-8329-a987-e4a1ac69f7c4
- https://zenn.dev/tmb0703/articles/e2e7a48bc5bb2c
---

## Gaussian Splatting の出力フォーマット

2025年9月現在、Gaussian Splatting専用の業界標準フォーマットはありません。

<div class="text-xs">

| | 主な特徴 | サイズ / 品質 | 主な用途・対応ツール |
| --- | --- | --- | --- |
| PLY | 本来は点群用 | 非圧縮 | nerfstudioなどで標準的 |
| SPLAT | Inriaチームの公式論文実装が由来 | PLYより軽量だが実装依存 | GraphDeco Viewerなど |
| NPZ | Compact 3DGSが出力するNumPy圧縮 | PLY比より圧縮率高、準ロスレス | Compact-3DGSなど |
| SOG | WebPテクスチャ＋`meta.json`構成 | PLY比15〜20倍小さいロッシー圧縮 | PlayCanvasなど |
| SPZ | Niantic提案のgzipバイナリ | PLY比約10倍小さい実用品質 | Scaniverseなど |

</div>

---
references:
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/creating/recommended-tools/
- https://evergine.com/gaussian-splatting-add-on/
- https://github.com/maincold2/Compact-3DGS
---

## Gaussian Splatting の制作ワークフロー

龍(@lilea)さんの[🌈ガウシアンスプラッティング活用](https://zenn.dev/lilealab/books/how-to-photogrammety/viewer/3dgs)が非常に勉強になるので、ご覧ください。

---
layout: two-cols-header
references:
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/creating/taking-photos/
---

## 写真/動画を撮る（小物）

<p/>

::left::

### ポイント

- 可能な限りブレを避ける
- 露光・光量を抑える
- 背景をシンプルに
- ターンテーブルを使うのではなく、カメラを動かす（背景を全て消すならアリ）

::right::

映像の例（ご自由にご利用ください！）

<a href="https://www.youtube.com/watch?v=-VFPWplI8Tg" target="_blank"><img class="place-self-center" src="https://img.youtube.com/vi/-VFPWplI8Tg/maxresdefault.jpg"></a>

---

## 写真/動画を撮る（場所）

[龍 lileaさん](https://lilea.net/lab)の勉強会資料より[フォトグラメトリ](https://www.docswell.com/s/lileaLab/KW132X-231004#p13)が非常に参考になります。

（公開ありがとうございます...!）

---

## nerfstudio で3DGSを作る

<p/>

1. GitHubから nerfstudio をクローン（xhirogaのフォーク版を使います）
2. COLMAP をインストール
3. `scripts/splatfacto.sh $VIDEO_FILE`のように実行

<!--
Google ColabでCOLMAPを動作させられなかったので、この手順はお蔵入り...
1. [Create 3DGS with nerfstudio.ipynb](https://colab.research.google.com/drive/1Q-AVVcBZ0bwGVXRqAkGGAAc6UlmJTJEF?usp=sharing) を開く
2. ファイル > ドライブにコピーを保存
3. ノートブックの指示に従って実行
-->

処理時間とファイルサイズの目安

- 例1: 動画12秒 (HD画質) → 処理34分 (COLMAP作成: 10分, スプラット作成: 24分) → PLYファイル35MB

---
references:
- https://lilea.net/lab/how-to-use-postshot/
---

## postshot のみでスプラットを作る

動画や複数の画像をドラッグ&ドロップすることで、簡単に3Dシーンの再構成ができます。

ただし、無料プランではExportが制限されています。

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/4UCbM_U9fXQ/maxresdefault.jpg">[^sawara]

[^sawara]: [postshot (筆者デモ)](https://www.youtube.com/watch?v=4UCbM_U9fXQ)

---
references:
- https://www.jawset.com/docs/d/Postshot+User+Guide/Importing+Images
- https://lilea.net/lab/how-to-use-postshot/
- https://zenn.dev/hololab/articles/realitycapture-to-colmap
- https://begin3d.com/sej_rs-ps-3dgs001_index
- https://www.youtube.com/watch?v=yENSTr1d57s&feature=youtu.be
---

## RealityScan と postshot でスプラットを作る

RealityScan 2.0にはGaussian Splattingの機能はありませんが、COLMAP形式に書き出すことでスプラット作成の準備に活用できます。それによって、LiDARなどで取得した安定したデータを初期状態として利用できます。

<img class="h-60 place-self-center" src="https://img.youtube.com/vi/44GFmICpvb4/maxresdefault.jpg">[^sawara]

[^sawara]: [RealityScan & postshot (筆者デモ)](https://www.youtube.com/watch?v=44GFmICpvb4)

---
layout: two-cols-header
---

## ブラウザでスプラットを見る

nerfstudioやpostshotで作成したスプラットを、ブラウザで簡単にプレビューできます。

::left::

### 手順

<p/>

1. [PlayCanvas Model Viewer](https://playcanvas.com/viewer) を開く
2. 作成した`.ply`や`.sog`ファイルをドラッグ＆ドロップする

::right::

<img class="place-self-center" src="https://img.youtube.com/vi/Q0FQkWU8aoE/maxresdefault.jpg">

[1]: [PlayCanvas ModelViewer (筆者デモ)](https://www.youtube.com/watch?v=Q0FQkWU8aoE)
