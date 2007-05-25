From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Fri, 25 May 2007 12:58:30 -0500
Message-ID: <20070525175830.GA4323@austin.ibm.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <4655F43D.2090402@ru.mvista.com> <20070524203414.GO5921@austin.ibm.com> <4655FB3F.2070605@ru.mvista.com> <465607D8.3030207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58483 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbXEYR6d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 13:58:33 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4PHwWt8030106
	for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 13:58:32 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l4PHwW8V519712
	for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 13:58:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l4PHwVZh006137
	for <linux-ide@vger.kernel.org>; Fri, 25 May 2007 13:58:32 -0400
Content-Disposition: inline
In-Reply-To: <465607D8.3030207@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, michal.kepien@poczta.onet.pl

On Fri, May 25, 2007 at 01:47:04AM +0400, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>  Linas, Andries, Michal, cound you try this instead:
> >>>
> >>>    d->enablebits[0].mask = d->enablebits[0].val = 0x10;
> 
> >   It probably won't work the way it should anyway -- the secondary 
> >channel (and controller in this case) uses another bit in this register 
> >and the controllers get registered with IDE core "in pair".

Setting d->enablebits[0].mask = d->enablebits[0].val = 0x10; makes
my system bootable, and so this works well enough for me.  Without this
patch, mainline 2.6.21.1 is broken, and so I'll say it again:

Please submit a patch to the stable branch so that this gets generically
fixed!  I'll happily Ack it. 

--linas
