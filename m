From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/11] ide-pmac: use __ide_wait_stat()
Date: Mon, 23 Jul 2007 23:22:18 +0200
Message-ID: <200707232322.18042.bzolnier@gmail.com>
References: <200707222033.08794.bzolnier@gmail.com> <1185141793.5439.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:53048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbXGWVZe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40025ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:33 -0700 (PDT)
In-Reply-To: <1185141793.5439.71.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On Monday 23 July 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-07-22 at 20:33 +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Use __ide_wait_stat() instead of wait_for_ready() in pmac_ide_do_setfeature().
> > 
> > While at it do following changes to match __ide_wait_stat() call in
> > ide_config_drive_speed():
> > 
> > * Wait WAIT_CMD time (20 sec) instead of 2 sec for device to clear BUSY_STAT.
> > 
> > * Check DRQ_STAT bit (shouldn't be set for good device status).
> > 
> > Also remove no longer needed wait_for_ready() from ide-iops.c.
> > 
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

added
