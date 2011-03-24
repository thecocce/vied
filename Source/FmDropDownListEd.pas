{ ##
  @FILE                     FmDropDownList.pas
  @COMMENTS                 Drop-down list editor dialog box - allows user to
                            select a value from a drop-down list.
  @PROJECT_NAME             Version Information Editor.
  @PROJECT_DESC             Program that allows creation of resource source
                            files containining version information resources.
  @OTHER_NAMES              + Original unit name was EdDropDn.pas
                            + Changed to FmDropDownListEd.pas at v2.0
  @HISTORY(
    @REVISION(
      @VERSION              1.0
      @DATE                 25/05/1998
      @COMMENTS             Original version.
    )
    @REVISION(
      @VERSION              1.1
      @DATE                 13/04/1999
      @COMMENTS             Removed glyphs from buttons in form. Removed code
                            from form creation event that turns glyphs off. This
                            was incompatible with Delphi 2.
    )
    @REVISION(
      @VERSION              2.0
      @DATE                 18/03/2002
      @COMMENTS             Re-wrote dialog box to descend from TGenericOKDlg.
                            Removed all code for functionality that is now
                            provided in base class. This change also means that
                            button style and font face conforms to Window 95+
                            standards.
    )
  )
}


{
 * ***** BEGIN LICENSE BLOCK *****
 * 
 * Version: MPL 1.1
 * 
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with the
 * License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * 
 * The Original Code is FmDropDownListEd.pas.
 * 
 * The Initial Developer of the Original Code is Peter Johnson
 * (http://www.delphidabbler.com/).
 * 
 * Portions created by the Initial Developer are Copyright (C) 1998-2005 Peter
 * Johnson. All Rights Reserved.
 * 
 * Contributor(s):
 * 
 * ***** END LICENSE BLOCK *****
}


unit FmDropDownListEd;

interface

uses
  // Delphi
  StdCtrls, Controls, ExtCtrls, Classes,
  // Project
  FmGenericOKDlg;

type

  {
  TDropDownListEditor:
    Class that implements a dialog box containing a drop-down list control. The
    selected value is passed back to callers
  }
  TDropDownListEditor = class(TGenericOKDlg)
    lblDesc: TLabel;
    cmbDropDown: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private // properties
    fText: string;
    fKind: string;
    procedure SetList(const Value: TStringList);
  public
    property Kind: string write fKind;
      {Description of the kind of edit required - will be preceeded by 'Edit'}
    property List: TStringList write SetList;
      {The list of strings to choose from}
    property Text: string read fText write fText;
      {The chosen text (default can be provided by user)}
  end;

implementation

{$R *.DFM}

procedure TDropDownListEditor.btnOKClick(Sender: TObject);
  {Click event handler for OK button: stores combo box selection in Text
  property}
begin
  inherited;
  fText := cmbDropDown.Text;
end;

procedure TDropDownListEditor.FormShow(Sender: TObject);
  {Event handler called when form is shown: intialises controls}
var
  Index: Integer; // index of Text property item in combo box - if any
begin
  inherited;
  // Set up caption
  Caption := 'Edit ' + fKind;
  // Make default selection in combo box
  Index := cmbDropDown.Items.IndexOf(fText);
  if Index = -1 then
    Index := 0;
  cmbDropDown.ItemIndex := Index;
  // Set focus on edit box
  cmbDropDown.SetFocus;
end;

procedure TDropDownListEditor.SetList(const Value: TStringList);
  {Write access method for List property: copies list items into combo box}
begin
  cmbDropDown.Items := Value;
end;

end.