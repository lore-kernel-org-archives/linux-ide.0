From: Mark Lord <liml@rtr.ca>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Wed, 16 Aug 2006 18:54:39 -0400
Message-ID: <44E3A22F.20400@rtr.ca>
References: <44E1D760.6070600@atipa.com>	 <1155654379.24077.286.camel@localhost.localdomain>	 <44E1E719.6020005@atipa.com> <1155657316.24077.293.camel@localhost.localdomain> <44E208AD.8060505@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:29593 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932314AbWHPWyk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2006 18:54:40 -0400
In-Reply-To: <44E208AD.8060505@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Roger Heflin wrote:
>
> It looks like the older DMA recovery code never works on this chipset,
> once it goes into DMA recovery it never comes out of it.    I am looking
> at that to see if anything can be done about it.

You could try booting with ide2=serialize as a kernel parameter.
That should ensure the two channels are never in use simultaneously.
Trades off a bit of performance for a bit of reliability.

Cheers
