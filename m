From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Fri, 04 May 2007 08:41:41 +0200
Message-ID: <463AD5A5.2080404@gmail.com>
References: <214881.21738.qm@web52612.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:41835 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767688AbXEDGly (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 02:41:54 -0400
Received: by nz-out-0506.google.com with SMTP id o1so770893nzf
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 23:41:53 -0700 (PDT)
In-Reply-To: <214881.21738.qm@web52612.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Hello,

Srihari Vijayaraghavan wrote:
> ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3
> Gbps 0xf impl SATA mode
> ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo
> pmp pio slum part 
> ata3: SATA max UDMA/133 cmd 0xffffc2000006a100 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 22
> ata4: SATA max UDMA/133 cmd 0xffffc2000006a180 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 22
> ata5: SATA max UDMA/133 cmd 0xffffc2000006a200 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 22
> ata6: SATA max UDMA/133 cmd 0xffffc2000006a280 ctl
> 0x0000000000000000 bmdma 0x0000000000000000 irq 22
> scsi2 : ahci
> PM: Adding info for No Bus:host2
> ata3: softreset failed (1st FIS failed)
> ata3: softreset failed, retrying in 5 secs
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3.00: limiting speed to UDMA7:PIO5
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.00: qc timeout (cmd 0xec)
> ata3.00: failed to IDENTIFY (I/O error,
> err_mask=0x104)
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> scsi3 : ahci
> 
> I've made a couple of more observations also:
> With the SATA controller mode set to AHCI in the BIOS,
> the Seagate SeaToolsDos diagnostic tool wouldn't
> detect the drives. (Perhaps because it's a legacy OS)
> 
> By  setting it to IDE controller mode, the diagnostics
> ran & completed successfully on both the drives, thus
> I believe the drives, cables, power connectors etc.
> are working fine as expected.
> 
> The above dmesg is after setting the SATA controller
> back to AHCI mode in the BIOS.

Hmm...  It's fishy.  The first SRST is failing.  Following hardreset
succeeds but IDENTIFY issued after that times out.  This doesn't seem to
be IRQ delivery problem.  Conke Hu, any ideas?

> (I'm using the yahoo web interface to post these
> emails. If it makes it hard to read, on your request,
> I'm happy to provide the kernel logs as email
> attachments).

I can read it but attachment with mime type set to plain text should be
easier.

-- 
tejun
