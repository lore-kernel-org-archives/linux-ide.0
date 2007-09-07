From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Fri, 07 Sep 2007 09:44:51 +0900
Message-ID: <46E09F03.7010704@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca>	 <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com>	 <46E03DF6.8090405@gmail.com> <6f9550040709061456h6f9a64ebgec9dbe457a836138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:14411 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbXIGApA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 20:45:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so360742wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 17:44:59 -0700 (PDT)
In-Reply-To: <6f9550040709061456h6f9a64ebgec9dbe457a836138@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

[adding-back linux-ide, please don't drop cc's]

Eddie Hung wrote:
> On 06/09/07, Tejun Heo <htejun@gmail.com> wrote:
>> Eddie Hung wrote:
>>> However, I think we can conclude that ICH6M (which on the X41, has a
>>> SATA-PATA bridge to connect a PATA drive) does not seem to support
>>> MWDMA
>> It isn't clear whether the fault is at the driver or the CF device.
> 
> I have tried two separate CF cards which support MWDMA, and they both
> exhibit the same problems. You're right in that it could potentially
> be the CF-IDE adapter - but the adapter works with UDMA, so I'm
> guessing it should also work with MWDMA?

Not really.  MWDMA support seems especially wonky on CF devices.  I'm
not completely sure whether MWDMA support is broken on ata_piix or there
are just a lot of broken CF devices because windows doesn't use MWDMA.

>>> (especially as it is not completely supported under Windows
>>> either - it is *incredibly* slow but does not give the same timeout
>>> problems as with libata),
>> Please verify which mode is in use in Windows.  Just watching cpu usage
>> in the task manager while transferring data should give you a pretty
>> good idea.
> 
> I no longer have Windows installed (it is frustratingly, frustratingly
> slow regardless - which in my books means something definitely isn't
> right).

Aieeee... We need confirmation.

> There also seems to be some ambiguity (at least in libata) where MWDMA
> is associated with PIO (i.e. one of my error messages was something
> along the lines of: "dropping down to MWDMA1:PIO4" - which is maybe
> what Windows is doing as well?

PIO mode is always configured no matter which DMA mode is used.
Significant part of ATA depends on PIO (e.g. transferring commands to
the device, IDENTIFY, ...)

So that we can blacklist them, please post 'hdparm -I' results of both
devices with MWDMA.

Alan, Jeff, if windows doesn't use MWMDA on CF devices, I think we
probably shouldn't either.  I don't think supporting MWDMA is worth the
trouble considering only small fraction of this type of problems would
make it to linux-ide or bugzilla.

Thanks.

-- 
tejun
