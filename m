From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 19:45:04 -0400
Message-ID: <44691280.9040600@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <1147736327.26686.224.camel@localhost.localdomain> <20060515234743.GD4699@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45523 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750804AbWEOXpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:45:08 -0400
In-Reply-To: <20060515234743.GD4699@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Alan Cox wrote:
>> On Llu, 2006-05-15 at 19:02 -0400, Wakko Warner wrote:
>>> How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
>>> blow the hard drive away if I want to.
>> Give the patch on zeniv.linux.org.uk/~alan/IDE a go in that case and let
>> me know how it behaves.
> 
> I noticed one hunk failed with 2.6.17-rc4 when using
> patch-2.6.17-rc3-ide2.gz
> 
> It was only the version string so I should be ok.  As I said, if it blows up
> on me, that's ok.
> 
> I attempted to patch Jeff's libata1 over top of this, it failed miserably.
> 
> When I patched Jeff's libata1 over 2.6.17-rc4, it was ok, except for 2
> files:

oh, its almost certain the patches will conflict.  My suggestion was 
more of a reference-<here>-if-things-break.

	Jeff



