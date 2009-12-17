From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
 UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 13:01:47 -0500
Message-ID: <4B2A720B.2040809@pobox.com>
References: <4B2A3D25.9030209@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:46239 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611AbZLQSBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 13:01:49 -0500
Received: by ywh12 with SMTP id 12so2534150ywh.21
        for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 10:01:49 -0800 (PST)
In-Reply-To: <4B2A3D25.9030209@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

On 12/17/2009 09:16 AM, Stan Hoeppner wrote:
> Hi Jeff,
>
> I recently added a Silicon Image 3512 based PCI card to an old Intel
> 440BX machine along with a single platter 500GB WD SATA2 drive.  I'd
> have gone with an ahci sata2 controller but couldn't find one in 33MHz
> PCI.  I compiled a new kernel, adding SCSI disk, libata and sata_sil
> support using make menuconfig and kernel.org sources installed the
> debian way on lenny 5.0.3.  I left the old piix diver in so I could
> still boot from the old IDE disk and move the entire Linux system over.
>   That all went pretty smoothly, I'm now booting from the new disk, and
> the sata subsystem is working pretty well, especially compared to the
> old 40GB Maxtor IDE disk (now removed from the system).

sata_sil hardware does not support NCQ.

	Jeff



