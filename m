From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 6 Feb 2009 17:50:24 +0100
Message-ID: <200902061750.24258.bzolnier@gmail.com>
References: <200902031147.22827.stf_xl@wp.pl> <498B0F22.3090403@ru.mvista.com> <498C173F.4000908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:56815 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZBFQuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 11:50:04 -0500
Received: by ewy13 with SMTP id 13so1477594ewy.18
        for <linux-ide@vger.kernel.org>; Fri, 06 Feb 2009 08:50:02 -0800 (PST)
In-Reply-To: <498C173F.4000908@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

On Friday 06 February 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>    Can you answer the simple question: why we should try to support 
> >> two incompatible chips with a single driver? Because the driver name 
> >> will be shorter? :-)
> >
> >> Very funny. I think patch adding RM9200 support to this driver will 
> >> have less
> >> than 50 lines changeset,  whereas writing new driver would be about 
> >> 500 lines.
> >
> >    This approach is so broken-minded that I'm just out words to argue 
> > any more.
> > 
> >    Let's then support say all the PCI IDE chipsets with the single 
> > driver (actully, there was a driver that tried to support 2 
> > incompatible Promise chip families but it got split finally).

Actually it was the case for Linux during early 2.4.x days. :)

[ Probably for historical reasons. ]

>    To say the truth, there are stil at least 2 examples of such drivers: 
> hpt366 and aec6210. While the former is justified by the bogus chip 

The former can be probably still improved with hpt3xx_main.c and chipset
family specific code separated into hpt36x.c etc.

> identification poilicy used by the vendor, the latter has no 
> justification at all.

Patches are always warmly welcomed.

Thanks,
Bart
