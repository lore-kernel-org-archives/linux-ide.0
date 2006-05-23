From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH 1/1] 2.4.32 Fix memory leak in ide-probe
Date: Mon, 22 May 2006 21:47:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.10.10605222145180.32622-200000@master.linux-ide.org>
References: <200605221132.15134.npollitt@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430320608-327355726-1148359644=:32622"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-252.ca.astound.net ([64.85.224.252]:29706
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S1751251AbWEWE5c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 00:57:32 -0400
In-Reply-To: <200605221132.15134.npollitt@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Pollitt <npollitt@mvista.com>, linux-ide@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430320608-327355726-1148359644=:32622
Content-Type: text/plain; charset=us-ascii


Nick,

If it works please forward the results and other information to everyone

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 22 May 2006, Nick Pollitt wrote:

> Andre,  I found this memory leak running a bash loop calling cardctl to insert 
> and eject a single PCMCIA card continuously.  Over time the slab-32 and slab-64
> caches had consumed all system memory.  The memory was full of the IDE
> settings allocated in ide_add_generic_settings.  
> 
> It appears that ide_add_generic_settings is getting called for interfaces that
> aren't present, and there are never any calls to free up those resources.  The
> check for the presence of the interface was removed in 2.4.19, and this patch
> rolls back to the previous behavior.
> 
> If this looks OK I'd like to ask Marcello to include in the next 2.4 rev.
> 
> Thank you,
> Nick
> 


--1430320608-327355726-1148359644=:32622
Content-Type: text/plain; charset=us-ascii; name="ide-memleak-2432.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10605222147240.32622@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="ide-memleak-2432.patch"

ZGlmZiAtWCBkb250ZGlmZiAtTnVycCBsaW51eC0yLjQuMzItb3JpZy9kcml2
ZXJzL2lkZS9pZGUtcHJvYmUuYyBsaW51eC0yLjQuMzIvZHJpdmVycy9pZGUv
aWRlLXByb2JlLmMNCi0tLSBsaW51eC0yLjQuMzItb3JpZy9kcml2ZXJzL2lk
ZS9pZGUtcHJvYmUuYwkyMDA0LTA0LTE0IDA2OjA1OjI5LjAwMDAwMDAwMCAt
MDcwMA0KKysrIGxpbnV4LTIuNC4zMi9kcml2ZXJzL2lkZS9pZGUtcHJvYmUu
YwkyMDA2LTA1LTIyIDEwOjU5OjU0LjQ5NDgxMDQxMiAtMDcwMA0KQEAgLTEy
NDEsMTUgKzEyNDEsMTUgQEAgc3RhdGljIHZvaWQgaW5pdF9nZW5kaXNrIChp
ZGVfaHdpZl90ICpodw0KIAlhZGRfZ2VuZGlzayhnZCk7DQogDQogCWZvciAo
dW5pdCA9IDA7IHVuaXQgPCB1bml0czsgKyt1bml0KSB7DQotCQljaGFyIG5h
bWVbNjRdOw0KLQkJaWRlX2FkZF9nZW5lcmljX3NldHRpbmdzKGh3aWYtPmRy
aXZlcyArIHVuaXQpOw0KLS8vCQlod2lmLT5kcml2ZXNbdW5pdF0uZG4gPSAo
KGh3aWYtPmNoYW5uZWwgPyAyIDogMCkgKyB1bml0KTsNCi0JCXNwcmludGYg
KG5hbWUsICJob3N0JWQvYnVzJWQvdGFyZ2V0JWQvbHVuJWQiLA0KLQkJCSho
d2lmLT5jaGFubmVsICYmIGh3aWYtPm1hdGUpID8NCi0JCQlod2lmLT5tYXRl
LT5pbmRleCA6IGh3aWYtPmluZGV4LA0KLQkJCWh3aWYtPmNoYW5uZWwsIHVu
aXQsIGh3aWYtPmRyaXZlc1t1bml0XS5sdW4pOw0KLQkJaWYgKGh3aWYtPmRy
aXZlc1t1bml0XS5wcmVzZW50KQ0KKwkJaWYgKGh3aWYtPmRyaXZlc1t1bml0
XS5wcmVzZW50KSB7DQorCQkJY2hhciBuYW1lWzY0XTsNCisJCQlpZGVfYWRk
X2dlbmVyaWNfc2V0dGluZ3MoaHdpZi0+ZHJpdmVzICsgdW5pdCk7DQorCQkJ
c3ByaW50ZiAobmFtZSwgImhvc3QlZC9idXMlZC90YXJnZXQlZC9sdW4lZCIs
DQorCQkJCShod2lmLT5jaGFubmVsICYmIGh3aWYtPm1hdGUpID8NCisJCQkJ
aHdpZi0+bWF0ZS0+aW5kZXggOiBod2lmLT5pbmRleCwNCisJCQkJaHdpZi0+
Y2hhbm5lbCwgdW5pdCwgaHdpZi0+ZHJpdmVzW3VuaXRdLmx1bik7DQogCQkJ
aHdpZi0+ZHJpdmVzW3VuaXRdLmRlID0gZGV2ZnNfbWtfZGlyKGlkZV9kZXZm
c19oYW5kbGUsIG5hbWUsIE5VTEwpOw0KKwkJfQ0KIAl9DQogCXJldHVybjsN
CiANCg==
--1430320608-327355726-1148359644=:32622--
