From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] drivers/ide/ide-probe.c Skip ide_wait_not_busy on noprobe-disks. was: [PATCH][RESUBMIT] drivers/ide/ide-probe.c, kernel 2.6.23.1
Date: Sun, 18 Nov 2007 22:39:33 +0100
Message-ID: <200711182239.33274.bzolnier@gmail.com>
References: <473434F1.50509@purplescout.se> <200711162222.54847.bzolnier@gmail.com> <473E2049.4070806@purplescout.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:55080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXKRVkF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 16:40:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so869066ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 13:40:03 -0800 (PST)
In-Reply-To: <473E2049.4070806@purplescout.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonas Stare <jonas.stare@purplescout.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Friday 16 November 2007, Jonas Stare wrote:
> There is a problem in some hardware where the kernel will stall for
> 35 seconds waiting for disks that dont exist. This patch will skip
> waiting for the BSY-bit on ide-drives to go away if you set
> hdx=noprobe as a kernel option and the disk is not marked
> as 'present' (like when you set the geometry by hand).
> 
> If no noprobe-option is set the code will work (more or less) as the 
> original but if set the code will skip the ide_wait_not_busy() for that 
> drive. Even if there would be a drive there and it is still BSY 
> afterwards it should not matter since it isn't probed for later.
> 
> (The code also honors the MAX_DRIVES variable instead of assuming that 
> there will be two harddrives on the bus.)
> 
> 
> Signed-off-by: Jonas Stare <jonas.stare@purplescout.se>

Thanks!

PS There were still some whitespace problems (all tabs were replaced by
spaces) so I just applied it by hand (and made few minor cleanups while
at it).

Bart
