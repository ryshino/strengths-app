tailwindcss v3.0.7 メモ カンペ
正確なコードは公式サイトを参照してください。
https://tailwindcss.com/docs/installation


## Core concepts

### Responsive Design

ブレイクポイント
sm 640px以上
md 768px以上
lg 1024px以上
xl 1280px以上
2xl 1536px以上

コロンをつけると他クラスを続けて書く事ができる

md:w-32
md:flex

### Hover, Focus, & Other States

コロンを付けて他クラス

hover:    ・・マウスをのせた時
focus:    ・・選択している時
active:   ・・有効時
checked:  ・・チェックした時

Hover, focus & others
hover:text-色-数値(色) コロンをつける

フォームは
hover:outline-none と組み合わせて使う

## customization

## Base Styles

## Layout

aspect ratio
縦横の比率: aspect-auto
aspect-square
aspect-video

container
container mx-auto とすると中央寄せ

カラム数: columns-1
columns-1〜columns-12,
-auto, -3xs〜-7xl


箱のサイズ: box-sizing
box-border
box-content

表示タイプ: display
block ブロック要素
inline-block 
inline インライン要素
flex フレックスボックス
inline-flex
grid グリッド
inline-grid
hidden 非表示
など

浮かせる: floats
float-right, -left, -none

文字の回り込み: clear
clear-left, -right, -both, none

画像などの表示方法 画像全体を表示するか、箱一杯に画像をズームするか: object-fit
object-contain, -cover, -fill, -none, -scale-down

モノ(画像)の位置: object-position
object-bottom, -center, -left, -left-bottom, -left-top, -right, -right-bottom, -right-top, -top

ボックスに収まりきれない内容をどう処理するか: overflow
overflow-auto, -hidden, -visible, -scroll, 
-x-auto, -x-hidden, -x-visible, -x-scroll (yもあり)

位置の種類(相対位置、絶対位置)要素を重ねる場合に使う: position
static 通常の位置
fixed ウィンドウを基準に固定
absolute 親を基準に絶対位置
relative 通常位置を基準に相対位置
sticky スクロールに応じて絶対位置 ヘッダー・フッターなど

要素を重ねたい時 親を relative 子を absolute

上下左右: 
top / bottom / left / right
数値(位置)・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～12 (1ずつ), 14, 16 ～ 64(4ずつ), 72, 80, 96
-auto, -full, -1/2, -1/4,
inset-0 上下左右
inset-x-4 左右 1rem

表示非表示: visibility 
visible
invisible

前に出すか後ろに下げるか: z-index
z-0, -10, -20, -30, -40, -50, -auto

## Flexbox

Flexの方向: flex-direction
flex-row 行(横方向) -row-reverse, 
flex-col 列(縦方向), -col-reverse 

Flexはみ出した時に下にずれるか: flex-wrap
flex-wrap 下にずれる
-wrap-reverse, -nowrap

Flexの幅 文字の長さで箱の幅を変えるか固定か: flex
flex-1 箱の幅固定
-auto 自動調整
-initial 幅を変える
-none

Flexの幅(自動で拡げるかどうか): flex-grow
flex-grow-0 拡げない
-grow 拡げる

Flexの幅(自動で縮めるかどうか): flex-shrink
flex-shrink-0 縮めない
-shrink 縮める

Order 順序: order
order-数値(1～12 1ずつ)
order-1
-none

## Grid
grid-cols-数値 (1〜12 1ずつ, -none) Gridの列
grid-rows-数値 (1〜6 1ずつ, -none) Gridの行

col-auto
col-span-数値 (1〜12 1ずつ, -full)
col-start-数値 (1〜12 1ずつ, -auto)
col-end-数値 (1〜12 1ずつ, -auto)

row-auto
row-span-数値 (1〜12 1ずつ, -full)
row-start-数値 (1〜12 1ずつ, -auto)
row-end-数値 (1〜12 1ずつ, -auto)

アイテムを配置する方向
grid-flow-row, -col
-row-dense, -col-dense

自動
auto-cols-auto, -min, -max, -fr
auto-rows-auto, -min, -max, -fr

Gap Grid間の余白
gap-数値
gap-x-数値, -y-数値 
数値 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4 〜 12 (1ずつ)
14, 16 〜 64 (4ずつ), 72, 80, 96, px 

