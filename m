From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Fri, 19 Oct 2007 18:21:53 +0200
Message-ID: <64bb37e0710190921w66efe89dl1136d08328123629@mail.gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
	 <4716DC7D.6050007@gmail.com>
	 <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>
	 <471804CA.9040103@gmail.com>
	 <64bb37e0710182151j6992cde3u4f9ae60aa70e22eb@mail.gmail.com>
	 <47183B31.4080002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:20957 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbXJSQVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 12:21:54 -0400
Received: by py-out-1112.google.com with SMTP id u77so1052971pyb
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 09:21:54 -0700 (PDT)
In-Reply-To: <47183B31.4080002@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/19/07, Tejun Heo <htejun@gmail.com> wrote:
> Torsten Kaiser wrote:
> > Just remebered another thing about sata_sil24 that popped up with 2.6.23-mm1.
> > With this kernel version (comparing to 2.6.23-rc8-mm1) the port
> > probing time goes up from ~0.5 seconds per port/drive to ~2 seconds.
> > Also the SControl changed:
> >
> > 2.6.23-rc8-mm1:
> > [    4.110000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > 2.6.23-mm1:
> > [    5.930000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> >
> > But except for increased delay during boot no errors can seen, the
> > drives work normally.
>
> Yeah, PARTIAL / SLUMBER mode restriction is lifted.  Dunno whether
> that's related to the increased delay tho.  Will investigate.

But don't invest too much time into this.
That the delay is part of the broken ACPI of this board/bios seems
very likely to me.
(And apart from that delay there seems to be no other changes.)

Torsten
