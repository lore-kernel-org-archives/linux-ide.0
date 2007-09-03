From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 03 Sep 2007 20:46:56 +0900
Message-ID: <46DBF430.1050508@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com>	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>	 <46DB755C.308@gmail.com> <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:21474 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbXICLrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 07:47:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so936710rvb
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 04:47:03 -0700 (PDT)
In-Reply-To: <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Eddie Hung wrote:
>> libata doesn't use SWDMA.  SWDMA is pointless to support.  It buys
>> almost nothing over PIO modes.  The condition to fall back to PIO is
>> very strict to prevent premature fall back.  I think it needs some
>> relaxation and special handling for cases where DMA transfer has never
>> succeeded after configuration so that it can fall back more easily.
> 
> Sorry, by SWDMA I meant PIO4 - and as the log shows - it does not seem
> to drop from MWDMA1 to the PIO modes - even after about 15 minutes.

Yeah, it seems the logic can't speed down to PIO only with timeouts.
The condition is more than 10 Cat-1 + Cat-2 + Cat-3 errors in 5 mins.
The timeout is 30secs so you can't do 10 of them within 5 mins.  It
needs fixing.

>>> I can confirm that my chipset does indeed support UDMA, here is the
>>> hdparm -I report on my original disk:
>> Yeah, it's really difficult to come by a controller which doesn't
>> support UDMA these days.
> 
> So from that, we can determine that the CF card doesn't support UDMA
> (or if you're being optimistic like I am - it doesn't report it, or it
> doesn't report it in a way which the controller recognises)

The report mechanism is simple and the controller doesn't have much to
do with it.  Bridge chip may affect it but I'm doubtful.

>> WXP uses PIO modes just fine.  I dunno how HDTune determines the current
>> transfer mode but if it uses IDENTIFY to query the device setting, it's
>> possible that the device reports MWDMA while the OS drives it in PIO
>> mode.  The best way to tell is watching cpu usage while transferring
>> data from the device.  If you're using mwdma, you won't see too high cpu
>> usage; otherwise, you'll notice high spikes during data transfer.  Can
>> you please try that and report?
> 
> Like I said before, the CF card is operating extremely slowly: HDTune
> shows that I'm getting 2MB/s burst which often drops to about 0.1MB/s
> - and the qualitative observation is the same as what I get when I'm
> using ide-generic.
> 
> My X41 has a 1.5Ghz P4M, and a 0.1MB/s hit (if it is using PIO) is
> hardly going to make a dent - I'm fairly sure that it is spending most
> of its time waiting for IO, but I shall take a deeper look tonight.

The beautiful thing about PIO is that it doesn't matter how fast your
cpu is.  Faster CPUs will just burn more cycles while transferring data
at the same measly speed. :-)

> What's confusing me is that my 40MB/s card only supporting MWDMA2 -
> which offers only a max transfer rate of 16.7MB/s - how have other
> people achieved 30MB/s then!?! (I'm referring to an ICH8 user who
> claims he has here, with a very similar CF card:
> http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/6818048.html

Whatever the device is, it should support UDMA to do 30MB/s.  MWDMA2
just can't reach that speed electronically.

> Also, does libATA support the PIO5 and PIO6 modes, which according to
> Wikipedia are not part of the ATA standard, but the CF 2.0 standard?
> (source: http://en.wikipedia.org/wiki/Programmed_input/output )

I dunno much about those fancy PIO modes.  Maybe Alan knows?

Thanks.

-- 
tejun
