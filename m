From: viresh kumar <viresh.kumar@st.com>
Subject: MWDMA Issue: sda: unknown partition table
Date: Fri, 21 Jan 2011 15:39:56 +0530
Message-ID: <4D395B74.1010705@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:33558 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126Ab1AUKKY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2011 05:10:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, Amit GOEL <amit.goel@st.com>


Hi,

I am implementing mwdma interface for arasan compact flash controller.
I am facing a strange problem, when i insert CF card on my board (after bootup),
in mwdma mode, i get following:

ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata1: soft resetting link
ata1.00: CFA: TRANSCEND, 20091215, max UDMA/66
ata1.00: 62537328 sectors, multi 0: LBA 
ata1.00: configured for MWDMA4
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2009 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 62537328 512-byte logical blocks: (32.0 GB/29.8 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk


I tried PIO mode on same card and it worked fine i got sda1 created.
I suspected that there is some problem with DMA, so i took dump of all data read by PIO
and DMA. After configuring in MWDMA4 mode at:
ata1.00: configured for MWDMA4
a read request of 4096 bytes occurs (both in PIO (handled by libata-sff) and MWDMA).

These 4096 bytes are exactly same in case of PIO and MWDMA. Also all data read before configuring
MWDMA4 mode is also same, as that is done by common PIO code.

In my interrupt handler, after controller specific code i am calling:
ata_bmdma_interrupt(irq, dev);

also i am returning ATA_DMA_INTR from my bmdma_status routine.
ata_port_operations is:

static struct ata_port_operations arasan_cf_ops = {
	.inherits		= &ata_bmdma_port_ops,
	.set_piomode		= arasan_cf_set_piomode,
	.set_dmamode		= arasan_cf_set_dmamode,
	.bmdma_setup		= arasan_cf_bmdma_setup,
	.bmdma_start		= arasan_cf_bmdma_start,
	.bmdma_stop		= arasan_cf_bmdma_stop,
	.bmdma_status		= arasan_cf_bmdma_status,
	.sff_irq_clear		= arasan_cf_bmdma_irq_clear,
};

There are no BMDMA registers in my controller.

Can somebody give any clue on which part i should try to look at?

thanks in advance,
viresh
