From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Tue, 30 May 2006 00:44:05 -0400
Message-ID: <447BCD95.3010405@pobox.com>
References: <1148884736485-git-send-email-htejun@gmail.com> <447BC8EB.3080607@pobox.com> <447BCBF3.5090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50149 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932133AbWE3EoR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:44:17 -0400
In-Reply-To: <447BCBF3.5090000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Implement unload unplug - driver unloading / PCI removal via hot
>>> unplug path.  This is done by ata_port_detach() which requests detach
>>> of all devices, schedules EH and wait for it to complete.  EH path is
>>> slightly modified to handle this (e.g. force zero eh_info during
>>> unloading).  With this patch, EH and unloading are properly
>>> synchronized and unloading should be safe under any circumstances.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> How does this behave for controller hotplug?  For that case, there is 
>> nothing to EH...
> 
> I've only tested with module unloading but when EH is invoked for 
> unplugging, autopsy and report are skipped and recover is called with 
> zero ehi but with all DFLAG_DETACH set.  This amounts to unconditional 
> detachment of all devices without any other operation (well, of course, 
> other than being synchronized to other EH invocations).  So, I guess it 
> should work okay.  Can you tell me how to test such condition?  I guess 
> I can yank out my sil3132 and unload sata_sil24.  Would that be enough?

ISTR there is some sysfs trigger for PCI eject, that will allow you test 
this.

	Jeff



