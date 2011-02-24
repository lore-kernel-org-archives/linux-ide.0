From: Tejun Heo <tj@kernel.org>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 24 Feb 2011 11:06:09 +0100
Message-ID: <20110224100609.GF7840@htj.dyndns.org>
References: <4D5C92F4.5000906@crc.id.au>
 <4D5CA2B1.8020905@crc.id.au>
 <20110217095815.GN19830@htj.dyndns.org>
 <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au>
 <20110218091629.GC21209@htj.dyndns.org>
 <4D65C155.7080902@crc.id.au>
 <20110224083123.GB7840@htj.dyndns.org>
 <4D662A8B.5050501@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56806 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab1BXKGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2011 05:06:14 -0500
Received: by fxm17 with SMTP id 17so366788fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2011 02:06:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D662A8B.5050501@crc.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: linux-ide@vger.kernel.org, justin@jmicron.com

Hello,

(cc'ing Justin)

On Thu, Feb 24, 2011 at 08:53:15PM +1100, Steven Haigh wrote:
> On 24/02/2011 7:31 PM, Tejun Heo wrote:
> >Well, yeah, IDENTIFY failure is still there.  Controllers behave
> >differently and some may have higher tolerance under certain
> >circumstances but the setup just seems quite flimsy for whatever
> >reason.
> 
> Yeah - I noticed that. These things can never be simple, can they?!
> 
> >>Could it just be that the cradle is slow to initialise and therefore
> >>the sata_sil adapter gives up before the cradle is actually ready?
> >>
> >>Following this logic, I tried powering up the cradle before
> >>connecting the esata cable. I don't see anything in dmesg connecting
> >>the esata cable AFTER the cradle has been powered on. Maybe the
> >>cradle disables the esata connection if theres no cable connected on
> >>powerup?
> >
> >Is the cradle an active device or is it just power supply +
> >eSATA->SATA gender?  Oh, right, you said it also had USB connection,
> >so it's an active device.  Can you open it up and see which chip is
> >there?
> 
> Of course I can crack it open - thats what makes life fun!
> 
> The top side of the internal PCB is fairly plain with just the SATA
> power & data sockets on it and the various USB ports and card
> sockets on the front.
> 
> On the rear, we have a 30Mhz and a 12Mhz oscillator and 3 main CPU
> type chips.
> 
> Near the card readers:
> GL826 / MX2AE08G08 / 842H35518 - I assume this is the IDE / CF /
> card IO chip.

Yeah, that's the card reader.

> Near the rear:
> JMB352 / 0834 LGBA1 A / 370JF3011 - This looks to be hooked up via
> some capacitors to the DATA data lines on both sockets. If I haven't
> mentioned before, this is a 2 x SATA drive bay cradle.

This is the SATA part.

> A third tiny chip near the JMB352 is:
> GL850A / MN2FA01G11 / 911SK03111 - Not 100% sure of the function of
> this chip by following the tracks, but it looks like it might be
> some kind of a clock source. That is a wild guess though!

This is USB thingie.

So, the offending part is JMB352.  Justin, when JMB352 is doing e-SATA
interface, it's failing IDENTIFY.  sata_sil fails to recognize it and
ahci (right? Steven) succeeds only after IDENTIFY failures and
retries.  Any ideas what's going on?  When doing e-SATA, is the chip
active or passive?  ie. Does it just pass through the signals or do
some meddling inbetween?

Thanks.

-- 
tejun
