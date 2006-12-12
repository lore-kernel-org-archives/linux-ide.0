From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI detection issues
Date: Tue, 12 Dec 2006 11:24:30 +0900
Message-ID: <457E12DE.8070302@gmail.com>
References: <BMKOaDGU.1163330585.9395520.aaltoset@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:4628 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750926AbWLLCYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 21:24:37 -0500
Received: by nz-out-0102.google.com with SMTP id s1so912203nze
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 18:24:37 -0800 (PST)
In-Reply-To: <BMKOaDGU.1163330585.9395520.aaltoset@cs.helsinki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aaltoset@cs.helsinki.fi
Cc: linux-ide@vger.kernel.org

aaltoset@cs.helsinki.fi wrote:
> Hello,
> 
> I recently upgraded my system and I have an Asus P5W DH Deluxe
> motherboard. It has an Intel ICH7 chipset where the second SATA
> connector is used for a Sil4723 hardware RAID device. The Sil4723 has
> two SATA ports using the shared ICH7 port.
> 
> I have one Seagate Barracuda 7200.10 SATA drive connected to the first
> ICH7 port but the Linux kernel falsely detects another drive on ata2,
> which I believe to be on the Sil4723. With 2.6.17 this isn't a big
> problem, it just appears in dmesg but doesn't cause any problems.
> However, with 2.6.18 and later, the non-existent drive takes painfully
> long to detect and this appears in dmesg:
> 
> [   36.577431] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   66.506384] ata2.00: qc timeout (cmd 0xec)
> [   66.506389] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> [   74.340464] ata2: port is slow to respond, please be patient
> [   97.249998] ata2: port failed to respond (30 secs)
> [   97.250030] ata2: COMRESET failed (device not ready)
> [   97.250061] ata2: hardreset failed, retrying in 5 secs
> [  103.108459] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  103.108517] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
> [  103.108520] ata2.00: ata2: dev 0 multi count 1
> [  103.108589] ata2.00: configured for UDMA/133

Yeap, that one is on-board storage processor from Silicon Image.  It's
something similar to Port Multiplier and emulates ATA device but not
well enough apparently.  It on my todo list.

-- 
tejun
