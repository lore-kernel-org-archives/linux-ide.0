From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Likely race condition for some disk interface / peripherals combinations
 (hung processes, high iowait)
Date: Fri, 21 Aug 2015 00:42:52 +0200
Message-ID: <55D657EC.2020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35485 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbHTWm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Aug 2015 18:42:56 -0400
Received: by wicne3 with SMTP id ne3so2022005wic.0
        for <linux-ide@vger.kernel.org>; Thu, 20 Aug 2015 15:42:54 -0700 (PDT)
Received: from [192.168.1.100] (host21-54-dynamic.17-87-r.retail.telecomitalia.it. [87.17.54.21])
        by smtp.gmail.com with ESMTPSA id fs8sm377935wib.0.2015.08.20.15.42.53
        for <linux-ide@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2015 15:42:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

please CC me in answers.

I have recently run into an issue with a system with

- ASRock N68S motherboard with AMD Phenom(tm) II X4 920 Processor and
NVIDIA MCP61 SATA/IDE Chipset

- IDE interface where master is HL-DT-ST DVD-RAM GH22NP20 CDROM/DVD writer and 
slave is an IOMEGA ZIP 100 ATAPI Floppy

Symptoms can occur many hours after boot and include

* IOWAIT suddenly jumping high
* Processes hanging (e.g. all activities related to disks and specifically to 
the IOMEGA drive. For instance commands like lsblk or blkid hang as well as 
attempts at mounting the disk)
* Machine unable to shutdown

Note that before the symptoms occur, all seems to work just fine including use 
of the IOMEGA drive. Removing the IOMEGA drive from the system cures the issue.
The system used to work just fine until a recent past.

Due to the race-like nature of the issue and symptoms coming so late, bisecting 
has been extremely painful. It lead to commit 045065d.  However, this is just a 
trivial fix for a logic condition. What happens is that the bug fixed by 045065d 
was papering over a real issue in the kernel.

Some research revealed that the issue is biting other people as well. For 
instance, see https://bbs.archlinux.org/viewtopic.php?id=189324 and 
https://bugzilla.kernel.org/show_bug.cgi?id=87581

It is likely that as soon as distros start adopting kernels that incorporate 
045065d, more and more people will be affected by the issue.

Back in Nov 2014, a tentative patch was submitted to the LKML by Christoph 
Hellwig. See https://lkml.org/lkml/2014/11/20/581.

The patch fixes the issue for me, however, it was not incorporated in the kernel 
because, by the own words of Christoph, it is just hiding the real issue.
For others, increasing the delay time in blk_delay_queue(q, SCSI_QUEUE_DELAY)
also works.

Is there any way to help going into this problem?

Best regards,

Sergio Callegari



