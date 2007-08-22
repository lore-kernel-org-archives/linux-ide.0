From: Paul Wakeman <prwakeman@yahoo.com>
Subject: Re: PATA hotplug
Date: Wed, 22 Aug 2007 07:19:39 -0700 (PDT)
Message-ID: <548551.9705.qm@web57903.mail.re3.yahoo.com>
References: <20070819180611.7b83e476@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web57903.mail.re3.yahoo.com ([68.142.236.96]:28346 "HELO
	web57903.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762938AbXHVOTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 10:19:40 -0400
In-Reply-To: <20070819180611.7b83e476@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Fri, 17 Aug 2007 08:56:35 -0700 (PDT)
> Paul Wakeman <prwakeman@yahoo.com> wrote:
> 
> > Does libata support PATA hotplug?
> > 
> > I have a PCMCIA CF using TrueIDE mode and want to be able to
> hotplug CF
> > cards. Would I get hotplug for free if I convert the existing IDE
> > driver to a libata pata platform driver?
> 
> If your hardware supports PATA hotplug (most doesn't) then you can
> tell
> the kernel to remove the device, pull it, add a new one and tell the
> kernel to rescan (exactly as you do with any other scsi device).
> Autodetect support right now is only in the SATA side and afaik no
> PATA
> controller supports PATA hot plug autodetect.

My target is an embedded SoC which has PATA autodetect support.

First, I need to convert the vendor-supplied legacy IDE driver to a
PATA platform driver. Can you recommend best-of-breed existing PATA
drivers to use as a reference for this work? 

Thanks

-paul


      ____________________________________________________________________________________
Park yourself in front of a world of choices in alternative vehicles. Visit the Yahoo! Auto Green Center.
http://autos.yahoo.com/green_center/ 
