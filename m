From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code
 issues / 2.6.15.4
Date: Sun, 26 Feb 2006 15:36:17 -0500
Message-ID: <44021141.6000601@rtr.ca>
References: <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>	 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>	 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>	 <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca>	 <4401BB85.7070407@superbug.co.uk> <4401DF6B.9010409@rtr.ca>	 <20060226171307.GA9682@gallifrey> <1140975791.27539.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:57546 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751227AbWBZUgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Feb 2006 15:36:32 -0500
In-Reply-To: <1140975791.27539.19.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, James Courtier-Dutton <James@superbug.co.uk>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com

Alan Cox wrote:
>
> The very early SATA code didnt decode the errors from the drive fully so
> could produce bogus reports. The current code decodes it and also
> displays the ATA level diagnostics so should be reliable.

It still is unreliable, as being discussed in another thread.

libata wrongly says "medium error" any time it issues a command
that the drive rejects (unsupported, invalid parameters, etc..).

This is biting a few people in 2.6.16-rc*, due to the FUA stuff.
