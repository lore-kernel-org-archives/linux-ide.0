From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Wed, 25 Feb 2009 20:35:05 +0100
Message-ID: <200902252035.05347.bzolnier@gmail.com>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:57141 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbZBYUCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 15:02:54 -0500
Received: by bwz26 with SMTP id 26so157080bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 25 Feb 2009 12:02:51 -0800 (PST)
In-Reply-To: <49A570DB.8090401@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Norman Diamond <n0diamond@yahoo.co.jp>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Wednesday 25 February 2009, Mark Lord wrote:
> Norman Diamond wrote:
> ..
> > Does anyone know when this bug was added?  2.6.19 is too old for my needs,
> > but the range 2.6.24 to 2.6.26 might be OK if they had taskfiles working.
> > Maybe I should look for a Slax version that had a kernel from 2.6.24 or so,
> > since I can probably customize it in a single day by now.  But if the bug
> > was already present in 2.6.24 then it would be a waste of time.
> ..
> 
> Heh.. the question could be more like, does anyone know which few kernels
> that HDIO_DRIVE_TASKFILE ever worked completely on?  :)
> 
> I know I have to patch drivers/ide rather heavily to get a working,
> reliable HDIO_DRIVE_TASKFILE on it.
> 
> Much better is to move to libata, and use ATA_16 with SG_IO,
> for a standard, working way of doing this kind of stuff.

While SG_IO is definitely better way to go submitting your
HDIO_DRIVE_TASKFILE patches wouldn't hurt...

Thanks,
Bart
