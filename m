From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 22:52:54 -0500
Message-ID: <yq1zkqp1vxl.fsf@sermon.lab.mkp.net>
References: <20110125030410.GA24024@MAIL.13thfloor.at>
	<yq14o8x3c8t.fsf@sermon.lab.mkp.net>
	<20110125033259.GC24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:53226 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab1AYDyp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 22:54:45 -0500
In-Reply-To: <20110125033259.GC24024@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 25 Jan 2011 04:32:59 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org

>>>>> "Herbert" == Herbert Poetzl <herbert@13thfloor.at> writes:

>> Align your partitions on a 4K boundary.

Herbert> While this will ensure that the drive performance is better
Herbert> than without doing so (I'm not using a partition table on that
Herbert> drive anyways, but I get what you mean), this doesn't inform
Herbert> the kernel about proper I/O sizes

The kernel doesn't enforce any "proper" I/O sizes at runtime other than
the logical block size.


Herbert> and for sure doesn't prevent unnecessary read-change-write
Herbert> operations for the disc ...

The other crucial component is passing the relevant options to mkfs.foo
to ensure the filesystem is formatted with 4KiB blocks.

If the drive had reported its block size correctly mkfs would have
picked this information up automatically. In this case, since the drive
doesn't indicate that it's using Advanced Format, you'll have to pass
the block size to mkfs by hand.

-- 
Martin K. Petersen	Oracle Linux Engineering
