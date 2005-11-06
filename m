From: Vladimir Dergachev <volodya@mindspring.com>
Subject: sil3112
Date: Sun, 6 Nov 2005 03:32:57 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0511060316570.8945@node2.an-vo.com>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:29071 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932332AbVKFIdE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Nov 2005 03:33:04 -0500
Received: from pimout5-ext.prodigy.net (pimout5-int.prodigy.net [207.115.4.21])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id jA68XQin003255
	for <linux-ide@vger.kernel.org>; Sun, 6 Nov 2005 03:33:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hi Jeff,

   I got myself a Sil3112 controller (cardbus card) with a Seagate SATA
driver (250 GB, .8 revision, with NCQ) and I read the status page on your 
site.

   Before I delve deeper, could you let me know whether there was any 
progress with this combination since you last updated the webpages ?

   Also, just in case, the little info I gathered so far:

      1. The seagate drive is in external SATA enclosure which came with
         a longer SATA cable. When I am using this cable the driver does
         not see the hard disk at all.

         When I use shorter cable I can get the sata_sil.c to see the
         drive.

      2. siimage.c driver (older one) does not appear to recognize the
         controller at all, despite valid PCI entry.

      3. There is a mysterious printout about "cache line size not set",
         not sure whether this is relevant as I saw it in other logs
         on the web. This might have to do with the fact that I have
         cardbus card.

      4. If I force IDE mode to UDMA5 (by forcing Maxtor fix) the
         drive access is more stable, I can do hdparm -t (with abysmal
         rates on the order of 0.5 MB/sec) and mke2fs gets along somewhat
         ok.

      5. mke2fs seems to freeze when trying to read some directory (not
         sure what exactly it is doing). I know this because when it
         froze I tried pulling out the cardbus card and after a while
         mke2fs printed out the call that failed.

      6. forcing mode below UDMA5 does not appear to have any effect.

      7. I have not tried using UDMA5 with longer SATA cable yet.

      8. forcing "Seagate fix" does not appear to do anything,
         but I could be wrong.

      9. Syba (the manufacturer of the card) has a "Redhat tweaker" that
         appears to be written by Andre Hendrik. This file forces the
         mode to UDMA5.

     10. Silicon image has binary drivers on their website which seem to
         come with some sort of bios file. This might be needed only for
         raid though..

   Any advice and hints are much appreciated :)

                  thank you !

                       Vladimir Dergachev
