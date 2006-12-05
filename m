From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Tue, 5 Dec 2006 00:31:08 +0000
Message-ID: <20061205003108.2b22f665@localhost.localdomain>
References: <200612031834.16797.sven@linux4geeks.de>
	<45735B51.5040501@gmx.net>
	<20061204001114.066b10f3@localhost.localdomain>
	<457370CB.60008@gmx.net>
	<20061204125637.539c102d@localhost.localdomain>
	<4574B968.1070709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46559 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S967905AbWLEAZj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 19:25:39 -0500
In-Reply-To: <4574B968.1070709@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Sven Ladegast <sven@linux4geeks.de>, uwe.koziolek@web.de, linux-ide@vger.kernel.org

> > is that sufficient for you to attach the PATA port to the PATA methods
> > for this chipset ?
> >
> > Alan
> >   
> It should be sufficient .

Consider it done

Signed-off-by: Alan Cox <alan@redhat.com>

Please push with the SATA driver changes to use it.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_sis.c linux-2.6.19-rc6-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_sis.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_sis.c	2006-12-04 12:35:23.302072176 +0000
@@ -766,6 +768,8 @@
 	.port_ops	= &sis_133_early_ops,
 };
 
+/* Privately shared with the SiS180 SATA driver, not for use elsewhere */
+EXPORT_SYMBOL_GPL(sis_info133);
 
 static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 {
