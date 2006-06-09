From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] AHCI Command Completion Coalescing(CCC) proposal
Date: Thu, 08 Jun 2006 23:52:03 -0400
Message-ID: <4488F063.1020803@pobox.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488EB4A.4050501@pobox.com> <4488EE69.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:25061 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965127AbWFIDwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 23:52:12 -0400
In-Reply-To: <4488EE69.7050907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> I'm still not sure I follow you?
>>
>> When AHCI runs out of commands to execute, it transitions from H:Idle 
>> to Ccc:SetIS.
>>
>> IMPORTANT NOTE:  In order for CCC to be effective on AHCI, ahci.c and 
>> libata (and sata_sil24) must be updated to support queuing a list of 
>> non-NCQ commands onto the controller, and recovering from errors in 
>> the case where a command list full of non-NCQ commands is present.
> 
> I thought about it but am not really sure whether it's worth the 
> trouble.  We'll be saving on inter-command latency and interrupt 
> handling which is great but not so sure how noticeable the improvement 
> would be.  NCQ is already all around.  How about doing CCC only during 
> NCQ command phase?

Agreed with all these observations.

In general, the non-NCQ case shares characteristics with host-queue 
controllers like sx8.  The benefit is nowhere near true command queueing 
like NCQ, but the benefits (which you list) are real.

Think of this as a long term requirement.  libata _should_ eventually 
support this, simply because the gains are there to be had.  Several 
SATA controllers support queueing of non-NCQ commands.

In the short term, only turning on CCC for NCQ ports makes a lot of sense.


> Hmmm... maybe those SSDs would benefit from CCC during non-NCQ commands 
> though if they don't support NCQ, which they don't really need.

My Gigabyte i-Ram reliably corrupts data within seconds, regardless of 
SATA controller :/

	Jeff



