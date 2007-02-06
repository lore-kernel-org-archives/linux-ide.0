From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] libata: Fix (hopefully) all the remaining problems with
 devices failing setup/identify
Date: Tue, 6 Feb 2007 14:42:30 +0100
Message-ID: <20070206144230.5421c01d@dhcp-252-105.norway.atmel.com>
References: <20070131172605.2c5dfc78@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752180AbXBFNmk@vger.kernel.org>
In-Reply-To: <20070131172605.2c5dfc78@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, 31 Jan 2007 17:26:05 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> Two fixes in this test patch. One of them allows old CF cards to refuse
> pio mode setting, and one to wait for the drive to settle after a set
> features changes the speed settings, which is based upon the workarounds
> used by drivers/ide.
> 
> Please test and report back if you have an afflicted system. This patch
> isn't for merging just testing.

Just ran into the CF problem you describe when implementing support for
CompactFlash on AVR32 using an old 32 MB TwinMos card. Works fine with
this patch applied; without it, libata gives up after failing to set
xfermode (err_mask=0x1).

> The CF card fix will still display errors when the card works (got fixes
> for that once I know the cure works) but should then be found/usable.

Actually, I don't see any errors, but the card comes up in PIO0 mode
(which is correct behaviour as far as I can tell):

ata1: PATA max PIO0 cmd 0xA4800000 ctl 0xA480000E bmdma 0x0 irq 67
scsi0 : pata_pcmcia
ata1.00: CFA, max PIO0, 62592 sectors: LBA
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for PIO0
scsi 0:0:0:0: Direct-Access     ATA      32MB CHH         Rev  PQ: 0 ANSI: 5

Thanks for the patch. I would probably have spent a long time debugging
this without it.

Haavard
