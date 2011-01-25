From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Mon, 24 Jan 2011 22:15:14 -0500
Message-ID: <yq14o8x3c8t.fsf@sermon.lab.mkp.net>
References: <20110125030410.GA24024@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:39024 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1AYDP5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 22:15:57 -0500
In-Reply-To: <20110125030410.GA24024@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 25 Jan 2011 04:04:10 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

>>>>> "Herbert" == Herbert Poetzl <herbert@13thfloor.at> writes:

Herbert>  - the drive doesn't report 4k sectors at all, not
Herbert>    even as physical sector size.

There have been numerous threads on this list about EARS not reporting
block sizes correctly. Check the archives.


Herbert> My question now is, how can I tell the kernel that this drive
Herbert> actually has 4k physical sectors and that it would be a smart
Herbert> thing to send requests in some kind of 4k I/O chunks?

Align your partitions on a 4K boundary.

-- 
Martin K. Petersen	Oracle Linux Engineering
