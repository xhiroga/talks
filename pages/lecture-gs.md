## まずは触ってみる

[SuperSplat](https://superspl.at/)にアクセスして、様々なスプラットを見てみましょう。

---
references:
- [3D生成手法の比較(フォトグラメトリ & NeRF & 3D Gaussian Splattig)](https://qiita.com/yukis0111/items/87359b30ddef2856d3fa)
---

## 3次元再構成の歴史

| 年代 | 技術 | 主な出来事 |
| --- | --- | --- |
| 1860年代 | フォトグラメトリ | 1867年にドイツで最初のフォトグラメトリ研究が報告され、写真測量が測量・地図作成に利用され始める |
| 2000年代 | SfM / MVS | デジタル写真と計算機ビジョンの発展でSfMとMVSが一般化し、点群生成やカメラ推定が高精度化 |
| 2020年 | NeRF | MildenhallらによるNeRF論文が発表され、ニューラルラジアンスフィールドでの高品質な新規視点生成が注目を集める |
| 2023年 | 3D Gaussian Splatting | Kerblらがリアルタイムレンダリング可能な3D Gaussian Splattingを発表し、即時可視化と高速更新が可能に |

---
references:
- https://zenn.dev/lilealab/books/how-to-photogrammety/viewer/introduction
- https://www.docswell.com/s/lileaLab/KW132X-231004
- https://www.isprs.org/society/history/grimm-the-origin-of-the-term-photogrammetry.pdf
- https://chatgpt.com/c/68d73c2e-a1ec-8330-bebe-bed45b87fa9a
---

## フォトグラメトリ

写真画像から対象物の幾何学特性を得る方法。特に、写真から3次元データを得る方法。初出は1867年。

- Photogrammetry
  - photo (写真)
  - gram (書かれたもの, 記録)
  - metry (計測)

写真からメッシュデータを生成することをフォトグラメトリと呼ぶことが多い。

---
references:
- [SfM MVS 技術基盤](https://chatgpt.com/c/68d9b223-9588-8325-aa86-52a18c028cf0)
- https://chatgpt.com/c/68d9b5e0-4634-8320-b0c6-f90ce14abb75
---

## SfM/MVS

<p/>

- 深層学習によって複数の写真から点群を得る手法
- SfM (Structure from Motion) と MVS (Multi-View Stereo) を組み合わせて用いる
- SfMは写真からのカメラ位置推定・疎な点群の推定を、MVSが密な点群の推定を担当する。その後メッシュ化することも多い
- SfMの実装としてはCOLMAP, MVSの実装としてはOpenMVSなどがある
- メッシュ再構成のパイプラインは次の図の通り

<a href="https://www.ist.hokudai.ac.jp/labo/dgp/research/sfm_mvs/research_sfm_mvs.html" target="_blank"><img class="h-60 place-self-center" src="/hokudai-dgp-research_sfm_mvs-image001.webp"></a>[^hokudai]

[^hokudai]: [北海道大学 ディジタル幾何処理工学研究室, "SfM-MVSの高品質化".](https://www.ist.hokudai.ac.jp/labo/dgp/research/sfm_mvs/research_sfm_mvs.html.)

---

<a href="https://www.youtube.com/watch?v=XBAkhyJE-k8" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/XBAkhyJE-k8/maxresdefault.jpg"></a>[^OpenMVS]

[^OpenMVS]: [OpenMVS, "Chamois Statue by OpenMVS on Sketchfab"](https://sketchfab.com/models/3aedcdd22c31447199c18dd9aec5d952)を筆者がデモ

---
references:
- https://aicam.jp/tech/sfmmvs
- https://www.jstage.jst.go.jp/article/jsprs/60/3/60_95/_pdf/-char/ja
- https://sokugikyo.or.jp/wp-content/uploads/2024/04/119-2.pdf
---

## NeRF (2020~)

<p/>

- 読みは「ナーフ」
- ニューラルネットで空間中の放射と密度分布を学習し、高品質な新規視点レンダリングを実現するニューラルラジアンスフィールド手法。
- 出力はメッシュや点群ではなくニューラルネットワークのデータ（.safetensorsファイルなど）

---
layout: two-cols-header
references:
- [3D Gaussian Splatting for Real-Time Radiance Field Rendering](https://notebooklm.google.com/notebook/284128fd-8c71-4970-a0e9-014ded5b6bca)
- [](https://huggingface.co/blog/gaussian-splatting)
- [3D Gaussian Splatting の概要](https://note.com/npaka/n/ncd4b84c1e2eb)
- 3D Gaussian Splatting: Survey, Technologies, Challenges, and Opportunities - Yanqi, 2024 ([NotebookLM](https://notebooklm.google.com/notebook/8466d1fb-fbbc-4bbf-a095-63f5188f1e04))
- DROID-SLAM (Zachary, 2022)
- SplaTAM (Keetha, 2023)
- GS-SLAM (Chi, 2024)
---

## Gaussian Splatting (2023~)

本来は点群データの形式・レンダリング手法。

::left::

### Gaussain (ガウシアン)

Gaussianとはガウス分布（正規分布）のこと。メッシュや密な点群ではなく、疎な点群に対して大きさ・色・透明度を3次元ガウス分布として持つ

::right::

### Splatting (スプラッティング)

3DCGデータを2Dにレンダリングする手法の1つ。

- レイトレーシング: カメラから奥に光線を飛ばして、最初に交差した物体を描画する
- スプラッティング: 各点をスクリーン側に投影する
- 三角形ラスタライズ: メッシュで利用可能。手前の三角形を塗る

学習したデータを「スプラット」と呼ぶことが多い。

---

## Point Splatting を眺めて理解する

Gaussianではない単純なPoint Splattingで、Splattingの手法を理解します。[Potree #Examples](https://github.com/potree/potree#examples)を眺めましょう。

- 例1: [ハイデントール](https://potree.org/potree/examples/vr_heidentor.html)
- 例2: [ライオン](https://potree.org/potree/examples/vr_lion.html)
- 例3: [ツールバー](https://potree.org/potree/examples/toolbar.html)

参考: [potree/potree](https://github.com/potree/potree)

---

<a href="https://www.youtube.com/watch?v=PWtkCRQaahY" target="_blank"><img class="h-100 place-self-center" src="https://img.youtube.com/vi/PWtkCRQaahY/maxresdefault.jpg"></a>[^potree]

[^potree]: [Potree, "Heidentor"](https://potree.org/potree/examples/vr_heidentor.html)を筆者がデモ

---

## Gaussian Splatting の仕組み

[高精細な3D空間を再現する3D Gaussian Splattingとは？従来の3Dモデルとの違いを解説します | SEKIDO](https://sekido-rc.com/blog/2025/01/16/enterprise_0025/)を参照ください。

---
references:
- https://www.docswell.com/s/HoloLab/K9VWRX-holotech24_b2#p7
- https://begin3d.com/sej_rs-ps-3dgs001_index
---

## フォトグラメトリ / NeRF / Gaussian Splatting の使い分け

<p/>

|  | Pros | Cons |
| --- | --- | --- |
| フォトグラメトリ | <ul><li>マットな質感を忠実に表現</li><li>幾何学的な精度が高い</li></ul> | <ul><li>透明・鏡面が苦手</li><li>手動最適化が重い</li></ul> |
| NeRF | <ul><li>新規視点補間と高周波テクスチャに強い</li></ul> | <ul><li>リアルタイムや透明表現が難しい</li><li>後工程が複雑</li></ul> |
| 3D Gaussian Splatting | <ul><li>透明や反射を上手に表現</li><li>葉のような細かい質感の再現に有利</li><li>リアルタイム描画に強い</li><li>自動化が容易</li></ul> | <ul><li>マット材質や未撮影視点に弱い</li><li>幾何学的な精度は低い</li></ul> |
