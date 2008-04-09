From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and ->ata_*put_data methods
Date: Wed, 9 Apr 2008 20:49:25 +0200
Message-ID: <200804092049.25594.bzolnier@gmail.com>
References: <200803301714.04527.bzolnier@gmail.com> <alpine.DEB.1.00.0804090337110.19638@zirkon.biophys.uni-duesseldorf.de> <20080409181314.GA999@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:55005 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYDISi3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Apr 2008 14:38:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1239007nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2008 11:38:27 -0700 (PDT)
In-Reply-To: <20080409181314.GA999@linux-m68k.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>


Hi,

On Wednesday 09 April 2008, Richard Zidlicky wrote:
> On Wed, Apr 09, 2008 at 03:40:34AM +0200, Michael Schmitz wrote:
> 
> > > However, not only FS data is byteswapped, complete disk including partition
> > > table and everything else is. Will "rq->cmd_type == REQ_TYPE_FS" also catch
> > > all these cases?
> > 
> >  IIRC only identify data (and perhaps ATAPI data) need to be byteswapped 
> >  twice (or not at all), so REQ_TYPE_FS should catch all other cases.
> 
> my main worry is whether REQ_TYPE_FS is set even when using raw disk access,
> eg reading partition table or raw partitions.

AFAIK direct I/O is also handled by REQ_TYPE_FS requests so it should be fine.

Only special commands (identify, S.M.A.R.T., raw commands passed through
taskfile ioctl) should be byte-swapped.

I just merged the patch into IDE tree (together with few other changes)
so some testing would be greatly appreciated.

Thanks,
Bart
