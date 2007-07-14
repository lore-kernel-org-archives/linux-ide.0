From: Ryan Power <rpower@sysreset.com>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Fri, 13 Jul 2007 18:00:36 -0600
Message-ID: <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz>
 <46972519.80703@gmail.com>
 <46980AFD.3000503@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.sysreset.com ([209.97.229.250]:31094 "EHLO sysreset"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933540AbXGNAAd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 20:00:33 -0400
In-Reply-To: <46980AFD.3000503@shaw.ca>
References: <20070713065600.GB8320@vana.vc.cvut.cz>
 <46972519.80703@gmail.com>
 <46980AFD.3000503@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>, Tejun Heo <htejun@gmail.com>
Cc: Petr Vandrovec <petr@vandrovec.name>, linux-ide@vger.kernel.org

I'm also experiencing this problem on a with the sata_nv module.  I suspect 
that it may at least not be controller dependant, as it's also occurring on 
my silicon image controller (sata_sil, SiI3512).  It looks like something 
is zeroing out part of the return registers for the overall smart status.

Tested with Maxtor 6L300S0 and Western Digital WD3200JS drives on both the 
sil and nv controllers.  This was working in 2.6.21.6, but I haven't had a 
chance to try and isolate the problem any further.

Thanks.
-Ryan Power

At 05:30 PM 7/13/2007, Robert Hancock wrote:
>Tejun Heo wrote:
>>>Only problem I've noticed is that smartctl on drives connected to sata_nv
>>>needs '-T permissive', while if same drive is connected to sata_sil24's PMP,
>>>it works without problem.
>>>
>>>Error SMART Status command failed
>>>Please get assistance from http://smartmontools.sourceforge.net/
>>>Values from ATA status return descriptor are:
>>>  00     09 0c 00 00 00 00 00 00  00 00 00 00 00 50
>>>A mandatory SMART command failed: exiting. To continue, add one or more 
>>>'-T permissive' options.
>>Yeah, we seem to have some problem with passing result TF to userland in
>>sata_nv (cc'ed Robert).
>>Thanks.
>
>I've seen that report, but it's a bit of a mystery to me. Apparently the 
>problem still happens if ADMA is disabled, and in that mode we just use 
>the standard ata_tf_read function, so it's not clear how it could not be 
>working on that controller but work on others..
>
>Also I haven't noticed any SMART problems on my machine with ADMA 
>enabled.. maybe it's drive or motherboard dependent?

