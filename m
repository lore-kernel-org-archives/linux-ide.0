From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Fri, 19 Oct 2007 06:51:09 +0200
Message-ID: <64bb37e0710182151j6992cde3u4f9ae60aa70e22eb@mail.gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
	 <4716DC7D.6050007@gmail.com>
	 <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>
	 <471804CA.9040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:44895 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbXJSEvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 00:51:10 -0400
Received: by py-out-1112.google.com with SMTP id u77so732595pyb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 21:51:09 -0700 (PDT)
In-Reply-To: <471804CA.9040103@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Ip, Clarence" <CIP@harris.com>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

On 10/19/07, Tejun Heo <htejun@gmail.com> wrote:
> Torsten Kaiser wrote:
> > I'm currently using 2.6.23-mm1 and 16 boots where all good.
> > (Apart from the unrelated failure with sata_nv and swncq...)
>
> I see, a different issue then.  It's just weird to see similar issues
> popping up now after allterm the time sata_sil24 has been around.

Just remebered another thing about sata_sil24 that popped up with 2.6.23-mm1.
With this kernel version (comparing to 2.6.23-rc8-mm1) the port
probing time goes up from ~0.5 seconds per port/drive to ~2 seconds.
Also the SControl changed:

2.6.23-rc8-mm1:
[    4.110000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
2.6.23-mm1:
[    5.930000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)

But except for increased delay during boot no errors can seen, the
drives work normally.

> Clarence, it seems it could be that what's broken is irq routing not
> sata_sil24 itself  I dunno anything about irq routing on PPC440SPE but I
> bet there are kernel parameters to adjust them including irqpoll.  Do
> those have any effect?

(Both kernel assign the same irq (17) to the controller. So at least
this delay is not caused by irq routing)

Part of what I suspect in this case is the ACPI of my bios. As there
is one checksum error and the cable detection of the pata port is
completly broken, it might be that this delay is also its fault.

But as I think that ACPI is limited to x86, I doubt this is related...

Torsten
