## まずはスプラットを作ってみよう

スマートフォンに[Scaniverse](https://scaniverse.com/)をインストールし、実際に小物をスキャンしてみましょう。

<a href="https://www.youtube.com/watch?v=8tyxiiu5EC8" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/8tyxiiu5EC8/maxresdefault.jpg"></a>

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

 - **postshot**: Windows向けソフト
 - **Scaniverce**: Pokemon GO でおなじみ Niantic が手がける3Dスキャニングアプリ。Photogrammetry / 3D Gaussian Splatting の両方に対応
 - **LumaAI**: iOS/Androidアプリで撮影した素材をクラウド処理し、約20〜30分で3DGSを生成。Gaussian Splat向けのPLYやOBJ/USDZなどへ書き出せる

---
references:
- https://chatgpt.com/c/68d9c3b5-af40-8329-a987-e4a1ac69f7c4
---

## Gaussian Splatting の出力フォーマット

<p/>

| | 主な特徴 | ファイルサイズ / 品質 | 主な用途・対応ツール |
| --- | --- | --- | --- |
| PLY | 汎用的なポイントクラウド/3DGS用の標準バイナリ。位置・法線・SH係数などをフル精度で保持 | 非圧縮で最大数GB規模。品質はロスレス | nerfstudioやCOLMAPなど多くの再構成パイプラインで入出力可能。編集やアーカイブ向け |
| SOG | PlayCanvasが定義する3DGS配信用フォーマット。量子化済みデータをWebPテクスチャ群＋`meta.json`で管理し、単一ZIPにも束ねられる | PLY比でおおよそ15〜20倍小さく、視覚品質はランタイム向けに最適化されたロッシー | PlayCanvas Model Viewerや`splat-transform`でのコンバートに対応。Web配信・CDN配信向け |
| SPZ | Nianticが公開したgzipベースのバイナリ。位置は24bit固定小数、回転は最小3成分量子化などで高圧縮 | PLY比で約10倍小さい。視覚品質はモバイル/クラウド向けに実用レベル | Scaniverse、Niantic Studio、各種SPZ対応ビューワ（例: GSplat Viewer）で利用。軽量配布・モバイル閲覧向け |

---
references:
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/
- https://developer.playcanvas.com/ja/user-manual/gaussian-splatting/creating/recommended-tools/
---

## Gaussian Splatting の制作ワークフロー

[🌈ガウシアンスプラッティング活用 | 龍 lilea](https://zenn.dev/lilealab/books/how-to-photogrammety/viewer/3dgs)を参照ください。

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

動画や複数の画像をドラッグ&ドロップすることで、簡単に3Dシーンを再構成することができます。

ただし、無料プランではExportが制限されています。

<a href="https://www.youtube.com/watch?v=4UCbM_U9fXQ" target="_blank"><img class="h-80 place-self-center" src="https://img.youtube.com/vi/4UCbM_U9fXQ/maxresdefault.jpg"></a>

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

<a href="https://www.youtube.com/watch?v=44GFmICpvb4" target="_blank"><img class="h-80 place-self-center" src="https://img.youtube.com/vi/44GFmICpvb4/maxresdefault.jpg"></a>

---

## Scaniverce でスプラットを作る

Scaniverseで作成したスプラットは、SPZ/PLYとしてエクスポートすることができます。

<a href="https://www.youtube.com/watch?v=cMenWEiXUdw" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/cMenWEiXUdw/maxresdefault.jpg"></a>

---
layout: two-cols-header
---

## ブラウザでスプラットを見る

<p/>

::left::

### 手順

<p/>

1. [PlayCanvas Model Viewer](https://playcanvas.com/viewer) を開く
2. 作成した`.ply`や`.sog`ファイルをドラッグ＆ドロップする

::right::

<a href="https://www.youtube.com/watch?v=Q0FQkWU8aoE" target="_blank"><img class="place-self-center" src="https://img.youtube.com/vi/Q0FQkWU8aoE/maxresdefault.jpg"></a>
