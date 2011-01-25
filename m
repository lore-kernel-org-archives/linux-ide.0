From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: WDC WD20EARS and 4k sector size
Date: Tue, 25 Jan 2011 11:26:14 +0300
Message-ID: <4D3E8926.70806@msgid.tls.msk.ru>
References: <20110125030410.GA24024@MAIL.13thfloor.at>	<yq14o8x3c8t.fsf@sermon.lab.mkp.net>	<20110125033259.GC24024@MAIL.13thfloor.at> <yq1zkqp1vxl.fsf@sermon.lab.mkp.net> <4D3E503B.40207@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:55438 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216Ab1AYI0R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jan 2011 03:26:17 -0500
In-Reply-To: <4D3E503B.40207@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Herbert Poetzl <herbert@13thfloor.at>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

25.01.2011 07:23, Mark Lord wrote:
> On 11-01-24 10:52 PM, Martin K. Petersen wrote:
> ..
>> If the drive had reported its block size correctly mkfs would have
>> picked this information up automatically.
> 
> Apparently revision 00Z drives now show 4096 physical sector size,
> with 512 for logical.  Can anyone out there confirm this first-hand?
> (hdparm -I)

There's no "00Z" revision for 20EARS, as far as I can tell.
There is, however, 00Z revision for 15EARS, which is 1.5Tb.

I've this drive:

 Model Family:     Western Digital Caviar Green (Adv. Format) family
 Device Model:     WDC WD20EARS-00MVWB0
 Serial Number:    WD-WMAZ20464440
 Firmware Version: 50.0AB50

this was the latest (the 3-platter version) of the drive
as were available ~2 months ago.

This drive does NOT report 4kb, it tells that both logical
and physical sector size is 512 bytes.  But it actually
uses 4kb sectors internally, which is visible when writing
by chunks of <4Kb with O_DIRECT: any size which is not
multiple of 4Kb and performance drops for a factor of 3..4.

Reportedly, WD15EARS with 00Z firmware does report all the
parameters correctly.  I've no idea what about WD10EARS,
more recentl 2TB+ drives and why they don't have (or do
they?) "right" firmware for 20EARS...

Thanks!

/mjt
