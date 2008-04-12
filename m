From: Adrian Bunk <bunk@kernel.org>
Subject: Re: 2.6.25-rc8-mm2: CONFIG_ATA_SFF: panic involving
	mount_block_root and down the road
Date: Sat, 12 Apr 2008 09:52:48 +0300
Message-ID: <20080412065248.GA8849@cs181133002.pp.htv.fi>
References: <20080410203354.f0a6f464.akpm@linux-foundation.org> <20080411234345.GA4742@martell.zuzino.mipt.ru> <20080412005917.GA4742@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:46346 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbYDLGxl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 02:53:41 -0400
Content-Disposition: inline
In-Reply-To: <20080412005917.GA4742@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Apr 12, 2008 at 04:59:17AM +0400, Alexey Dobriyan wrote:
> On Sat, Apr 12, 2008 at 03:43:45AM +0400, Alexey Dobriyan wrote:
> > Pekka fixed SLUB for me, and now core2 box survives up and including to
> > not finding / :
> > 
> > Setup is SATA disk with plain old partitions, nothing lvmancy:
> > 
> > 	/dev/sda2 on / type ext3 (rw,noatime)
> > 
> > CONFIG_ATA=y
> > CONFIG_ATA_ACPI=y
> > CONFIG_SATA_AHCI=y
> > CONFIG_ATA_PIIX=y
> > CONFIG_PATA_JMICRON=y
> > 
> > sda1 is for swap.
> > 
> > 
> > [    3.920000] NET: Registered protocol family 1
> > [    3.920000] VFS: Cannot open root device "sda2" or unknown-block(0,0)
> 
> The winner is partly me, partly git-libata-all.
> 
> The latter introduced CONFIG_ATA_SFF option and put more or less every
> SATA and PATA driver under it. The former honestly answered N to when
> ATA_SFF popped up and failed to check existence of ATA_PIIX and
> PATA_JMICRON in failing .config .
> 
> Now raise hands those who knew that your ATA controller is SFF
> compliant.

Is there any technical reason why we have to bother users with the 
ATA_SFF option at all?

It sounds like a perfect canndidate for being select'ed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

