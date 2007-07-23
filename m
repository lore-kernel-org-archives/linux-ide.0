From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/11] ide: add __ide_wait_stat() helper
Date: Mon, 23 Jul 2007 23:22:31 +0200
Message-ID: <200707232322.31495.bzolnier@gmail.com>
References: <200707222031.30499.bzolnier@gmail.com> <46A4AA97.9060702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475AbXGWVZj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40025ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:38 -0700 (PDT)
In-Reply-To: <46A4AA97.9060702@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Monday 23 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Split off checking of the status register from ide_wait_stat() to
> >   __ide_wait_stat() helper.
> 
> > * Use the new helper in ide_config_drive_speed().  The only change in the
> >   functionality is that the function now fails if after 20 sec (WAIT_CMD)
> >   device is still busy (BUSY_STAT bit is set) while previously instead of
> >   failing the function continued with checking for the correct device status
> >   (which would give the device additional 10 usec to clear BUSY_STAT bit).
> 
> > * Remove stale comment for ide_config_drive_speed().
> 
> > * Remove duplicate comment for ide_wait_stat() from <linux/ide.h>.
> 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
