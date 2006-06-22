From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Parking hard disk head from drivers
Date: Thu, 22 Jun 2006 21:59:05 +0200
Message-ID: <20060622195904.GA30646@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:44316 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1030373AbWFVT7L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jun 2006 15:59:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, jgarzik@pobox.com, linux-kernel@killerfox.forkbomb.ch

Hello

I'm working on a driver for the Apple Motion Sensor found in PowerBooks
from 2005 and MacBooks. The chip doing the real work gives an interrupt
when it detects a "freefall" or "shock". When that happens, Mac OS X
parks the internal hard disk's head to minimize the possible damage.

What would be the best and accepted way to implement the parking in the
Linux kernel? IMHO this has to be done in kernel space, because it has
to be instant.

My idea was to extend the genhd layer by a function to receive the
gendisk structure by the HD's name (foo("hda"), foo("sda")). This might
work, because the internal HD is always the first one. Another idea was
to do it in the ide-disk (PowerBooks, later iBooks) and libata code
(MacBooks), depending on which type is available.

Thanks,
Michael
