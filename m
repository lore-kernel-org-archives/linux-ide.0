From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Mon, 26 Apr 2004 16:50:40 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404261650.40801.bzolnier@elka.pw.edu.pl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404221635.12490.bzolnier@elka.pw.edu.pl> <20040426135058.GC14074@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37599 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261186AbUDZOvd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Apr 2004 10:51:33 -0400
In-Reply-To: <20040426135058.GC14074@harddisk-recovery.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 26 of April 2004 15:50, Erik Mouw wrote:
> On Thu, Apr 22, 2004 at 04:35:12PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 22 of April 2004 12:33, Erik Mouw wrote:
> > > What makes IDE sufficiently different from SCSI that we can't unload
> > > IDE host drivers?
> >
> > - no reference counting
> > - lack of release() method
> > - insufficient locking
>
> Do you plan to fix the module unloading in the current code, or is it
> easier to write a new driver based on libata (assuming it has been
> fixed in libata)? If I understood Jeff's latest libata update

I'm going to fix it but doing it properly requires major changes in IDE
code (ie. get rid of static &ide_hwifs[]) but it's happening slowly.

> correctly, it should be possible Real Soon Now [tm], right?

BTW I think there is a common misunderstanding about libata:
    it will not replace IDE drivers any time soon.

I want to rewrite+merge current IDE code with libata during 2.7
(and yes, legacy naming and ordering will be preserved!).

I hope nobody starts rewriting existing IDE drivers for libata and pushing
them upstream -> it will mean maintenance problems much bigger than OSS+ALSA.

However writing _new_ libata driver for 'exotic' PATA hardware is OK.

Cheers,
Bartlomiej

