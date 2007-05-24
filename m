From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Thu, 24 May 2007 15:34:14 -0500
Message-ID: <20070524203414.GO5921@austin.ibm.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41136 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbXEXUeQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 16:34:16 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OKYFGq001519
	for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 16:34:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4OKYF4w518998
	for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 16:34:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4OKYEa5028210
	for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 16:34:15 -0400
Content-Disposition: inline
In-Reply-To: <4655F43D.2090402@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

Hi,

On Fri, May 25, 2007 at 12:23:25AM +0400, Sergei Shtylyov wrote:
> Hello, I wrote:
> >HPT36x chip don't seem to have the channel enable bits, so prevent the IDE 
> >core from checking them...
> 
> >Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > 	d->channels = 1;
> >+	d->enablebits[0].reg = 0;

The original patch worked for me.

>    Linas, Andries, Michal, cound you try this instead:
> 
> 	d->enablebits[0].mask = d->enablebits[0].val = 0x10;

Based on the printk's from my system, this should work fine.
The config register had 0x33 in it, so 0x33 & mask == val for me.
I'll reply tommorrow if this doesn't work.

--linas

