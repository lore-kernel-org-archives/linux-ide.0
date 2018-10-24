From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Date: Wed, 24 Oct 2018 09:57:00 +0100
Message-ID: <20181024085700.GR30658@n2100.armlinux.org.uk>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: Gilles.Muller@lip6.fr, maxime.ripard@bootlin.com, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, paulus@samba.org, linux-amlogic@lists.infradead.org, cocci@systeme.lip6.fr, mpe@ellerman.id.au, narmstrong@baylibre.com, galak@kernel.crashing.org, airlied@linux.ie, wens@csie.org, joabreu@synopsys.com, vitb@kernel.crashing.org, mporter@kernel.crashing.org, agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au, nicolas.palix@imag.fr, oss@buserror.net, Julia.Lawall@lip6.fr, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org, michal.lkml@markovi.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@baylibre.com, carlo@caione.org, tj@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: linux-ide@vger.kernel.org

T24gV2VkLCBPY3QgMjQsIDIwMTggYXQgMDc6MzU6NDZBTSArMDAwMCwgQ29yZW50aW4gTGFiYmUg
d3JvdGU6Cj4gVGhpcyBwYXRjaHNldCBhZGRzIGEgbmV3IHNldCBvZiBmdW5jdGlvbnMgd2hpY2gg
YXJlIG9wZW4tY29kZWQgaW4gbG90IG9mCj4gcGxhY2UuCj4gQmFzaWNseSB0aGUgcGF0dGVybiBp
cyBhbHdheXMgdGhlIHNhbWUsICJyZWFkLCBtb2RpZnkgYSBiaXQsIHdyaXRlIgo+IHNvbWUgZHJp
dmVyIGFuZCB0aGUgcG93ZXJwYyBhcmNoIGFscmVhZHkgaGF2ZSB0aG9zZXMgcGF0dGVybiB0aGVt
IGFzIGZ1bmN0aW9ucy4gKGxpa2UgYWhjaV9zdW54aS5jIG9yIGR3bWFjLW1lc29uOGIpCgpUaGUg
YWR2YW50YWdlIG9mIHRoZW0gYmVpbmcgb3Blbi1jb2RlZCBpcyB0aGF0IGl0J3MgX29idmlvdXNf
IHRvIHRoZQpyZXZpZXdlciB0aGF0IHRoZXJlIGlzIGEgcmVhZC1tb2RpZnktd3JpdGUgZ29pbmcg
b24gd2hpY2gsIGluIGEgbXVsdGktCnRocmVhZGVkIGVudmlyb25tZW50LCBtYXkgbmVlZCBzb21l
IGxvY2tpbmcgKHNvIGl0IHNob3VsZCB0cmlnZ2VyIGEKcmV2aWV3IG9mIHRoZSBsb2NraW5nIGFy
b3VuZCB0aGF0IGNvZGUuKQoKV2l0aCBpdCBoaWRkZW4gaW5zaWRlIGEgaGVscGVyIHdoaWNoIGhh
cyBubyBsb2NraW5nIGl0c2VsZiwgaXQgYmVjb21lcwptdWNoIGVhc2llciB0byBwYXNzIG92ZXIg
aW4gcmV2aWV3LCB3aGljaCBtZWFucyB0aGF0IHJhY2VzIGFyZSBtdWNoCm1vcmUgbGlrZWx5IHRv
IGdvIHVuc3BvdHRlZCAtIGFuZCB0aGF0IGlzIGJhZCBuZXdzLgoKLS0gClJNSydzIFBhdGNoIHN5
c3RlbTogaHR0cDovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvCkZUVEMg
YnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmUgaW4gc3VidXJiaWE6IHN5bmMgYXQgMTIuMU1icHMg
ZG93biA2MjJrYnBzIHVwCkFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0OiAxMS45TWJwcyBkb3du
IDUwMGticHMgdXAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cg==
