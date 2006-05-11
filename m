From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Thu, 11 May 2006 19:39:02 +0900
Message-ID: <44631446.1060401@gmail.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>	 <4462F667.3060504@gmail.com>  <4462F767.5070003@gmail.com> <1147340790.7273.47.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:8316 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030219AbWEKKjH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 06:39:07 -0400
Received: by wr-out-0506.google.com with SMTP id i28so101132wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 03:39:07 -0700 (PDT)
In-Reply-To: <1147340790.7273.47.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Thu, 2006-05-11 at 17:35 +0900, Tejun Heo wrote:
>> Tejun Heo wrote:
>> Oops, you were talking about ata_piix and I answered about ahci.  Sorry
>> about that.  :(
>>
>> Can you please post dmesg w/ ATA_DEBUG turne on?  I might have screwed
>> up while updating suspend/resume functions.
>>
> 
> Tejun,
> 
> The case is very tricky. When ata_piix resumed from S3, dmesg can't be
> outputted, when I type "dmesg" in console, it prompts:
> -bash: /bin/dmesg: Input/output error
> 
> Is there any other way to collect the log?
> 

Ahh.... right.  Unfortunately, I don't have much experience with
suspending/resuming and don't really know what to do.  Can you try the
current #upstream and see how that works?  So that we can see whether
the EH changes caused the problem?

-- 
tejun
