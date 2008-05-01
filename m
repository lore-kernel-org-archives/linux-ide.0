From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Thu, 01 May 2008 21:24:24 +0900
Message-ID: <4819B678.1010303@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com> <48192ED5.9030402@rtr.ca> <48193138.2070306@gmail.com> <4819A85B.1090709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:14674 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYEAMYa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 08:24:30 -0400
Received: by py-out-1112.google.com with SMTP id u52so1445377pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 05:24:30 -0700 (PDT)
In-Reply-To: <4819A85B.1090709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>>> Does the bit get set for the host link or pmp fanout links?
>> It's only on the pmp fanout link. Dunno why it gets set, but it does.
> ..
> 
> Oh, wait a sec.. I think I know what's going on.
> We're back to the original problem in this thread again:

Aieee...

> Mark Lord wrote:
>> With no port-multiplier attached, a media error during NCQ
>> results in an immediate READ_LOG_EXT_10H to retrieve the
>> task file for the failed I/O.
>>
>> With a port-multiplier, there is instead a flurry of sata_pmp_read()
>> attempts.  I'm guessing that the READ_LOG_EXT_10H would normally
>> then follow those ?
>>
>> The problem is, on most of the Marvell chips, non-data commands
>> cannot succeed after any kind of error (until after the port is reset),
>> so they fail, and we never then get to the READ_LOG_EXT_10H stage.
>> Oddly, the READ_LOG_EXT_10H command itself is okay (with some errata
>> goodness tossed in).
>>
>> So, for sata_mv at least, I'd kinda like to have libata-eh attempt
>> the READ_LOG_EXT_10H before it tries to (unsuccessfully) access the
>> per-port SCRs on the PMP.
> ..
> 
> So what is happening now, is that libata-eh is going and attempting
> to access the per-port SCRs *after* the READ_LOG_EXT commands.
> And those per-port SCRs are not actually accessible:  the shadow
> registers are misbehaving -- known errata -- and cannot be accurately
> used without a port reset.
> 
> Mmm.. gotta figure out a way to mark the port for RESET,
> without having that action taint the commands already analyzed.
> 
> I suppose I'll have to just clone some code from libata-eh to
> do the READ_LOG_EXT and then qc_complete() those commands
> before continuing.  Or something.

The usual way to handle this is to clear the controller state (not the 
PHY) from ->error_handler() before calling the generic error_handler. 
Many drivers do similar things - ahci restarts the engine, sil24 calls 
sil24_init_port() and so on.  Does mv need PHY reset to get it working 
again?

-- 
tejun
