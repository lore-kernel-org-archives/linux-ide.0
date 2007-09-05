From: Mark Lord <liml@rtr.ca>
Subject: Re: CF as IDE on ICH6M using libata
Date: Wed, 05 Sep 2007 13:28:11 -0400
Message-ID: <46DEE72B.2060702@rtr.ca>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com> <46DAB5DD.80807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1927 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbXIESBe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Sep 2007 14:01:34 -0400
In-Reply-To: <46DAB5DD.80807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ..
> I don't think the device supports UDMA.  Supported transfer modes are
> indicated in the IDENTIFY page (hdparm -I) and libata/ide would use UDMA
> if the device reports so.  There's no black magic there.
> 
>

Some newer CF Cards have a funky way of reporting UDMA.
Get a copy of hdparm-7.7 (sourceforge) and try "hdparm -I"
using it, and post the output here.

We may (or not) need to update libata to recognize UDMA on CF cards.

Cheers
