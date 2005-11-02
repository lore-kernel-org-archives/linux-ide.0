From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Wed, 2 Nov 2005 12:42:19 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF38@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:54719 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S965231AbVKBUmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 15:42:25 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Martin Murray <mmurray@deepthought.org>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org


Hi,

> 
>  <snip>
> >
> >     One thing I don't understand is, if Mr. Thelin's code 
> that requests,
> > as said, a little over 128k is a DMA command, then 
> shouldn't the kernel
> > have bugged? And if it didn't bug, was the data transferred 
> via PIO? Or
> 
> I suppose so.
> 

Yes, the transfers were all PIO

Regards,
Tim Thelin
