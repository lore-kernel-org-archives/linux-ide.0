From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Drive breakdown or bug?
Date: Sun, 16 Nov 2008 18:33:58 +0000
Message-ID: <20081116183358.4d7f61eb@lxorguk.ukuu.org.uk>
References: <200811161325.57557.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51347 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752083AbYKPSds (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 13:33:48 -0500
In-Reply-To: <200811161325.57557.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: linux-ide@vger.kernel.org

> Nov 16 12:55:11 coyote kernel: [57888.336419]          res 51/40:08:18:c6:ba/40:00:2a:00:00/e0 Emask 0x9 (media error)
> Nov 16 12:55:11 coyote kernel: [57888.336473] ata1.00: status: { DRDY ERR }
> Nov 16 12:55:11 coyote kernel: [57888.336498] ata1.00: error: { UNC }

Unrecoverable read error on the disk is what is being reported

> So I am running badblocks, and have collected a lengthy list. But the drive 
> is not re-allocating them, and has not re-allocated any bad blocks according
> to smartctl.

It cannot reallocate a block which it cannot read as the data on it would
be lost silently at that point. It should reallocate such blocks on a
write to them (which is why fsck.ext3 knows how to rewrite bad inode
blocks when recovering stuff)

> but the last 5 all occurred while amdump was running earlier today, and
> the last 5 is all the drive apparently keeps.

Yes

> The question then is:
> 
> Bad drive, (un-)known bug, or configuration?

Probably bad drive but could also be bad drive as a symptom of something
else (eg heat)

Alan
