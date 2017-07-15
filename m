From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH, RESEND 02/14] ata: avoid gcc-7 warning in
 ata_timing_quantize
Date: Sat, 15 Jul 2017 06:56:01 -0400
Message-ID: <20170715105601.GC2969123@devbig577.frc2.facebook.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714092540.1217397-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20170714092540.1217397-3-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Hannes Reinecke <hare@suse.de>, Adam Manzanares <adam.manzanares@wdc.com>, akpm@linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

T24gRnJpLCBKdWwgMTQsIDIwMTcgYXQgMTE6MjU6MTRBTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToKPiBnY2MtNyB3YXJucyBhYm91dCB0aGUgcmVzdWx0IG9mIGEgY29uc3RhbnQgbXVsdGlw
bGljYXRpb24gdXNlZCBhcwo+IGEgYm9vbGVhbjoKPiAKPiBkcml2ZXJzL2F0YS9saWJhdGEtY29y
ZS5jOiBJbiBmdW5jdGlvbiAnYXRhX3RpbWluZ19xdWFudGl6ZSc6Cj4gZHJpdmVycy9hdGEvbGli
YXRhLWNvcmUuYzozMTY0OjMwOiB3YXJuaW5nOiAnKicgaW4gYm9vbGVhbiBjb250ZXh0LCBzdWdn
ZXN0ICcmJicgaW5zdGVhZCBbLVdpbnQtaW4tYm9vbC1jb250ZXh0XQo+IAo+IFRoaXMgc2xpZ2h0
bHkgcmVhcnJhbmdlcyB0aGUgbWFjcm8gdG8gc2ltcGxpZnkgdGhlIGNvZGUgYW5kIGF2b2lkCj4g
dGhlIHdhcm5pbmcgYXQgdGhlIHNhbWUgdGltZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGFybmRiLmRlPgoKSWYgdGhlIHdob2xlIHNlcmllcyB3aWxsIGJlIHJvdXRl
ZCB0b2dldGhlciwKCiBBY2tlZC1ieTogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPgoKSWYgbm90
LCBwbGVhc2UgbGV0IG1lIGtub3cuICBJJ2xsIHB1c2ggaXQgdGhyb3VnaApsaWJhdGEvZm9yLTQu
MTMtZml4ZXMuCgpUaGFua3MhCgotLSAKdGVqdW4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
