From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] fix sata_sil quirk
Date: Tue, 22 Jun 2004 23:39:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D8FB8A.8040109@pobox.com>
References: <40D89509.6010502@pobox.com> <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41915 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266101AbUFWDkJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 23:40:09 -0400
In-Reply-To: <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
List-Id: linux-ide@vger.kernel.org
To: Paul Jakma <paul@clubi.ie>
Cc: linux-ide@vger.kernel.org, Ricky Beam <jfbeam@bluetronic.net>, Linux Kernel <linux-kernel@vger.kernel.org>

Paul Jakma wrote:
> # cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi2 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: WDC WD1600JD-00G Rev: 02.0
>   Type:   Direct-Access                    ANSI SCSI revision: 05

> And am not having (touch wood) any stability problems using these disks 
> with linux md RAID1 and RAID5. Though, they're in a K6-II 350, so 
> performance is slow anyway. (i get about 25MB/s absolute max reading 
> from a RAID-5 array).


Cool.  Yeah, non-Seagate should be full speed and unaffected...

	Jeff


