From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 19:46:06 -0500
Message-ID: <4404EECE.3080304@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046074.4070201@rtr.ca> <Pine.LNX.4.64.0602280939280.16541@p34> <440462E1.2010909@rtr.ca> <4404671D.70506@pobox.com> <44046BBF.1060204@rtr.ca> <44046D65.90909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:33957 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932734AbWCAAqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 19:46:12 -0500
In-Reply-To: <44046D65.90909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
>
>>> Nah we should really dump the full taskfile...
>>
>>
>> Agreed.  But the original command byte is not stored anywhere
>> for us to dump it from.
> 
> er eh?
> 
> All callers of ata_to_sense_error() have the full taskfile available.

Yes, but the command byte gets overwritten by the read-back status byte,
since they share the same byte in the taskfile.

So once the command has failed, the command byte is no longer there.

Or is it?

-ml
