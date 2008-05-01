From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Thu, 01 May 2008 08:33:42 -0400
Message-ID: <4819B8A6.3040608@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com> <48192ED5.9030402@rtr.ca> <48193138.2070306@gmail.com> <4819A85B.1090709@rtr.ca> <4819B678.1010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4367 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYEAMdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 08:33:43 -0400
In-Reply-To: <4819B678.1010303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>Mark Lord wrote:
..
>> Mmm.. gotta figure out a way to mark the port for RESET,
>> without having that action taint the commands already analyzed.
>>
>> I suppose I'll have to just clone some code from libata-eh to
>> do the READ_LOG_EXT and then qc_complete() those commands
>> before continuing.  Or something.
> 
> The usual way to handle this is to clear the controller state (not the 
> PHY) from ->error_handler() before calling the generic error_handler. 
> Many drivers do similar things - ahci restarts the engine, sil24 calls 
> sil24_init_port() and so on.  Does mv need PHY reset to get it working again?
..

Heh.. the thoughtful chip designers didn't include an engine-only reset mechanism.
If we reset the engine, it resets the PHY.  That's the whole problem here.
Things would be so much simpler if it did the simple thing..  :)

Cheers

