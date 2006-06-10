From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [2.6.17-rc6-mm1] Oops during sata_promise init
Date: Sat, 10 Jun 2006 13:03:16 -0400
Message-ID: <448AFB54.3080006@garzik.org>
References: <Pine.LNX.4.61.0606101715440.3135@cinatas.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63678 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932455AbWFJRDU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jun 2006 13:03:20 -0400
In-Reply-To: <Pine.LNX.4.61.0606101715440.3135@cinatas.ath.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: prx <root@cinatas.ath.cx>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

prx wrote:
> Hi,
> 
> sorry for my late answer.
> 
> The hardware which Oopses due to the third (PATA) channel is:
> 02:0b.0 Mass storage controller: Promise Technology, Inc.
> PDC20575 (SATAII150 TX2plus) (rev 02)
> 
> I know it's the PATA chan which fails because i commented the
> part discovering the third channel out, giving me a working
> system :)

OK, thanks.

So it sounds like either #upstream broke #promise-sata-pata, or simply a 
bug got introduced into the only-used-in-mm-trees version of sata_promise.c.

I will look into it, but since Promise PATA-on-SATA support is still 
highly experimental, I can't promise an immediate response.  This isn't 
something that is in 2.6.17-rc, or even something going into 2.6.18.

	Jeff



