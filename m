From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Removal of MOD_{INC,DEC}_USE_COUNT in ide-cs
Date: Mon, 19 Apr 2004 16:05:37 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0404191549200.18574@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1189669822-1082404198=:18574"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:1734 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261830AbUDSUFe
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Apr 2004 16:05:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.24)
	id 1BFf0J-0003mj-Bj
	for linux-ide@vger.kernel.org; Mon, 19 Apr 2004 16:04:31 -0400
Content-ID: <Pine.LNX.4.58.0404191550050.18574@marabou.research.att.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1189669822-1082404198=:18574
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0404191550051.18574@marabou.research.att.com>

Hello!

I posted this patch to linux-pcmcia@lists.infradead.org, but Russell King
asked me to post the patch to the IDE list instead.

The "ide-cs" module cannot be unloaded because it uses obsolete
MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT macros.  In fact, they are not
needed in ide-cs.c in 2.6 kernels.  The generic PCMCIA code already
increases use count for every device served by the driver, so it's
impossible to unload the ide-cs driver while it's in use.

I was told that the removal of IDE interfaces may be unsafe in 2.6
kernels.  However, MOD_INC_USE_COUNT only prevents removal of the module,
not the interface.  It's also the first obstacle, albeit a trivial one,
for anybody debugging those problems (i.e. loading a modified module
requires "rmmod -f" or reboot to unload the old version).

With MOD_INC_USE_COUNT "cardctl eject" and physical eject will still
unregister the IDE interface, but the module will stay in memory.

I tested two IDE PCMCIA devices yesterday with Linux 2.6.6-rc1 and got
following results.

CompactFlash IDE drive is working fine.  On unload, there is a kernel
warning and stack dump in devfs_remove.  It's just a warning that some
nonexistent entry is removed.  It's a bug in ide-disk.c, and I submitted a
patch to this list yesterday.  There have been no problems and no warnings
after that fix, even if ide-cs is loaded and unloaded every time.

PCMCIA LS-120 drive is detected by ide-cs but the kernel panics when the
card is ejected.  It didn't work in my test because I didn't have
ide-floppy support in the kernel.  I believe this fact triggers the panic.
The IDE drivers need to be fixed not to crash without ide-floppy support.
Also, ide-cs should be tested with ide-floppy support.  I'm away from that
device now, but I can post the stack dump if anyone is interested.

I believe that MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT are safe to remove
from ide-cs.c.  The patch is attached.

-- 
Regards,
Pavel Roskin
--8323328-1189669822-1082404198=:18574
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ide-cs-moduse.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404191549580.18574@marabou.research.att.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ide-cs-moduse.diff"

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9pZGUvbGVnYWN5L2lkZS1jcy5jDQor

KysgbGludXgvZHJpdmVycy9pZGUvbGVnYWN5L2lkZS1jcy5jDQpAQCAtMzYy

LDcgKzM2Miw2IEBAIHZvaWQgaWRlX2NvbmZpZyhkZXZfbGlua190ICpsaW5r

KQ0KIAlnb3RvIGZhaWxlZDsNCiAgICAgfQ0KIA0KLSAgICBNT0RfSU5DX1VT

RV9DT1VOVDsNCiAgICAgaW5mby0+bmRldiA9IDE7DQogICAgIHNwcmludGYo

aW5mby0+bm9kZS5kZXZfbmFtZSwgImhkJWMiLCAnYScrKGhkKjIpKTsNCiAg

ICAgaW5mby0+bm9kZS5tYWpvciA9IGlkZV9tYWpvcltoZF07DQpAQCAtNDA4

LDcgKzQwNyw2IEBAIHZvaWQgaWRlX3JlbGVhc2UoZGV2X2xpbmtfdCAqbGlu

aykNCiAJaWYgKGxpbmstPmlvLk51bVBvcnRzMikNCiAJICAgIHJlcXVlc3Rf

cmVnaW9uKGxpbmstPmlvLkJhc2VQb3J0MiwgbGluay0+aW8uTnVtUG9ydHMy

LA0KIAkJCSAgIGluZm8tPm5vZGUuZGV2X25hbWUpOw0KLQlNT0RfREVDX1VT

RV9DT1VOVDsNCiAgICAgfQ0KICAgICBpbmZvLT5uZGV2ID0gMDsNCiAgICAg

bGluay0+ZGV2ID0gTlVMTDsNCg==


--8323328-1189669822-1082404198=:18574--