## Box Alignment 箱の調整

レイアウトを指定(FlexBoxと組み合わせる): justify-content
justify-start 左寄せ, -end 右寄せ, -center 中央寄せ, 
-between 左、中央、右 間をあける, -around ほどよく開ける
-evenly

flexbox/grid内のアイテム: justify-items
justify-items-auto 自動調整, -start 左寄せ, -end 右寄せ, -center 中央寄せ
-stretch 引き伸ばす

個別要素の位置調整(横): justify-self
justify-self-auto, -start, -end, -center, -stretch

行の位置調整(flexbox/grid): align-content
content-center
-start, -end, -between, -around, -evenly

縦の位置調整(flexbox/grid): align-items
items-start
-end, -center, -baseline, -stretch

個別要素の位置調整(縦): align-self
self-auto
-start, -end, -center, -stretch

横と縦を同時調整: place-content
place-content-center,
-start, -end, -between, -around, -evenly, -stretch

個別要素 横と縦を同時調整: place-items
place-items-auto
-start, -end, -center, -stretch

個別要素 横と縦を同時調整: place-self
place-self-auto
-start, -end, -center, -stretch


## Spacing スペース

パディング ボックスの内側の余白: padding

数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 
16 ～ 64 まで4の倍数、72, 80, 96
p-4 1rem
p-8 2rem
py-4 上下1rem
px-4 左右1rem
pt-数値, pb-数値, pl-数値, pr-数値 上下左右
任意の値 p-[5px]

マージン ボックスの外側の余白: margin
数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 
16 ～ 64 まで4の倍数、72, 80, 96
m-4 1rem
m-8 2rem
my-4 上下1rem
mx-4 左右1rem
mx-auto 中央寄せ
mt-数値, mb-数値, ml-数値, mr-数値 上下左右
任意の値 m-[5px]

要素間のスペース --tw-space-y-reverse: 0
数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 16 ～ 64 (4ずつ)、72, 80, 96

Flexboxと合わせて使う
数値(スペース)・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12(1ずつ)
12, 14, 16, 20, 24 ～ 64 (4ずつ), 72, 80, 96
space-x-4 
任意の値 space-y-[5px]


## Sizing サイズ

幅: width
数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 
16 ～ 64 (4ずつ)、72, 80, 96

w-4 1rem
w-8 2rem
1/2, 1/3, 1/4, 1/6, 1/12
w-3/12 25%
w-full 100%
w-screen width: 100vw (スクロールバーも含む)
任意の値 w-[32rem]

高さ: height
数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 
16 ～ 64 (4ずつ)、72, 80, 96

h-4 1rem
h-8 2rem
1/2, 1/3, 1/4, 1/6, 1/12
h-3/12
h-full 100%
h-screen height: 100vh
任意の値 h-[32rem]

最小(それぞれhもあり): min-width
min-w-0
min-w-full
min-w-min
min-w-max

最大(それぞれhもあり): max-width
max-w-0
-none, -xs, -sm, -md, -lg, -xl, -2xl ～ 7xl (1ずつ),
-full, -min, -max, -prose, 
-screen-sm, -screen-md, -screen-lg, -screen-xl, -screen-2xl

## Typography 文字関連

rem 1文字分(一般的に16px)

フォント種類(日本語フォントはないので追加するなら要カスタマイズ): font-family
font-sans, -serif, -mono 

文字の大きさ: font-size
text-xs, -sm, -base, -lg, -xl, -2xl ～ -9xl (1ずつ)

文字の重さ(太さ): font-weight
font-thin, -extralight, -light, -normal, 
-medium, -semibold, -bold, -extrabold, -black

文字間の幅(横): letter-spacing
tracking-tighter, -tight, -normal, 
-wide, -wider, -widest

文字間の幅(縦): line-height
leading-3 ～ leading-10 (1ずつ), 
-none, -tight, -snug, -normal, -relaxed, -loose

リスト: list-style-type
list-none リストの〇を削除
-disc 黒丸, -decimal 数値

リストポジション: list-style-position
list-inside 内側, -outside 外側

フォーム内 
placeholderの色: --tw-placeholder-opacity
placeholder-色-数値(色)

placeholderの透明度: --tw-placeholder-opacity
placeholder-opacity-数値(opacity)

