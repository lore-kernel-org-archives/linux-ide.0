From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Mon, 9 May 2016 15:05:36 -0400
Message-ID: <20160509190536.GK7110@mtj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <yw1xmvnziofc.fsf@unicorn.mansr.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julian Margetson <runaway@candw.ms>, linux-ide@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-ide@vger.kernel.org

T24gTW9uLCBNYXkgMDksIDIwMTYgYXQgMTA6MTM6NTlBTSArMDEwMCwgTcOlbnMgUnVsbGfDpXJk
IHdyb3RlOgo+IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3Jp
dGVzOgo+IAo+ID4gT24gTW9uLCBNYXkgOSwgMjAxNiBhdCA0OjA5IEFNLCBUZWp1biBIZW8gPHRq
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4+IE9uIFN1biwgTWF5IDA4LCAyMDE2IGF0IDA0OjAwOjA4
UE0gLTA0MDAsIFRlanVuIEhlbyB3cm90ZToKPiA+Pj4gSGVsbG8sIEFuZHkuCj4gPj4+Cj4gPj4+
IE9uIFdlZCwgTWF5IDA0LCAyMDE2IGF0IDAzOjIyOjUxUE0gKzAzMDAsIEFuZHkgU2hldmNoZW5r
byB3cm90ZToKPiA+Pj4gPiBUZWp1biwgc2luY2UgVmlub2QgYXBwbGllZCBhbGwgbmVjZXNzYXJ5
IHBhdGNoZXMgaW50byBoaXMgdHJlZSwgdGhlCj4gPj4+ID4gc2VyaWVzIG5vdyBoYXMganVzdCBh
IGRlcGVuZGVuY3kgdG8gd2hhdGV2ZXIgYnJhbmNoIC8gdGFnIGhlIG1hcmtzIGZvcgo+ID4+PiA+
IGl0Lgo+ID4+PiA+IERvIHdlIGhhdmUgYSBjaGFuY2UgdG8gc2VlIHRoZSBTQVRBIHNlcmllcyBi
ZSBhcHBsaWVkIGluIHlvdXIgdHJlZT8KPiA+Pj4KPiA+Pj4gQXBwbGllZCAxLTIyIHRvIGxpYmF0
YS9mb3ItNC43LiAgVGhlcmUgd2FzIGEgY291cGxlIHRyaXZpYWwgY29uZmxpY3RzCj4gPj4+IHdo
aWNoIEkgcmVzb2x2ZWQgd2hpbGUgYXBwbHlpbmcgYnV0IGl0J2QgYmUgZ3JlYXQgaWYgeW91IGNh
biBjaGVjawo+ID4+PiB3aGV0aGVyIGV2ZXJ5dGhpbmcgbG9va3Mgb2theS4KPiA+Pj4KPiA+Pj4g
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RqL2xpYmF0YS5n
aXQvbG9nLz9oPWZvci00LjcKPiA+Pgo+ID4+IE9vcHMsIGJ1aWxkIGZhaWx1cmUuICBSZXZlcnRl
ZCBmb3Igbm93Lgo+ID4KPiA+IEkgc3VwcG9zZSB5b3UgaGF2ZSB0byBwdWxsIG1hdGVyaWFsIGZy
b20gVmlub2QuCj4gCj4gVGhlIGZhaWx1cmUgdGhlIGJ1aWxkIGJvdCByZXBvcnRlZCBpcyBkdWUg
dG8gdGhlIERNQSBwYXRjaGVzIG5vdCBiZWluZwo+IGluIHRoZSB0cmVlLgoKV2hpY2ggdHJlZSBz
aG91bGQgSSBwdWxsPwoKVGhhbmtzLgoKLS0gCnRlanVuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZv
L2xpbnV4cHBjLWRldg==
