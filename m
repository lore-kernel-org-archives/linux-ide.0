From: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [Bug 42679] New: DMA Read on Marvell 88SE9128 fails when Intel's
	IOMMU is on
Date: Mon, 30 Jan 2012 15:32:11 -0800
Message-ID: <20120130233211.GM24091@sequoia.sous-sol.org>
References: <bug-42679-27@https.bugzilla.kernel.org/>
	<20120130125934.7971c815.akpm@linux-foundation.org>
	<4F270E8C.2000406@redhat.com> <op.v8w3z0z0c3q55a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <op.v8w3z0z0c3q55a@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?utf-8?B?UGF3ZcWCIMW7YWs=?= <pawel.zaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

KiBQYXdlxYIgxbthayAocGF3ZWwuemFxQGdtYWlsLmNvbSkgd3JvdGU6Cj4gT24gTW9uLCAzMCBK
YW4gMjAxMiAyMjo0MTozMiArMDEwMCwgRG9uIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPiB3
cm90ZToKPiA+V2VsbCwgdGhlIGxzcGNpIGR1bXAgaW4gdGhlIGJ1Z3ppbGxhIHJlcG9ydCBkb2Vz
bid0IHNob3cgYSBkZXZpY2UKPiA+dy9CREY9MGI6MDAuMTsKPiA+c28sIGlmIHRoZSBTQVRBIGRl
dmljZSAod2hpY2ggaXMgMGI6MDAuMCkgaXMgc3BpdHRpbmcgb3V0IDBiOjAwLjEKPiA+YXMgdGhl
IHNvdXJjZQo+ID5vZiBhbnkgb2YgaXRzIERNQSBwYWNrZXRzLCB0aGUgSU9NTVUgd2lsbCBmYXVs
dCBvbiBpdCwgc2luY2UKPiA+MGI6MDAuMSBkaWRuJ3QKPiA+cmVxdWVzdCBETUEgbWFwcGluZ3Mg
KDBiOjAwLjAgZGlkKS4KPiA+SSBzZW1pLXJlY2FsbCBzb21lb25lIGVsc2UgcmVwb3J0aW5nIHRo
aXMgJ2ZlYXR1cmUnIG9uIHRoaXMgbGlzdC4KPiA+V29uZGVyIGlmIHBjaS1xdWlyayBoYXMgdG8g
ZmlsdGVyIHRoaXMgY2FzZSAoMGI6MDAuMCBvbiB0aGlzIHN5c3RlbSBtZWFucwo+ID5tYXAgZm9y
IDBiOjAwLjAgJiAwYjowMC4xIC0tIGljayEpCj4gPgo+ID5kbyBhbm90aGVyIGxzcGNpIC12dnYg
dG8gZW5zdXJlIHRoYXQgMGI6MDAuMSB3YXNuJ3QgZXhjbHVkZWQgaW4gdGhlIGxpc3QuCj4gPmlm
IGl0IGRvZXNuJ3QgZXhpc3QsIHRoZW4gdGhlIHByb2JsZW0gaXMgdGhlIFNBVEEgZGV2aWNlIHVz
aW5nIGFuCj4gPnVua25vd24vdW5yZWNvZ25pemVkCj4gPkJERiBvZiAwYjowMC4xCj4gCj4gWWVw
LCB0aGF0J3MgY29ycmVjdC4gSSBlbmFibGVkIGFsbCBpbnRlZ3JhdGVkIHBlcmlwaGVyYWxzIG9u
IG15Cj4gbW90aGVyYm9hcmQgYW5kIHRoZXJlIHdlcmUgc3RpbGwgbm8gZW50cmllcyB3aXRoIEJE
RiAwYjowMC4xIGluCj4gbHNwY2kgLXZ2diBvdXRwdXQuIFNob3VsZCBJIHRha2UgdGhpcyBwcm9i
bGVtIHRvIE1TSSB0aGVuPwoKWWVhaCwgc29tZXRoaW5nIGlzIG5vdCByaWdodC4gIElzIHRoZXJl
IGFueSBCSU9TIGNvbnRyb2wgb3ZlciB0aGF0CmRldmljZT8KCnRoYW5rcywKLWNocmlzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
