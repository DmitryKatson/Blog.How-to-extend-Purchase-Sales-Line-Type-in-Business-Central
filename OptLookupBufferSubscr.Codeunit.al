codeunit 50100 "OptLookup Buffer Subscr"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnBeforeIncludeOption', '', false, false)]
    local procedure AddFishToOption(LookupType: Option; Option: Integer; OptionLookupBuffer: Record "Option Lookup Buffer"; var Handled: Boolean; var Result: Boolean)
    var
        PurchLine: Record "Purchase Line";
        IndexOfFishType: Integer;
    begin
        if (LookupType <> OptionLookupBuffer."Lookup Type"::Purchases) then
            exit;
        IndexOfFishType := PurchLine.Type.Ordinals.IndexOf(PurchLine.Type::"AIR Fish".AsInteger()) - 1;
        if Option = IndexOfFishType then begin
            Result := true;
            Handled := true;
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnBeforeInsertEvent', '', false, false)]
    local procedure AddFishDescriptionToOptionLookupBuffer(var Rec: Record "Option Lookup Buffer")
    var
        PurchLine: Record "Purchase Line";
        IndexOfFishType: Integer;
    begin
        if Rec."Lookup Type" <> Rec."Lookup Type"::Purchases then
            exit;

        IndexOfFishType := PurchLine.Type.Ordinals.IndexOf(PurchLine.Type::"AIR Fish".AsInteger()) - 1;
        if Rec.ID = IndexOfFishType then begin
            Rec.ID := "Purchase Line Type"::"AIR Fish".AsInteger();
            Rec."Option Caption" := Format("Purchase Line Type"::"AIR Fish");
        end;

    end;
}