From: Tejun Heo <tj@kernel.org>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Fri, 20 Feb 2009 09:32:51 +0900
Message-ID: <499DFA33.8090009@kernel.org>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca> <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com> <49934B20.4060206@rtr.ca> <49934D24.1050204@garzik.org> <4993A57D.6010107@gmail.com> <499D7A4B.5010804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50824 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbZBTAdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 19:33:08 -0500
In-Reply-To: <499D7A4B.5010804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
>>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>ata1.00: status: { DRDY }
> 
>>>> I wonder if it's just a case of too short a timeout on the cache
>>>> flushes?
> ..
>> However, in this case the drive is not reporting Busy status at the
>> timeout, which suggests maybe an interrupt got lost or something.
>> (Could be still the drive's fault.)
> ..
> 
> If I recall correctly, The reported shadow register contents are bogus
> when a timeout occurs.  So we don't actually know what the drive state was.
> 
> Or do we, Tejun?

Yeah, it's bogus.  Maybe we should just report zeros.

Thanks.

-- 
tejun
