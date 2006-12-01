From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
Date: Fri, 01 Dec 2006 16:07:55 +0900
Message-ID: <456FD4CB.8020608@gmail.com>
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:13008 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933073AbWLAHIC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 02:08:02 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1491399nze
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 23:08:01 -0800 (PST)
In-Reply-To: <456DD70D.1050808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Berck E. Nash wrote:
> [   68.242305] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   98.221334] ata2.00: qc timeout (cmd 0xec)
> [   98.225467] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> [  108.063137] ata2: port is slow to respond, please be patient (Status 0x80)
> [  131.003980] ata2: port failed to respond (30 secs, Status 0x80)
> [  131.009930] ata2: COMRESET failed (device not ready)
> [  131.014926] ata2: hardreset failed, retrying in 5 secs
> [  138.308717] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  138.319554] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
> [  138.325157] ata2.00: ata2: dev 0 multi count 1
> [  138.334245] ata2.00: configured for UDMA/133
[--snip--]
> [  143.191590] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
> [  143.199761] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
> [  143.205550] sdd: Write Protect is off
> [  143.209257] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  143.218356] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
> [  143.224143] sdd: Write Protect is off
> [  143.227847] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  143.236927]  sdd: unknown partition table
> [  143.241194] sd 2:0:0:0: Attached scsi disk sdd
> [  143.245707] sd 2:0:0:0: Attached scsi generic sg3 type 0

Ahh.. I can't believe I missed this again.  A Port Multiplier is
attached to your ata2 which is probably a sil3726 or 4726.  Why this
device fails initial reset is unknown yet.  Anyways, with proper PMP
support, this problem will go away.  So, this isn't really a ahci issue
and there's nothing wrong with your disks either.  I'll ask SIMG why
this happens with the PMP.

-- 
tejun
