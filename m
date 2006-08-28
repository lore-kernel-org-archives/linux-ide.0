From: Tejun Heo <htejun@gmail.com>
Subject: Re: Port multiplier
Date: Mon, 28 Aug 2006 22:05:43 +0900
Message-ID: <44F2EA27.9090603@gmail.com>
References: <44F2984F.6030100@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:3782 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750783AbWH1NFv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 09:05:51 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1008556nzf
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2006 06:05:50 -0700 (PDT)
In-Reply-To: <44F2984F.6030100@clear.net.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: linux-ide@vger.kernel.org

Hello,

Richard Scobie wrote:
> I have ordered an ASUS M2N SLI Deluxe which in addition to the NVIDIA
> SATA controller, has a JMicron 363 SATA controller which handles one
> internal SATA connector and an external eSATA connector.
> 
> My understanding is that the JMicron will work using kernel AHCI support
> and the board BIOS has an AHCI setting.
> 
> My hope is to be able to connect an Addonics AD5APM-E 5 disk port
> multiplier module to this. From the photo and some other information at
> their website, this appears to use either a Silicon Image 3124 or 3132 
> chip.
> 
> Do you think this will work, if I use the current patch 20060710 on your
> Wiki?

PMP support for AHCI isn't yet included in PMP patches, so, no, it won't.

> If so, and it supports hotplugging, which I believe it may do, what
> exactly does this mean?
> 
> Can I power up an external enclosure containing the Addonics and 3
> drives, configured as a RAID 5 and plug it straight into the running 
> system?

Yeap.  libata should detect the new drives and attach them.

> If so, can this be set up to mount automatically?

Well, the kernel detects the device and notifies hotplug.  The rest is 
upto how hotplug is configured.

> Can I unmount the connected and mounted array and just unplug the array
> with no further concern?

The machine will survive and detach the device correctly but 
yet-unwritten data will be lost.

-- 
tejun