文字の位置(横): text-align
text-left, -center, -right, -justify

文字の色: color
数値(色)・・50, 100 ～ 900 (100ずつ)
text-transparent 透明, -current 現在, -black, -white
text-色-数値(色)
text-green-500 など
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

文字の透明度: --tw-text-opacity
数値(opacity)・・0, 5, 10, 20, 25, 30, 40, 50, 60, 70, 75, 80, 90, 95, 100
text-opacity-数値(opacity)

下線・取り消し線: text-decoration
underline, line-through, no-underline

下線の色: decoration-色-数値(色)

下線の形: decoration-solid
-double, -dotted, -dashed, -wavy

下線の太さ: decoration-0
-1, -2, -4, -8 

テキスト変形(英語圏): text-transform
uppercase 大文字, lowercase 小文字, capitalize 単語の頭文字が大文字, normal-case

テキストがはみ出した時の対応: text-overflow
truncate ...表示 , overflow-ellipsis ...付きで表示, overflow-clip 

テキストのインデント: indent-数値
数値・・0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 5 ～ 12 (1ずつ), 14, 
16 ～ 64 (4ずつ)、72, 80, 96

文字の位置(縦): vertical-align
align-baseline
 -top, -middle, -bottom, -text-top, -text-bottom

半角スペース、タブ、改行をどう表示させるか: white-space
whitespace-normal, -nowrap, -pre, -pre-line, -pre-wrap

ボックスからはみ出す場合の改行方法：word break
break-normal 単語がはみだしてもそのまま, -words はみ出す場合のみ改行, -all 全て改行


## Backgrounds 背景

背景固定など: background-attachment
bg-fixed, -local, -scroll

背景クリップ(背景の切り抜き)： background-clip
bg-clip-border, -padding, -content, -text

背景色: background-color
数値(色)・・50, 100 ～ 900 (100ずつ)
bg-transparent 透明, -current 現在, -black, -white
bg-色-数値(色)
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose


背景透明度: --tw-bg-opacity
数値(opacity)・・0, 5, 10, 20, 25, 30, 40, 50, 60, 70, 75, 80, 90, 95, 100
bg-opacity-数値(opacity)

背景位置: background-position 8方向+中心
bg-bottom, -center, -left, -left-bottom, -left-top, -right, -right-bottom, -right-top, -top

背景繰り返し: background-repeat (画像が小さい時に繰り返すか)
bg-repeat, -no-repeat, -repeat-x, -repeat-y, -repeat-round, -repeat-space

背景サイズ: background-size
bg-auto, -cover, -contain

背景画像(グラデーション): background-image
bg-none
bg-gradient-to-t, -tr, -r, -br, -b, -bl, -l, -tl (上から時計回りに8方向)

グラデーション色合い
from-transparent, -current, -black, -white
数値(色)・・50, 100 ～ 900 (100ずつ)
from-色-数値(色)
via-色-数値(色)
to-色-数値(色)
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose


from-gray-200
via-pink-500
to-yellow-500 など

## Borders 線
線の半径(丸み): border-radius
数値(線)・・sm, md, lg, xl, 2xl, 3xl, full
rounded-none, -sm, rounded, -md, -lg, -2xl, -3xl, -full
rounded-(上下左右)-(数値(線))
rounded-t-none, 
rounded-t, -tr, -r, -br, -b, -bl, -l, -tl (上から時計回りに8方向)

線の幅: border-width
border-方向-数値
数値・・0, 2, 4, 8
border 上下左右
border-2 
border-4 
border-b 下線
border-t-2 上に2px

線の色: border-color
数値(色)・・50, 100 ～ 900 (100ずつ)
border-transparent, -current, -black, -white
border-色-数値（色)
border-yellow-200
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

線の透過 border-色-数値(色)/50 

線のスタイル: border-style
border-solid, -dashed, -dotted, -double, -none

区分け線 : --tw-divide-y-reverse
FlexBoxやGridと組み合わせる
divide-方向-数値
数値・・ 0, 2, 4, 8
divide-x 

区分け線(色): divide-color
divide-色-数値(色)
数値(色)・・50, 100 ～ 900 (100ずつ)
divide-gray-300
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

区分け線の透過 divide-色-数値(色)/50 

