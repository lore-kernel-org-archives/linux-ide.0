From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
Date: Wed, 17 Nov 2004 15:54:16 +0000
Message-ID: <1100706838.420.47.camel@localhost.localdomain>
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
	 <58cb370e04111605019fc1df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:28901 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262432AbUKQQ5r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2004 11:57:47 -0500
In-Reply-To: <58cb370e04111605019fc1df8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

On Maw, 2004-11-16 at 13:01, Bartlomiej Zolnierkiewicz wrote:
> Previously VIA IDE driver ignored DMA blacklists completely
> (which was of course wrong), it was fixed.
> 
> Probably this drive should be removed from the blacklist.
> Does anybody remember why was it added there?

As I said before almost all of our blacklist is junk from when the IDE
ATAPI DMA bug wasn't fixed.

