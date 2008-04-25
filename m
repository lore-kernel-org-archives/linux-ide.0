From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Fri, 25 Apr 2008 12:34:46 -0400
Message-ID: <48120826.504@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1920 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbYDYQes (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 12:34:48 -0400
In-Reply-To: <48120269.8020101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
..
>>
>> So, for sata_mv at least, I'd kinda like to have libata-eh attempt
>> the READ_LOG_EXT_10H before it tries to (unsuccessfully) access the
>> per-port SCRs on the PMP.
>>
>> For now, I'll try and hack something into my local tree to ensure
>> that things will actually work that way around without any other
>> unforseen complications.
>>
>> But for upstream, I'm thinking maybe a HORKAGE flag or something?
>> I'm still trying to avoid having to pull a lot of libata-eh/pmp code
>> into sata_mv for local customizations.
> 
> w00t w00t I thought about that when I wrote NCQ EH.  All you have to do 
> is to export ata_eh_analyze_ncq_error() can call it right after 
> error_handler starts and put the controller into a working state (so 
> that SCR accesses work again).  After it finishes, call the generic 
> handler.  The second time around ata_eh_analyze_ncq_error() will be 
> no-op and you should get what you want.
..

Really... Mmm...  :)

Thanks, Tejun.  *You are The Man* !

:)


