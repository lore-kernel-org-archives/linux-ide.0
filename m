From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/14] libata-eh: implement ata_eh_revive()
Date: Wed, 19 Apr 2006 19:33:34 +0900
Message-ID: <20060419103334.GC25726@htj.dyndns.org>
References: <11447633023982-git-send-email-htejun@gmail.com> <1145437721.3417.16.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:46887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750806AbWDSKd2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Apr 2006 06:33:28 -0400
Received: by wproxy.gmail.com with SMTP id i2so338696wra
        for <linux-ide@vger.kernel.org>; Wed, 19 Apr 2006 03:33:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1145437721.3417.16.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Wed, Apr 19, 2006 at 05:08:41PM +0800, zhao, forrest wrote:
> Tejun,
> 
> I did some initial hotplug test in our lab today. And
> this is the printk output in dmesg when I unplug the
> SATA disk at port 2:
> 
> ata2: stat 0x50 err 0x0 SError 0x90402 action 0x2
>       (irq_stat 0x04400000, PHY RDY changed)
> ata2: soft resetting channel for error handling
> ata2: SATA link down (SStatus 21 SControl 300)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2: some devices seem to be offline, will retry in 5 secs
> ata2: hard resetting channel for error handling
> ata2: SATA link down (SStatus 0 SControl 310)
> ata2: some devices seem to be offline, will retry in 5 secs
> ata2: hard resetting channel for error handling
> ata2: SATA link down (SStatus 0 SControl 310)
> ata2: dev 0 disabled
> // why hard reset again??
> ata2: hard resetting channel for error handling
> ata2: SATA link down (SStatus 0 SControl 310)
> // ??
> ata2: dev 0 detaching (SCSI 1:0:0:0)
> 
> 
> My question is: why hard-reset is executed again after
> dev0 at ata2 has been disabled?
> 
> Could you help me understand the idea behind this logic?
> 

Hello, Zhao.

The port could be frozen due to the error which caused the attached
device to fail.  So, EH is trying to put the port into known state
before finishing EH such that we can deal with later events (hotplug).
I've added logics to avoid unnecessary resets in my working tree such
that unnecessary resets are avoided if..

* the port is not frozen
* the port is frozen but hotplug is scheduled

Hope it helped.

-- 
tejun
