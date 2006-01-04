From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: [git patches] 2.6.x libata updates
Date: Wed, 04 Jan 2006 22:25:15 +0000
Message-ID: <43BC4B4B.8050900@projecthugo.co.uk>
References: <20060103164319.GA402@havoc.gtf.org> <43BC3186.8060103@projecthugo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host81-138-64-234.in-addr.btopenworld.com ([81.138.64.234]:43206
	"HELO alesi.projecthugo.co.uk") by vger.kernel.org with SMTP
	id S1030302AbWADWZR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jan 2006 17:25:17 -0500
In-Reply-To: <43BC3186.8060103@projecthugo.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Darcy <kernel-lists@projecthugo.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Matt Darcy wrote:

> Jeff Garzik wrote:
>
>> Please pull from 'upstream' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to receive the following updates:
>>  
>>
> <snip>
>
> Well I've been using this update now for a few days.
>
> For my own personal problem (sata_mv stability) I see both positive 
> and negative results over both 2.6.15-rc5-mm3 and 2.6.15
>
> First postitive:
>
> The bug I was experiening of a raid array 5 array not being visiable 
> or startable due to array disks being not being seen as part of the 
> array after a reboot appears to have gone. I say appears to as I can't 
> test this %100 due to the negative aspect of this kernel. the array 
> starts building - no problems gets about %35 through, and the whole 
> machine just hangs total lock up.
>
> The reason this is still positive is because when I reboot the box, 
> the unfinished md starts rebuilding again, suggesting that this kernel 
> actually sees all the disks in the array after a reboot (which 
> 2.6.15-rc5-mm3 wasn't)
>
> the hang of the system is pretty fatal though.
>
> I'd be interested in what other people are seeing with this kernel tree.
>
> I'm about to test a theroy of building the array with 2.6.15-rc5-mm3 
> which can build the array fine, but it dissapears after a reboot, but 
> on reboot I'll reboot into the latest libata-git kernel to see if the 
> disks are visible.
>
> thoughts or personal experiences (or requests for info on solving some 
> of these problems) welcome.
>
> Thanks,
>
> Matt
>

Hi all,

managed to catch some output from the hang this time around


Managed to catch some output from the crash this time

Jan  4 22:22:10 berger kernel:  [<c0512aeb>] schedule+0x31b/0x6a0
Jan  4 22:22:10 berger kernel:  [<c03fb2b0>] scsi_error_handler+0x0/0xb0
Jan  4 22:22:10 berger kernel:  [<c041327a>] mv_stop_and_reset+0x3a/0x60
Jan  4 22:22:10 berger kernel:  [<c041374f>] mv_eng_timeout+0x6f/0xb0
Jan  4 22:22:10 berger kernel:  [<c040b4b7>] ata_scsi_error+0x17/0x30
Jan  4 22:22:10 berger kernel:  [<c03fb33b>] scsi_error_handler+0x8b/0xb0
Jan  4 22:22:10 berger kernel:  [<c01325e6>] kthread+0xb6/0xc0
Jan  4 22:22:10 berger kernel:  [<c0132530>] kthread+0x0/0xc0
Jan  4 22:22:10 berger kernel:  [<c0101389>] kernel_thread_helper+0x5/0xc
Jan  4 22:22:10 berger kernel: ata5: status=0x50 { DriveReady SeekComplete }
Jan  4 22:22:10 berger kernel: ata5: error=0x01 { AddrMarkNotFound }
Jan  4 22:22:10 berger kernel: Assertion failed! qc->flags & 
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3735
Jan  4 22:22:10 berger kernel: ata5: status=0x50 { DriveReady SeekComplete }
Jan  4 22:22:10 berger kernel: ata5: error=0x01 { AddrMarkNotFound }
Jan  4 22:22:10 berger kernel: sdd: Current: sense key=0x0
Jan  4 22:22:10 berger kernel:     ASC=0x0 ASCQ=0x0
Jan  4 22:22:10 berger kernel: Assertion failed! ((in_ptr >> 
EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + 
EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & 
MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1067
Jan  4 22:22:11 berger kernel: ata5: translated ATA stat/err 0xd0/00 to 
SCSI SK/ASC/ASCQ 0xb/47/00
Jan  4 22:22:11 berger kernel: ata5: status=0xd0 { Busy }
Jan  4 22:22:11 berger kernel: Assertion failed! ((in_ptr >> 
EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + 
EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & 
MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1067
Jan  4 22:22:11 berger kernel: Assertion failed! EDMA_EN & readl(base + 
EDMA_CMD_OFS),drivers/scsi/sata_mv.c,mv_start_dma,line=582


Any thoughts / input ?

Matt


