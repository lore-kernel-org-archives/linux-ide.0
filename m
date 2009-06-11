From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Wed, 10 Jun 2009 22:27:04 -0600
Message-ID: <4A308798.6060803@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:54454 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbZFKE1F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jun 2009 00:27:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so855501ywb.1
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 21:27:06 -0700 (PDT)
In-Reply-To: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: linux-ide@vger.kernel.org

Marc Bowes wrote:
> Hi again,
> 
> To give some more information on what I've done.
> 
> I installed using the 20090526 Gentoo autobuild. The livecd gave no
> errors during the process. The drive I installed on is a Seagate 160Gb
> SATA 7200RPM HDD. The motherboard is a Gigabyte EP45-DQ6. The CPU is
> an Intel Q6600. All motherboard settings are standard, and AHCI/RAID
> is disabled in the BIOS due to an existing Windows installation. I
> have tried other cables for the hard drives. I have tried enabling
> AHCI (it is enabled in the Kernel - 2.6.29-gentoo-r5), also to no
> avail. To recap, the messages when booting into my system look like:
> 
> ata1: link is slow to respond, please be patient (ready=0)
> ata1: softreset failed (device not ready)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1: link online but device misclassified, retrying
> ata1: link is slow to respond, please be patient (ready=0)
> ata1: softreset failed (device not ready)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1: link online but device misclassified, retrying
> ata1: link is slow to respond, please be patient (ready=0)
> ata1: softreset failed (device not ready)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1: link online but device misclassified, retrying
> ata1: limiting SATA link speed to 1.5 Gbps
> ata1: softreset failed (device not ready)
> ata1: SATA link up to 1.5 Gbps (SStatus 113 SControl 310)
> ata1: link online but device misclassified, device detection might fail
> ata2: link is slow to respond, please be patient (ready=0)
> ata2: softreset failed (device not ready)
> ... (as with ata1)
> 
> This whole process takes over a minute, with each message group (link
> slow..retrying) taking 10-15s. After these messages, the system boots
> successfully and it appears I can use it as normal.
> 
> As a side note, the drives also appear to be working in Windows 7, but
> I don't know if there is a way to check the link speed.
> 
> I guess my questions are:
>  - have I done something horridly wrong, e.g. missing a Kernel/BIOS
> option somewhere?
>  - could this be an anomaly with this specific Kernel version (I think
> this likely, given that the livecd didn't complain)
>  - maybe it is a BIOS issue and I need to find an update from the manufacturer

Can you post the full boot dmesg log?
