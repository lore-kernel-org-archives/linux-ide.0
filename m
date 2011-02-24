From: Steven Haigh <netwiz@crc.id.au>
Subject: Re: sata-sil drive detection issues.
Date: Fri, 25 Feb 2011 03:29:13 +1100
Message-ID: <4D668759.1020208@crc.id.au>
References: <4D5C92F4.5000906@crc.id.au> <4D5CA2B1.8020905@crc.id.au> <20110217095815.GN19830@htj.dyndns.org> <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au> <20110218091629.GC21209@htj.dyndns.org> <4D65C155.7080902@crc.id.au> <20110224083123.GB7840@htj.dyndns.org> <4D662A8B.5050501@crc.id.au> <20110224100609.GF7840@htj.dyndns.org> <4D66859B.3020806@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.vm.crc.id.au ([203.56.246.92]:44733 "EHLO
	mail.vm.crc.id.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1BXQ3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 11:29:31 -0500
In-Reply-To: <4D66859B.3020806@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, justin@jmicron.com

On 25/02/2011 3:21 AM, Mark Lord wrote:
> On 11-02-24 05:06 AM, Tejun Heo wrote:
>>
>>> Near the rear:
>>> JMB352 / 0834 LGBA1 A / 370JF3011 - This looks to be hooked up via
>>> some capacitors to the DATA data lines on both sockets. If I haven't
>>> mentioned before, this is a 2 x SATA drive bay cradle.
>>
>> This is the SATA part.
>>
>>> A third tiny chip near the JMB352 is:
>>> GL850A / MN2FA01G11 / 911SK03111 - Not 100% sure of the function of
>>> this chip by following the tracks, but it looks like it might be
>>> some kind of a clock source. That is a wild guess though!
>>
>> This is USB thingie.
>>
>> So, the offending part is JMB352.  Justin, when JMB352 is doing e-SATA
>> interface, it's failing IDENTIFY.  sata_sil fails to recognize it and
>> ahci (right? Steven) succeeds only after IDENTIFY failures and
>> retries.  Any ideas what's going on?  When doing e-SATA, is the chip
>> active or passive?  ie. Does it just pass through the signals or do
>> some meddling inbetween?
>
>
> Since this is a dual-SATA device, does it have TWO eSATA ports at the back,
> or just one?  If the latter, then I'd expect to find a port-multiplier in the chain.

Hi Mark,

There is only one eSATA port on the back of the cradle. From looking at 
the specs of the JMB352[1], it seems that it has the capability to have 
3 SATA channels. Two are used for the cradle bays, the third for the 
uplink to the PC.

The PDF states:
"The SATA controller could be configured as host or device. The
3-port SATA II 3.0G controllers further supports the eSATA to dual SATA 
communication."

[1] - http://www.jmicron.com/PDF/JMB352/JMB352.pdf

-- 
Steven Haigh

Email: netwiz@crc.id.au
Web: http://www.crc.id.au
Phone: (03) 9001 6090 - 0412 935 897
Fax: (03) 8338 0299
