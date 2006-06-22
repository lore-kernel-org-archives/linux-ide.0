From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Parking hard disk head from drivers
Date: Thu, 22 Jun 2006 16:05:24 -0400
Message-ID: <449AF804.4080205@pobox.com>
References: <20060622195904.GA30646@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161313AbWFVUFc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2006 16:05:32 -0400
In-Reply-To: <20060622195904.GA30646@hansmi.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, linux-kernel@killerfox.forkbomb.ch

Michael Hanselmann wrote:
> Hello
> 
> I'm working on a driver for the Apple Motion Sensor found in PowerBooks
> from 2005 and MacBooks. The chip doing the real work gives an interrupt
> when it detects a "freefall" or "shock". When that happens, Mac OS X
> parks the internal hard disk's head to minimize the possible damage.
> 
> What would be the best and accepted way to implement the parking in the
> Linux kernel? IMHO this has to be done in kernel space, because it has
> to be instant.
> 
> My idea was to extend the genhd layer by a function to receive the
> gendisk structure by the HD's name (foo("hda"), foo("sda")). This might
> work, because the internal HD is always the first one. Another idea was
> to do it in the ide-disk (PowerBooks, later iBooks) and libata code
> (MacBooks), depending on which type is available.

If I had to guess, I would say use a notifier...

	Jeff



