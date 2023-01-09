# forth-training

プログラミング言語 Forth の基本的なワードを学ぶためのコマンドラインツールです.

実行すると, 問題として期待するスタックの変化が表示されます.
それを実現するワードを回答することで Forth の基本的なワードを学ぶことができます.

## 実行例

実行すると期待するスタックの変化が表示され, 入力待ちになります.

    $ forth-training
    ( 1 2 -- 3 ) =>

Forth では慣例的に, コメントでスタックの変化を表記します.

    ( <現在のスタックの状態> -- <変更後のスタックの状態> )

回答としてスタックの状態を変化させるワード (ここでは `+`) を入力します.

    $ forth-training
    ( 1 2 -- 3 ) => +

正解すると `OK` と表示され, 次の問題が出題されます.

    $ forth-training
    ( 1 2 -- 3 ) => +
        OK

不正解の場合は解答が表示され, 次の問題が出題されます.

    $ forth-training
    ( 1 2 -- 3 ) => *
        NG: ( 1 2 * -- 2 )
        expected: +

## インストール

.bashrc に以下を追加します.

    source /PATH-TO-REPOSITORY/src/bashrc/forth-training.bashrc

## 実行方法

以下のコマンドを実行します.

    forth-training

出題方式として sample モードと shuffle モードがあります (デフォルトは shuffle モード).

    # sample モードは "複数ある問題の種類" からランダムに選択し, その種類の問題を出題することを繰り返す.
    forth-training --sample

    # shuffle モードは "複数ある問題の種類" をシャッフルし, 順番に問題を出題することを繰り返す.
    forth-training --shuffle

