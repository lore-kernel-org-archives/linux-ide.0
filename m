From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24 ahci problem, does not boot (doesn't
 find SATA disk, i.e. failed to IDENTIFY)
Date: Thu, 24 Apr 2008 11:49:52 +0900
Message-ID: <480FF550.50802@gmail.com>
References: <1209002065.17082.30.camel@corfu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:59356 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYDXCuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 22:50:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1840988wra.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 19:50:00 -0700 (PDT)
In-Reply-To: <1209002065.17082.30.camel@corfu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guenther Thomsen <guenthert@gmail.com>
Cc: kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Guenther Thomsen wrote:
> Not sure, if this issue has been resolved meanwhile. The thread I found 
> indicated only that it is believed to be an interrupt routing issue.
> 
> I ran into this issue, when upgrading Ubuntu from 7.10 (kernel 
> 2.6.22-14) to 8.04rc (kernel 2.6.24-16) and added my findings to bug 
> 219312 (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/219312) .
> 
> --8<--
> [ 56.463297] SCSI subsystem initialized
> [ 56.477843] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 21 (level, low) 
> -> IRQ 21
> [ 56.478127] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
> [ 56.478178] ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
> [...]
> [ 57.480373] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3Gbps 
> 0xf impl SATA mode
> [ 57.480427] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum 
> part
> [ 57.481394] scsi0 : ahci
> [ 57.481710] scsi1 : ahci
> [ 57.481873] scsi2 : ahci
> [ 57.482040] scsi3 : ahci
> [ 57.955539] ata1: SATA link up 1.5Gbps (SStatus 113 SControl 300)
> [ 87.904552] ata1.00: qc timeout (cmd 0xec)
> [ 87.904608] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [ 87.904653] ata1: failed to recover some devices, retrying in 5 secs
> -->8--
> 
> A "pci=nomsi" got this kernel on its feet again, but if there is still 
> interest in kernel messages or other traces, then please let me know.

Can you please attach full boot log and the result of "lspci -nn"?

-- 
tejun
