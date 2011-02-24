From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 24 Feb 2011 11:21:47 -0500
Message-ID: <4D66859B.3020806@teksavvy.com>
References: <4D5C92F4.5000906@crc.id.au> <4D5CA2B1.8020905@crc.id.au> <20110217095815.GN19830@htj.dyndns.org> <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au> <20110218091629.GC21209@htj.dyndns.org> <4D65C155.7080902@crc.id.au> <20110224083123.GB7840@htj.dyndns.org> <4D662A8B.5050501@crc.id.au> <20110224100609.GF7840@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:15174 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756216Ab1BXQVu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 11:21:50 -0500
In-Reply-To: <20110224100609.GF7840@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Steven Haigh <netwiz@crc.id.au>, linux-ide@vger.kernel.org, justin@jmicron.com

On 11-02-24 05:06 AM, Tejun Heo wrote:
>
>> Near the rear:
>> JMB352 / 0834 LGBA1 A / 370JF3011 - This looks to be hooked up via
>> some capacitors to the DATA data lines on both sockets. If I haven't
>> mentioned before, this is a 2 x SATA drive bay cradle.
> 
> This is the SATA part.
> 
>> A third tiny chip near the JMB352 is:
>> GL850A / MN2FA01G11 / 911SK03111 - Not 100% sure of the function of
>> this chip by following the tracks, but it looks like it might be
>> some kind of a clock source. That is a wild guess though!
> 
> This is USB thingie.
> 
> So, the offending part is JMB352.  Justin, when JMB352 is doing e-SATA
> interface, it's failing IDENTIFY.  sata_sil fails to recognize it and
> ahci (right? Steven) succeeds only after IDENTIFY failures and
> retries.  Any ideas what's going on?  When doing e-SATA, is the chip
> active or passive?  ie. Does it just pass through the signals or do
> some meddling inbetween?


Since this is a dual-SATA device, does it have TWO eSATA ports at the back,
or just one?  If the latter, then I'd expect to find a port-multiplier in the chain.

Cheers
