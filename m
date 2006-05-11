From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Thu, 11 May 2006 17:46:30 +0800
Message-ID: <1147340790.7273.47.camel@forrest26.sh.intel.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
	 <4462F667.3060504@gmail.com>  <4462F767.5070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12153 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030212AbWEKJ5T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 05:57:19 -0400
In-Reply-To: <4462F767.5070003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, 2006-05-11 at 17:35 +0900, Tejun Heo wrote:
> Tejun Heo wrote:
> Oops, you were talking about ata_piix and I answered about ahci.  Sorry
> about that.  :(
> 
> Can you please post dmesg w/ ATA_DEBUG turne on?  I might have screwed
> up while updating suspend/resume functions.
> 

Tejun,

The case is very tricky. When ata_piix resumed from S3, dmesg can't be
outputted, when I type "dmesg" in console, it prompts:
-bash: /bin/dmesg: Input/output error

Is there any other way to collect the log?

Thanks,
Forrest
