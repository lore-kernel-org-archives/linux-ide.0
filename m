From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/11] ahci: convert to new EH
Date: Sun, 14 May 2006 08:49:03 +0900
Message-ID: <4466706F.8090904@gmail.com>
References: <1147353689306-git-send-email-htejun@gmail.com> <44665E13.9090300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:39355 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964811AbWEMXtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:49:08 -0400
Received: by wx-out-0102.google.com with SMTP id i29so345384wxd
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:49:08 -0700 (PDT)
In-Reply-To: <44665E13.9090300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
>> mask is diddled during operation.  So, freezing is implemented by
>> unconditionally clearing interrupt conditions while frozen.
> 
> For standard BMDMA hardware, you -absolutely must- stop DMA, before 
> doing -anything- else, including EH/recovery.
> 
> This sort of scenario will be quite common.  I would recommend doing so 
> on sata_sil, sata_promise, ...
>

AHCI problem seems to be my honest mistake.  I misinterpreted device 
failures as HBA failures.  For ahci and sata_sil24, making them forget 
about pending commands take time, so it's awkward to do while freezing. 
  And, as they are pretty modern controllers, I expect them to do the 
right thing when IRQ mask is diddled with.

For more traditional BMDMA controllers, I agree with you.  I'll turn off 
BMDMA in bmdma_freeze() before setting nIEN.  But, for sata_sil, I wanna 
  leave it as it is.  The code is tested on sil3112 and 3114 and both 
work fine.  It's not always possible but I wanna avoid adding code which 
isn't necessary to LLDDs.  After a while, nobody would remember why the 
code is there and people will assume sata_sil needs it, which isn't true.

-- 
tejun