区分け線(サイズ) border-style
divide-solid, -dashed, -dotted, -double, -none

リング(箱の周りの線(影)): box-shadow (v1では shadow-outline)
数値・・0, 1, 2, 4, 8
ring, ring-1, ring-inset

リング(色): --tw-ring-color
ring-transparent (透明), -current, -black, -white
ring-色-数値(色)
数値(色)・・50, 100 ～ 900 (100ずつ)
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

リングの透過 ring-色-数値(色)/50 


リング(オフセット(調整)箱と線の間の調整): --tw-ring-offset-width: 1px
ring-offset-0, -1, -2, -4, -8

リング オフセットの色
ring-offset-transparent 透明, -current, -black, -white
ring-offset-(数値(色))-(数値)
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose



## Effects 効果

影: --tw-shadow
shadow-sm, shadow, -md, -lg, -xl, -2xl, -inner, -none

影の色: shadow-色
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

影の透過: shadow-cyan-500/50 など

透明度: opacity
opacity-数値(opacity)
opacity-30

## Tables

境界線を共有するか分離するか: border-collapse
border-collapse 分離
border-separate 共有

テーブルレイアウト:table-layout
table-auto 自動調整
table-fixed 固定

## Transitions and animation

トランジション(設定): transition
transition-none
-all, -colors, -opacity, -shadow, -transform

トランジション(持続期間): transition-duration
数値(duration)・・75, 100, 150, 200, 300, 500, 700, 1000 (ms)
duration-数値(duration)
duration-100

トランジション(タイミング): transition-timing-function
ease-linear, -in, -out, -in-out

トランジション(遅延)
数値(delay)・・75, 100, 150, 200, 300, 500, 700, 1000 (ms)
delay-(数値(delay))
delay-100

アニメーション: animation
animate-none
-spin, -ping, -pulse, -bounce, 


## Transforms 

変形 transform 
transform, transform-gpu, transform-none

変形(基点) transform-origin 
origin-center, -top, -top-right, -right, -bottom-right, -bottom, -bottom-left, -left, -top-left (上から時計回りに8方向)

拡大縮小 scale 100(%)が基準
数値(スケール)・・0, 50, 75, 90, 95, 100, 105, 110, 125, 150
scale-(数値(スケール))
scale-100
scale-(xかy)-(数値(スケール))
scale-y-100

回転 rotate
数値(回転)・・0, 1, 2, 3, 6, 12, 45, 90, 180
rotate-数値(回転)
rotate-90
-rotate-180 マイナスもあり

移動 translate 0が基準
数値(移動)・・0, 0.5, 1, 1.5, 2 2.5 3 3.5 4, 5 ～12(1ずつ)
14, 16 ～ 64 (4ずつ), 72, 80, 96 
1/2, 1/3, 1/4, 1/6, 1/12
translate-(xかy)-数値(移動)
translate-x-5

歪める skew
数値(歪める)・・0, 1, 2, 3, 6, 12
skew-(xかy)-数値(歪める)
skew-x-3

## Interactivity

フォーム関係: accent-色
色・・slate, gray, zinc, neutral, stone, 
red, orange, amber, yellow, lime, green, 
emerald, teal, cyan, sky, blue, indigo, 
violet, purple, fuchsia, pink, rose

ブラウザ仕様のカット: appearance
appearance-none

カーソル: cursor
cursor-auto, -default, -pointer, -wait, -text, -move, -not-allowed

アウトライン: outline
outline-none, outline-white, outline-black

ポイントイベント: pointer-events
pointer-events-none, -auto

リサイズ: resize
resize-none, -y, -x, resize

scrollの挙動: scroll-auto, scroll-smooth

scrollのマージン、パディング:
scroll-m-0
scroll-p-0

スクロールスナップ調整
snap-start, snap-end, snap-center, snap-align-none

スクロールスナップ停止
snap-normal, snap-always

スクロールスナップタイプ
snap-none, snap-x, snap-y, snap-both,
snap-mandatory, snap-proximity

タッチアクション: touch-auto
touch-none, 
touch-pan-x, touch-pan-left, touch-pan-right,
touch-pan-y, touch-pan-up, touch-pan-down,
touch-pinch-zoom, touch-manupulation


選択できるか: user-select
select-none, -text, -all, -auto

