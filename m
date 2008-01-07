From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Tue, 08 Jan 2008 01:12:25 +0900
Message-ID: <47824F69.6080007@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:52404 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbYAGQMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 11:12:34 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1590784nze.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 08:12:32 -0800 (PST)
In-Reply-To: <476D16E2.1050909@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: linux-ide@vger.kernel.org

Andrew Ryder wrote:
> I've attached the boot log from the 2.6.24-rc5 kernel. The problem
> repeats itself in the same manner as with the 2.6.23 kernel with the
> libata patches.
> 
> Here is the info on the sata controller and HPM.
> 
> Addonics:
> 
> - 4 port Sata II Raid5 HBA with the SIL3124 (ADSA4R5)
> - Mini-Storage tower with HPM (AD5SAHPM-E)
> - 2 meter eSata cable
> - One IDE-Sata converter for each IDE drive (ADIDESA)
> 
> I have 4 seagate 300GB IDE drives installed in the storage tower, each
> drive has an ide-sata converter installed on it, and the HPM running in
> JBOD mode.
> 
> I have upgraded the firmware on the HBA to  the latest available from SI
> (6.4.09) and the HPM in the storage tower is running the latest version
> also (1.2061)
> 
> Once the driver has finished attempting to initialize the hardware, the
> first hard drive is accessible, the 2nd drive is partially detected, but
> unusable. If I try and run fdisk on the 2nd drive, fdisk reports that
> "You must set cylinders" before attempting partitioning. The 3rd and 4th
> drives are not detected at all.
> 
> I have tried the sata controller and HPM under windows 2000, and
> everything worked without issue.
> 
> I did try previously configuring the HPM in Raid 1 mode to treat the
> storage tower as one large disk and this configuration worked without
> issue in Linux or windows. Since I returned the unit to JBOD mode, there
> have been some additional errors about trying to access beyond the end
> of the first drive on the HPM.
> 
> If theres any other information you need, please let me know.
> 
> Thanks
> 
> Here is my system config, software environment and boot logs:
> 
> 
> Hardware:
> Asus SK8V
> Opteron 144
> 2GB Memory
> Adaptec 29160N
> 1 U160 18GB scsi drive
> 1 Ultra scsi cd-rom
> 2 ide drives
> 2 ide cdroms
> Intel Pro/1000 network card
> ATI Radeon 9600 AGP
> Creative Audigy2 sound card

Do you still see this problem on rc6?

-- 
tejun
