From: Andreas Mohr <andi@lisas.de>
Subject: [BUG] 2.6.29-rc2-git1 to -rc5: libata lockup on boot, LED solid,
	100% CPU
Date: Mon, 16 Feb 2009 21:06:43 +0100
Message-ID: <20090216200643.GA2393@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:58322 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZBPUNy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 15:13:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello all,

My Inspiron 8000 ICH2 (i810) P3/700 UP has a hard time booting 2.6.29 things:

[loaded init, shell stuff]
...
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
ata1: EH complete
...
Uniform CD-ROM driver Revision: 3.20
[LAST LINE, FULL STOP]
---> hangs with IDE LED solidly on! <---

NOTE: kernel did NOT hang when accidentally running rc2-git1 w/o any modules loaded!
(IOW, probably a module-related hang)
disabling sr_mod.ko will make a boot proceed a tiny bit, then hang anyway

Could be mutex deadlock (CPU hot, 100%?)
no log errors whatsoever
latest known working: .28-rc6 (admittedly somewhat old; DOES work currently)
earliest known buggy: -rc2-git1, -rc4 also, -rc5 also
no SysRq available (notebook keys: no workey, /proc/sysrq obviously
not available either)

Should I test 2.6.28.5? Every build will take two hours though...
Not ATA-SFF 32bit bug problem, right? (already committed?)
http://marc.info/?l=linux-kernel&m=123254501314058&w=2
CONFIG_LOCK_STAT is NOT set/guilty here http://lkml.org/lkml/2009/2/16/5
Will try disabling CD-ROM drives in BIOS or so.
Any other promising ideas/patches available? libata logging? mutex
logging?

CC'd Tejun since he's been a miracle to work with recently concerning
all things ATA ;)

On a related note, -rc4 works nicely on my Aspire One, despite me
betting that it would end up with at least two new major issues again...
(note: plus full UDMA/66 after resume! - Tejun)
-rc5 on a P4HT blue skies, too...
Maybe kernel quality doesn't actually degrade after all...

Thanks,

Andreas Mohr
