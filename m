From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/18] ide: use ->tf_read in ide_read_error()
Date: Mon, 16 Feb 2009 22:17:08 +0100
Message-ID: <200902162217.08541.bzolnier@gmail.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <49995856.0@ru.mvista.com> <49995B44.6090604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:37858 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbZBPVyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 16:54:03 -0500
In-Reply-To: <49995B44.6090604@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 16 February 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>>   register and handle it in ->tf_read.
> >>>   
> >>
> >>  Doesn't seem like a good name -- you can't read the features 
> >> register. I should've commented to this patch earlier, of course...

[ Yeah... preferably in June 2008 when this patch was posted... ]

> > * Add IDE_TFLAG_IN_FEATURE taskfile flag for reading Feature

Trivial s/IN_*FEATURE/IN_*ERROR/ should do the job.

I will fix it later unless you beat me to it.

> >   Moreover, the error register shoudn't be affeceted by the HOB bit, 
> > so this flag doesn't make sense.
> 
>    I meant IDE_TFLAG_IN_HOB_FEATURE, of course.

Once again blame the certain ioctl (you know which one)... :)

Thanks,
Bart
