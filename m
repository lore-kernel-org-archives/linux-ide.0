From: "Michael Gavlick" <mgavl69@juno.com>
Subject: Re: [PATCH] ide-iops: fix for drive side 80-wire cable detection failu
	re f or IBM-DJNA-371350 HD
Date: Mon, 28 Sep 2009 17:18:08 GMT
Message-ID: <20090928.131808.29003.0@webmail06.vgs.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-mail.vgs.untd.com ([64.136.55.15]:18040 "HELO
	outbound-mail.vgs.untd.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752149AbZI1RTb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Sep 2009 13:19:31 -0400
Received: from outbound-bu1.vgs.untd.com (webmail06.vgs.untd.com [10.181.12.146])
	by smtpout02.vgs.untd.com with SMTP id AABFNB6AEA7XAAM2
	for <linux-ide@vger.kernel.org> (sender <mgavl69@juno.com>);
	Mon, 28 Sep 2009 10:19:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikpe@it.uu.se
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

  I've tested only on my own rig with 'known good' 80-wire cables and similar UDMA/66 HD's from Quantum & Seagate without any problems as a single master and a master/slave setup.
  I've also tested the IBM-DJNA-371350 as a single master but it still complains about the 80-wire.

Here's the full output for the controller and drives:
amd74xx 0000:00:06.0: UDMA133 controller
amd74xx 0000:00:06.0: IDE controller (0x10de:0x03ec rev 0xa2)
amd74xx 0000:00:06.0: IDE port disabled
amd74xx 0000:00:06.0: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xf000-0xf007
Probing IDE interface ide0...
hda: IC35L020AVVA07-0, ATA DISK drive
hdb: IBM-DJNA-371350, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: skipping word 93 validity check
hdb: UDMA/66 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39102336 sectors (20020 MB) w/1863KiB Cache, CHS=38792/16/63
hda: cache flushes supported
hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 26712000 sectors (13676 MB) w/1966KiB Cache, CHS=26500/16/63
hdb: cache flushes not supported
hdb: hdb1 hdb2


____________________________________________________________
Click here for great quotes from top international movers!
http://thirdpartyoffers.juno.com/TGL2131/fc/BLSrjnsKdC5Yn1q3PFnPdCgRLI4c75mnvWkMCAAJlN0ufwRLtHzCJ2EfhC4/
