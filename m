From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 10 Sep 2007 19:19:10 +0100
Message-ID: <20070910191910.53eed32c@the-village.bc.nu>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	<46DAB5DD.80807@gmail.com>
	<46DEE72B.2060702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43481 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbXIJSLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Sep 2007 14:11:39 -0400
In-Reply-To: <46DEE72B.2060702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Eddie Hung <eddie.hung@gmail.com>, linux-ide@vger.kernel.org

On Wed, 05 Sep 2007 13:28:11 -0400
Mark Lord <liml@rtr.ca> wrote:

> Tejun Heo wrote:
> > ..
> > I don't think the device supports UDMA.  Supported transfer modes are
> > indicated in the IDENTIFY page (hdparm -I) and libata/ide would use UDMA
> > if the device reports so.  There's no black magic there.
> > 
> >
> 
> Some newer CF Cards have a funky way of reporting UDMA.
> Get a copy of hdparm-7.7 (sourceforge) and try "hdparm -I"
> using it, and post the output here.
> 
> We may (or not) need to update libata to recognize UDMA on CF cards.

Is there any more (standards type) information on this and what is
needed ?
