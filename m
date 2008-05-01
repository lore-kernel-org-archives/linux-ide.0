From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Thu, 01 May 2008 21:40:03 +0900
Message-ID: <4819BA23.1050904@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com> <48192ED5.9030402@rtr.ca> <48193138.2070306@gmail.com> <4819A85B.1090709@rtr.ca> <4819B678.1010303@gmail.com> <4819B8A6.3040608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:44474 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYEAMkJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 08:40:09 -0400
Received: by py-out-1112.google.com with SMTP id u52so1453711pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 05:40:09 -0700 (PDT)
In-Reply-To: <4819B8A6.3040608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> Mmm.. gotta figure out a way to mark the port for RESET,
>>> without having that action taint the commands already analyzed.
>>>
>>> I suppose I'll have to just clone some code from libata-eh to
>>> do the READ_LOG_EXT and then qc_complete() those commands
>>> before continuing.  Or something.
>>
>> The usual way to handle this is to clear the controller state (not the 
>> PHY) from ->error_handler() before calling the generic error_handler. 
>> Many drivers do similar things - ahci restarts the engine, sil24 calls 
>> sil24_init_port() and so on.  Does mv need PHY reset to get it working 
>> again?
> ..
> 
> Heh.. the thoughtful chip designers didn't include an engine-only reset 
> mechanism.
> If we reset the engine, it resets the PHY.  That's the whole problem here.
> Things would be so much simpler if it did the simple thing..  :)

Eeeee... nice, so you have to reset the host PHY anyway?  If so, just 
freeze the host port.  It will print some nasty messages (which we'll 
need to subdue) but libata EH won't issue any command to fanout ports 
before host port reset.

-- 
tejun
