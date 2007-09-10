From: Mark Lord <liml@rtr.ca>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 10 Sep 2007 15:39:06 -0400
Message-ID: <46E59D5A.8050907@rtr.ca>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	<46DAB5DD.80807@gmail.com>	<46DEE72B.2060702@rtr.ca> <20070910191910.53eed32c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1351 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965297AbXIJTjF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2007 15:39:05 -0400
In-Reply-To: <20070910191910.53eed32c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Eddie Hung <eddie.hung@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Wed, 05 Sep 2007 13:28:11 -0400
> Mark Lord <liml@rtr.ca> wrote:

>> We may (or not) need to update libata to recognize UDMA on CF cards.
> 
> Is there any more (standards type) information on this and what is
> needed ?

No update required, as CF cards mimic regular drives well enough for this.
The weird stuff I was thinking of is only applicable to non "True IDE" modes.

Cheers
