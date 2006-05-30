From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Tue, 30 May 2006 13:37:07 +0900
Message-ID: <447BCBF3.5090000@gmail.com>
References: <1148884736485-git-send-email-htejun@gmail.com> <447BC8EB.3080607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:14896 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932079AbWE3EhP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:37:15 -0400
Received: by nz-out-0102.google.com with SMTP id s18so663053nze
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:37:15 -0700 (PDT)
In-Reply-To: <447BC8EB.3080607@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement unload unplug - driver unloading / PCI removal via hot
>> unplug path.  This is done by ata_port_detach() which requests detach
>> of all devices, schedules EH and wait for it to complete.  EH path is
>> slightly modified to handle this (e.g. force zero eh_info during
>> unloading).  With this patch, EH and unloading are properly
>> synchronized and unloading should be safe under any circumstances.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> How does this behave for controller hotplug?  For that case, there is 
> nothing to EH...

I've only tested with module unloading but when EH is invoked for 
unplugging, autopsy and report are skipped and recover is called with 
zero ehi but with all DFLAG_DETACH set.  This amounts to unconditional 
detachment of all devices without any other operation (well, of course, 
other than being synchronized to other EH invocations).  So, I guess it 
should work okay.  Can you tell me how to test such condition?  I guess 
I can yank out my sil3132 and unload sata_sil24.  Would that be enough?

-- 
tejun
