From: Nils Faerber <nils.faerber@kernelconcepts.de>
Subject: SATA DVD issue...
Date: Mon, 09 Aug 2010 16:22:07 +0200
Message-ID: <4C600F0F.2010102@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:43383 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab0HIOlO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Aug 2010 10:41:14 -0400
Received: from [192.168.2.151]
	by mail.kernelconcepts.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1OiTJI-00050n-4d
	for linux-ide@vger.kernel.org; Mon, 09 Aug 2010 16:26:40 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!
I am trying to use a SATA DVD burner on a Marvell Kirkwood based
platform, kernel is currently based on vanilla 2.6.34 with only board
specific patches.

SATA in general works just fine with harddisks.

But when I attach my DVD drive any data read or write access triggers a
BUG() in libata-sff.c:

ata_bmdma_qc_issue():
...
        /* see ata_dma_blacklisted() */
        BUG_ON((ap->flags & ATA_FLAG_PIO_POLLING) &&
               qc->tf.protocol == ATAPI_PROT_DMA);
...

Command access (e.g. to eject the media or to erase a R/W disc) do work.

My knowledge about ATA and SATA is quite limited so I cannot really
interpret this issue.

After some looking around and with the hint in the comment I tried
blacklisting my drive, so I added an entry to libata-core.c:

        { "HL-DT-ST DVDRAM GH22LS50", "TL01",           ATA_HORKAGE_NODMA },

Now the drive works but it is awefully slow - reading just a little over
1MB/s - well, without DMA mode this is quite expectable.

I suspect that the Marvell SATA host driver should be OK and is not in
fault - it is widely used in PCI setups and the SOC variant does almost
not differ. And I also suspect that the above "fix" is not the best way
to do it.
I also tried the same driver with a USB-SATA connector (I do not have a
SATA PC at hand right now) and there it behaves pretty normal with 5 to
10 times higher read rates.


I would be more than happy if someone could help me diagnosing and
especially fixing this problem. If I can give more information or try
different things on the board just let know!

Many thanks in advance!

Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
