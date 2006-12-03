From: Olaf Hering <olaf@aepfle.de>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Sun, 3 Dec 2006 23:24:49 +0100 (MET)
Message-ID: <20061203222450.GA23765@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
 <20061203171216.GB21947@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:58220 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1759730AbWLCWYx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 17:24:53 -0500
Content-Disposition: inline
In-Reply-To: <20061203171216.GB21947@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Sun, Dec 03, Olaf Hering wrote:

> [  194.947620] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  194.947628] ata1.00: (BMDMA stat 0x41)
> [  194.947693] ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> [  194.947714] ata1: soft resetting port
> [  195.448133] ata1.00: configured for MWDMA2
> [  195.448157] ata1: EH complete
> [  200.450116] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> [  200.450124] ata1.00: (BMDMA stat 0x41)
> [  200.450132] ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
> [  200.450153] ata1: soft resetting port
> [  200.945670] ata1.00: configured for MWDMA2
> [  200.945695] ata1: EH complete

This change seems to fix it, only a single reset occurs. I think that
one is normal when a CD is in the drive during bootup, maybe it leaves
the drive in a confused state.

@@ -167,9 +175,13 @@ static void sl82c105_reset_engine(struct
        struct pci_dev *pdev = to_pci_dev(ap->host->dev);
        u16 val;

+       udelay(42);
        pci_read_config_word(pdev, 0x7E, &val);
+       udelay(10);
        pci_write_config_word(pdev, 0x7E, val | 4);
+       udelay(10);
        pci_write_config_word(pdev, 0x7E, val & ~4);
+       udelay(42);
 }

 /**


