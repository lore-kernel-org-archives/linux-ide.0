From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Wed, 11 Mar 2009 23:33:05 +0100
Message-ID: <200903112333.05478.bzolnier@gmail.com>
References: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:50696 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZCKWau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 18:30:50 -0400
Received: by fxm24 with SMTP id 24so184853fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 15:30:47 -0700 (PDT)
In-Reply-To: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n0diamond@yahoo.co.jp
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Chuck Ebbert <cebbert@redhat.com>, Robert Hancock <hancockrwd@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

On Monday 02 March 2009, Norman Diamond wrote:
> I will try building a kernel without legacy IDE drivers,
> but meanwhile here's the latest bug.
> 
> Knoppix 6.0.1 is built on kernel 2.6.28.4.  Legacy IDE
> drivers still claim /dev/hda and /dev/hdc (the Knoppix CD
> being on /dev/hdc).
> 
> In order to view part of a dump if it occurs, I typed the
> following boot command:
> knoppix 3 lang=en keyboard=jp106
> 
> When I try to do a TASKFILE WRITE_DMA (LBA28), the process
> hangs.  No dump.  Ctrl+C and Ctrl+Z were ignored. 

Could you post source code of your program or at least
the minimal test case reproducing the problem?

Thanks,
Bart
