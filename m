From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Date: Tue, 6 Sep 2005 16:33:22 -0700
Message-ID: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from serv01.siteground.net ([70.85.91.68]:25066 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751033AbVIFXdZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Sep 2005 19:33:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>

The following patchset breaks down the global ide_lock to per-hwgroup lock.
We have taken the following approach.

1. Move the hwif tuning code from probe_hwif to ideprobe_init, after
hwif_init so that hwgroups are present for all the hwifs when the tune
routines for the hwifs are invoked (patch 1)

2. Change the core ide code to use hwgroup->lock instead of ide_lock.
Deprecate ide_lock (patch 2)

3. Change the host controllers to use hwgroup->lock (patch 3)

4. Change host controller drivers to use per driver lock instead of ide_lock
where needed or hwgroup->lock on case by case basis. This can be done 
incrementally for various controllers and we will have working code between 
patches -- this is done now for piix controller only.  Eventually, 
we can change all controllers to remove ide_lock

Thanks to Bartlomiej for comments and suggestions.

Patchset follows.  Patchset tested on a smp box with a piix controller.

Thanks,
Kiran
