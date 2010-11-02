From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Hyper-V and IDE disks > 128GB
Date: Tue, 2 Nov 2010 19:27:38 +0000
Message-ID: <20101102192738.1bb0ccf4@lxorguk.ukuu.org.uk>
References: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39443 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751626Ab0KBT2T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 15:28:19 -0400
In-Reply-To: <12CD8E2D-64F0-46D6-8ACB-C411D7BECEE7@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Shaw <dshaw@jabberwocky.com>
Cc: linux-ide@vger.kernel.org

> with the same results) under the Hyper-V virtualization platform.  Specifically, the virtual IDE disks
> probe as "ATA-0", which seems to turn off 48-bit LBA, thus capping the
> disk size at 128GB.

Early ATA does not support LBA48 so that behaviour is correct from Linux

> 
> This seems to have worked properly (at least in the sense that the full size of the disk was visible) on kernel 2.6.27.41.  See http://www.serverphorums.com/read.php?12,79638
> 
> In any event, this is how the virtual disk shows up at boot:
> 
> Oct 15 11:06:06 localhost kernel: ata1.01: ATA-0: Virtual HD, 1.1.0, max MWDMA2
> Oct 15 11:06:06 localhost kernel: ata1.01: 267382800 sectors, multi 128: LBA

> Can someone suggest a direction to go in next?

Well it looks like a bug in the hypedvisor so I guess the first steps are
to check with Microsoft if there is an update and to open a bug report
with them. If the volume naming is consistent then I guess we can also in
theory add a hack for Linux to recognize the broken volumes (assuming
LBA48 actually works if you ignore the drive identify data)
