/*
 * Models
 * アプリのデータを表すクラス。
 * モデル クラスでは検証ロジックを使用して、そのデータにビジネス ルールを適用します。
 * 通常、モデル オブジェクトはモデルの状態を取得して、データベースに格納します。
 */

using System;

namespace ModelingTool.Models
{
    public class ErrorViewModel
    {
        public string RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}
