From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: something strange in libata-core.c for kernel 2.6.22-rc3
Date: Mon, 21 May 2007 12:15:37 +0100
Message-ID: <20070521121537.48dd2b2c@the-village.bc.nu>
References: <fa.MCe9nCgx+WnsHp+weZyM9LiDF0s@ifi.uio.no>
	<fa.rv8/6n3uBnAIoUHHNUW3eR7cJd8@ifi.uio.no>
	<fa.LXy58QwLlPXDhsfVUU9kEfA3QbI@ifi.uio.no>
	<fa.Ldjy2OubeKomZD0OV2gRm/wpUFo@ifi.uio.no>
	<46515983.6030206@shaw.ca>
	<465161AF.6030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60058 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508AbXEULK5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 07:10:57 -0400
In-Reply-To: <465161AF.6030002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, l.genoni@oltrelinux.com


> Yeah, that's consistent to what I've seen on my machine which is a
> variant of A8N.  No matter what value I through at _STM, _GTM just
> echoed the result thus always leading to 80c configuration.
> 
> > I guess this means that what we have to do is trust that the BIOS set up
> > a reasonable mode and base the cable detect on that (either by reading
> > back the boot-up controller registers, or by calling GTM). I imagine
> > this is what the Windows default IDE driver is doing (just using the
> > boot-up mode and feeding it back using GTM/STM on suspend/resume cycles).
> 
> Alan, what do you think?

Interesting, sounds like it is still useful rather than just reading the
registers as the GTM/STM seem to survive resume cycles which drive config
may not (eg if the driver is loaded after a s2ram/resume.

If it just echoes back we should also be able to detect this by using
knowingly invalid values.

Alan
