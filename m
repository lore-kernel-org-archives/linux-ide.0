From: Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and
	->ata_*put_data methods
Date: Wed, 9 Apr 2008 20:13:14 +0200
Message-ID: <20080409181314.GA999@linux-m68k.org>
References: <200803301714.04527.bzolnier@gmail.com> <200803302134.42569.bzolnier@gmail.com> <Pine.LNX.4.64.0803310750230.6871@anakin> <200804072113.42441.bzolnier@gmail.com> <20080408094029.GA1005@linux-m68k.org> <alpine.DEB.1.00.0804090337110.19638@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:24278 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbYDISJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 14:09:08 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2421210fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 11:09:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804090337110.19638@zirkon.biophys.uni-duesseldorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>

On Wed, Apr 09, 2008 at 03:40:34AM +0200, Michael Schmitz wrote:

> > However, not only FS data is byteswapped, complete disk including partition
> > table and everything else is. Will "rq->cmd_type == REQ_TYPE_FS" also catch
> > all these cases?
> 
>  IIRC only identify data (and perhaps ATAPI data) need to be byteswapped 
>  twice (or not at all), so REQ_TYPE_FS should catch all other cases.

my main worry is whether REQ_TYPE_FS is set even when using raw disk access,
eg reading partition table or raw partitions.

The partition table initialisation is one of the reasons why using dmapper
would be a major pain btw.

>  (Good catch about ATAPI there, BTW - I never thought about that, and ISTR 
>  that IDE CD-ROMs never worked in Linux. That would be the reason why..)

IDE CDROM works perfectly on the Q40?

Richard
