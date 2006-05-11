From: Jens Axboe <axboe@suse.de>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Thu, 11 May 2006 12:55:55 +0200
Message-ID: <20060511105555.GK4157@suse.de>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com> <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:4199 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030206AbWEKKz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 May 2006 06:55:29 -0400
Content-Disposition: inline
In-Reply-To: <1147340790.7273.47.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Thu, May 11 2006, zhao, forrest wrote:
> On Thu, 2006-05-11 at 17:35 +0900, Tejun Heo wrote:
> > Tejun Heo wrote:
> > Oops, you were talking about ata_piix and I answered about ahci.  Sorry
> > about that.  :(
> > 
> > Can you please post dmesg w/ ATA_DEBUG turne on?  I might have screwed
> > up while updating suspend/resume functions.
> > 
> 
> Tejun,
> 
> The case is very tricky. When ata_piix resumed from S3, dmesg can't be
> outputted, when I type "dmesg" in console, it prompts:
> -bash: /bin/dmesg: Input/output error
> 
> Is there any other way to collect the log?

run dmesg prior to suspending, then it'll be cached and can be run after
resume even if the disk doesn't want to talk to you.

-- 
Jens Axboe

