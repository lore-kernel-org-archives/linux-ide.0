From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Thu, 28 Sep 2006 15:07:29 -0700
Message-ID: <20060928220729.GB8064@geeks.org>
References: <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org> <44F8365C.2020609@gmail.com> <20060901172435.GA26975@geeks.org> <20060902053459.GA4467@geeks.org> <20060903062653.GA4340@geeks.org> <44FB26FA.4070704@gmail.com> <20060903200449.GA9607@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:49890 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S932524AbWI1WHb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 18:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20060903200449.GA9607@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

> > >I'm not sure if this will affect PCI-X configurations, but it is
> > >certainly worth trying.
> > 
> > Can you post full result of "lspci -vvv -xxx"?  I'm curious why things 
> > ended up that way.
> 
> Below.  This output shows the modified cache line config for the 3124,
> btw.

FWIW, I got ahold of a system with the same host bridge but with a 3124
on the primary PCI bus, and the cache line size was properly configured.

Something to do with the cardbus bridge, perhaps...

Derek
