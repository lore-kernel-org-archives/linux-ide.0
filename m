From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 22:23:59 +0900
Message-ID: <445DF4EF.3080509@gmail.com>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>	<445D6298.7090003@gmail.com>	<20060507140443.7ae89a68.moe@lunar-linux.org>	<445DE5D1.3010203@gmail.com> <20060507151021.2986c766.moe@lunar-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:7542 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932158AbWEGNY3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 09:24:29 -0400
Received: by py-out-1112.google.com with SMTP id x31so1235083pye
        for <linux-ide@vger.kernel.org>; Sun, 07 May 2006 06:24:28 -0700 (PDT)
In-Reply-To: <20060507151021.2986c766.moe@lunar-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org

Moritz Heiber wrote:
> <...>
> PCI: Setting latency timer of device 0000:03:00.0 to 64
> ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
> ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
> ata1: SATA max UDMA/133 cmd 0xF8814100 ctl 0x0 bmdma 0x0 irq 5
> <...>
> ata1: SATA link up 1.5 (SStatus 113 SControl 300)
> ata1: dev 0 cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
> ata1: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
> ata1: dev 0 configured for UDMA/133
> scsi0 : ahci
>   Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ------
> 
> I guess the Scontrol value of 300 is .. good?

The digit in the middle is the SPD limit and 0 means no limit.  Hmm... 
wait, this is a hitachi disk.  Have you tried the feature tool?  Hitachi 
limits the spd of the harddrive tso 1.5 gbps, probably for compatibility 
reasons, and allows users to enable it with the feature tool.

http://www.hitachigst.com/hdd/support/download.htm#FeatureTool

* ....
* Configure SATA interface - adjust maximum speed and enable/disable 
Spread Spectrum Clocking.

> 
> I had to adjust your patch since it didn't apply to my 2.6.16.14 kernel.
> The "corrected" patch is attached. I think I pretty much retained the
> functionality you intended it to have.
> 
> Given your patch though .. your git-based code looks much simpler. I
> wonder if that is a good or a bad thing and wether I should try a more
> recent kernel .. (?)

The patch was pulled from libata devel tree.  I was being lazy again and 
didn't test it on 2.6.16.14.  :p  However, I can assure you libata 
doesn't play much role in PHY spd configuration.

-- 
tejun
