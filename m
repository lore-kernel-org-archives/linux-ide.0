From: Tejun Heo <tj@kernel.org>
Subject: Re: Please add ST3120827AS 3.42 to NCQ blacklist
Date: Thu, 12 Feb 2009 10:47:33 +0900
Message-ID: <49937FB5.3000608@kernel.org>
References: <20090202132824.09984F805@i3.golden.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50868 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677AbZBLBr0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 20:47:26 -0500
In-Reply-To: <20090202132824.09984F805@i3.golden.dom>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: giulioo@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

Giulio Orsero wrote:
> Supermicro P8SC8, CENTOS/RHEL 5.x 2.6.18-128.el5
> HD: Seagate SATA ST3120827AS fw3.42  [2 disks in md raid1]
>  
> 00:1f.1 0101: 8086:266f (rev 03)
> 00:1f.2 0101: 8086:2652 (rev 03)
>  
> 2652 is handled by both ata_piix and ahci.
> Using ata_piix everything is fine, using ahci will cause periodic errors
> like:
>  
> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata1.00: cmd 61/08:00:4d:6d:c0/00:00:00:00:00/40 tag 0 ncq 4096 out
>          res 40/00:00:b5:95:a7/00:00:00:00:00/40 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
> 
> Using
> echo 1 > /sys/block/sda/device/queue_depth
> echo 1 > /sys/block/sdb/device/queue_depth
> will eliminate the issue, so please add
>       { "ST3120827AS",        "3.42",         ATA_HORKAGE_NONCQ },
> to the NCQ blacklist.

That's a 7200.7 which has been quite popular && happens to be used
extensively during libata development, so I'm highly doubtful the
problem is a wide spread one.  The problem is more likely to be
something specific to your configuration.

Thanks.

-- 
tejun
