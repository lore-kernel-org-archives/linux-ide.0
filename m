From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ExpressCard compact flash card very slow
Date: Tue, 22 Feb 2011 23:48:18 -0600
Message-ID: <4D649FA2.5010204@gmail.com>
References: <4D645C59.8090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52927 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab1BWFsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 00:48:22 -0500
Received: by qwd7 with SMTP id 7so3481592qwd.19
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2011 21:48:21 -0800 (PST)
In-Reply-To: <4D645C59.8090406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damon Lynch <damonlynch@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/22/2011 07:01 PM, Damon Lynch wrote:
> When using a Lexar ExpressCard CompactFlash (CF) reader in an
> ExpressCard slot, the speed of this high speed device is very slow
> (relatively speaking, of course).It performs at ~28MB/s instead of
> ~80MB/s it should be with a fast CompactFlash card.
>
> This is the product:
> http://www.lexar.com/products/lexar-professional-expresscard-compactflash-cf-reader?category=213
>
>
> The CF card can run at UDMA/133, but is set to run at UDMA/33.
>
> $dmesg
>
> [ 1.687119] scsi0 : pata_jmicron
> [ 1.692480] scsi1 : pata_jmicron
> [ 1.692523] ata1: PATA max UDMA/100 cmd 0x4020 ctl 0x4014 bmdma 0x4000
> irq 19
> [ 1.692525] ata2: PATA max UDMA/100 cmd 0x4018 ctl 0x4010 bmdma 0x4008
> irq 19
> [ 1.870088] usb 1-6: new high speed USB device using ehci_hcd and address 3
> [ 1.890676] ata1.00: CFA: TRANSCEND, 20091215, max UDMA/133
> [ 1.890678] ata1.00: 125059072 sectors, multi 0: LBA
> [ 1.890681] ata1.00: limited to UDMA/33 due to 40-wire cable
> [ 1.930831] ata1.00: configured for UDMA/33
> [ 1.930984] scsi 0:0:0:0: Direct-Access ATA TRANSCEND 2009 PQ: 0 ANSI: 5
> [ 1.931132] sd 0:0:0:0: [sda] 125059072 512-byte logical blocks: (64.0
> GB/59.6 GiB)
> [ 1.931144] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [ 1.931181] sd 0:0:0:0: [sda] Write Protect is off
> [ 1.931184] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [ 1.931371] sd 0:0:0:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [ 1.932525] sda: sda1
> [ 1.932904] sd 0:0:0:0: [sda] Attached SCSI disk

The CF adapter probably doesn't support the 80-wire cable detect 
protocol properly so the kernel thinks there's only a 40-wire cable 
connected to it. You can try libata.force=80c on the kernel command line 
and see what that does.
