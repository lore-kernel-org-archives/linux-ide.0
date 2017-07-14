From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, RESEND 03/14] drm/vmwgfx: avoid gcc-7 parentheses warning
Date: Fri, 14 Jul 2017 12:21:13 -0700
Message-ID: <CA+55aFw9xE_+qnx1=6FbU8HJ23+Go1iS5bxDLOHefETgn5Wx6w@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714092540.1217397-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170714092540.1217397-4-arnd@arndb.de>
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
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, IDE-ML <linux-ide@vger.kernel.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Tejun Heo <tj@kernel.org>, Brian Paul <brianp@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

T24gRnJpLCBKdWwgMTQsIDIwMTcgYXQgMjoyNSBBTSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5k
Yi5kZT4gd3JvdGU6Cj4gLSAgICAgICByZXR1cm4gY2FwYWJsZShDQVBfU1lTX0FETUlOKSA/IDog
LUVJTlZBTDsKPiArICAgICAgIHJldHVybiBjYXBhYmxlKENBUF9TWVNfQURNSU4pID8gMSA6IC1F
SU5WQUw7CgpOQUsuIFRoaXMgdGFrZXMgdW5pbnRlbnRpb25hbGx5IGluc2FuZSBjb2RlIGFuZCB0
dXJucyBpdCBpbnRlbnRpb25hbGx5Cmluc2FuZS4gQW55IG5vbi16ZXJvIHJldHVybiBpcyBjb25z
aWRlcmVkIGFuIGVycm9yLgoKVGhlIHJpZ2h0IGZpeCBpcyBhbG1vc3QgY2VydGFpbmx5IHRvIGp1
c3QgcmV0dXJuIC1FSU5WQUwgdW5jb25kaXRpb25hbGx5LgoKICAgICAgICAgICAgICAgICAgTGlu
dXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
