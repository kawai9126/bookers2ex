require 'rails_helper'
	 
describe '投稿のテスト' do
    let!(:book) { create(:book,title:'hoge',body:'body') }
    describe 'トップ画面(root_path)のテスト' do
        before do 
            visit root_path
        end
        context '表示の確認' do
            it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
                expect(page).to have_link "", href: books_path
            end
            it 'root_pathが"/"であるか' do
                expect(current_path).to eq('/')
            end
        end
    end
    describe "一覧画面のテスト" do
        before do
            visit books_path
        end
        context '一覧の表示とリンクの確認' do
            it "bookの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか" do
                expect(page).to have_selector 'table'
                expect(page).to have_field 'book[title]'
                expect(page).to have_field 'book[body]'
            end
            it "bookのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか" do
                (1..5).each do |i|
                    Book.create(title:'hoge'+i.to_s,body:'body'+i.to_s)
                end
                visit books_path
                Book.all.each_with_index do |book,i|
                    j = i * 3
                    expect(page).to have_content book.title
                    expect(page).to have_content book.body
                    # Showリンク
                    show_link = find_all('a')[j]
                    expect(show_link.native.inner_text).to match(/show/i)
                    expect(show_link[:href]).to eq book_path(book)
                    # Editリンク
                    show_link = find_all('a')[j+1]
                    expect(show_link.native.inner_text).to match(/edit/i)
                    expect(show_link[:href]).to eq edit_book_path(book)
                    # Destroyリンク
                    show_link = find_all('a')[j+2]
                    expect(show_link.native.inner_text).to match(/destroy/i)
                    expect(show_link[:href]).to eq book_path(book)
                end
            end
        end
    end
end