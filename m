From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Tue, 30 Oct 2007 16:10:37 +0000
Message-ID: <20071030161037.54c41fff@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<472755A1.5080703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41792 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbXJ3QJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 12:09:08 -0400
In-Reply-To: <472755A1.5080703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> > Any ideas?
> 
> hrm
> 
> we may need to make that controller-specific, given that the code prior 
> to 2db78dd302d26d242d3e8e5c4c5024b6c3ea93c2 was working for most...

Removing it breaks some devices on any controller.

I don't think this one is a simple compatibility issue - its a behaviour
we have done for ten years on PIIX/ICH chipsets without problems in the
old IDE. Also those logs of 66 bytes overrun are worrying - the app is
either issuing incorrectly sized commands, the drive is providing
incorrectly sized answers or something really evil is going on in the
midlayer translations.

And the ICH7 is in fact the chipset I did the original testing on ...

Need to work out if this is some nutty gentoo app, a quirky device we need
to dig into or something else. I've asked Daniel for some first test
points to try and eliminate the obvious.

Alan
