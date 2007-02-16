From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Date: Fri, 16 Feb 2007 18:37:44 +0100
Message-ID: <20070216173744.GA7520@aepfle.de>
References: <20070210203512.GA25586@aepfle.de> <45D4E82B.7020403@garzik.org> <20070216092046.GA2572@aepfle.de> <200702161546.01159.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52097 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXBPRhf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 12:37:35 -0500
Content-Disposition: inline
In-Reply-To: <200702161546.01159.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, Feb 16, Bartlomiej Zolnierkiewicz wrote:

> 
> Hi,
> 
> On Friday 16 February 2007 10:20, Olaf Hering wrote:
> > 
> > Change the default for the built-in IDE on p610/p615/p630 from
> > ide to libata. libata has better error handling and the drive can
> > recover when hald does its CD media polling.
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> Does IDE sl82c105 need the same udelay() fix patch as done for
> pata_winbond?

I dont know, but I suspect a delay is required somewhere.
