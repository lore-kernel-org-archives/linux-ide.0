From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add DMA blacklist to libata
Date: Fri, 7 Jan 2005 04:03:38 +0100
Message-ID: <58cb370e05010619031b753a64@mail.gmail.com>
References: <41DDE79F.8090601@pobox.com>
	 <1105062573.17176.316.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:42926 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261212AbVAGDDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 22:03:41 -0500
Received: by wproxy.gmail.com with SMTP id 37so122606wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2005 19:03:38 -0800 (PST)
In-Reply-To: <1105062573.17176.316.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 07 Jan 2005 01:55:06 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-01-07 at 01:36, Jeff Garzik wrote:
> > For review.  I checked this into libata-dev just now.
> >
> > Design decisions:
> > * no whitelist.  Worst case is a few more devices will use PIO.
> > * no firmware rev checking.  Worst case is a few more models (2) will
> > use PIO.

Looks OK.
 
> Seems reasonable for now although its so trivial to do. Expect the DMA
> list for CD devices to shrink over time as well (Bart already zapped a
> few).

Just removed another one - "CRD-8480C".
