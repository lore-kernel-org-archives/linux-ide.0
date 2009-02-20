From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Thu, 19 Feb 2009 20:52:09 -0600
Message-ID: <499E1AD9.9020904@gmail.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca> <49934D24.1050204@garzik.org> <4993A57D.6010107@gmail.com> <499D7A4B.5010804@rtr.ca> <499DFA33.8090009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:46599 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbZBTCwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2009 21:52:12 -0500
Received: by yx-out-2324.google.com with SMTP id 8so292583yxm.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2009 18:52:11 -0800 (PST)
In-Reply-To: <499DFA33.8090009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>> ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>>>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>> ata1.00: status: { DRDY }
>>>>> I wonder if it's just a case of too short a timeout on the cache
>>>>> flushes?
>> ..
>>> However, in this case the drive is not reporting Busy status at the
>>> timeout, which suggests maybe an interrupt got lost or something.
>>> (Could be still the drive's fault.)
>> ..
>>
>> If I recall correctly, The reported shadow register contents are bogus
>> when a timeout occurs.  So we don't actually know what the drive state was.
>>
>> Or do we, Tejun?
> 
> Yeah, it's bogus.  Maybe we should just report zeros.

Didn't know that. Shouldn't we be able to do a qc_fill_rtf before error 
handling in this case? That would make it easier to tell if we lost an 
interrupt or if the drive is just taking too long..
