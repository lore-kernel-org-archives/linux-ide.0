From: Christian Vogel <chris@solarsystems.de>
Subject: Re: SATA_SX4: data corruption with simultaneous writes
Date: Tue, 28 Dec 2004 15:09:47 +0100
Message-ID: <20041228140947.GA14182@solarsystems.de>
References: <20041228134745.GA13912@solarsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from solarsystems.de ([217.160.216.16]:20131 "EHLO solarsystems.de")
	by vger.kernel.org with ESMTP id S261768AbUL1OJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2004 09:09:47 -0500
Received: (from chris@solarsystems.de)
	 by solarsystems.de with local (Exim 4.30)
	id 1CjI2l-0003hD-4s
	for linux-ide@vger.kernel.org; Tue, 28 Dec 2004 15:09:47 +0100
Content-Disposition: inline
In-Reply-To: <20041228134745.GA13912@solarsystems.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On Tue, Dec 28, 2004 at 02:47:45PM +0100, Christian Vogel wrote:
> I want to report data corruption that is happening here with a
> promise sx4 SATA controller during simultaneous writes to four connected
> disks, using kernel 2.6.9.
(...)
> The kernel is compiled with Hyperthreading and Preemtion, furthermore
> swapping the sata-controller's RAM did not help.

2.6.10 without preemtion also shows the error. This time I have tried
to write to a raid5 partition (4 partitions a 3.5 GB, one on each disk).

xfs complains:
        xfs_iflush: Bad inode 50331795 magic number 0xb00, ptr 0xf214e300
        Corruption of in-memory data detected.  Shutting down filesystem: md1

but raid (cat /proc/mdstat) does not show any sign of errors... :-(

        Chris

-- 
Christian Vogel -- chris@solarsystems.de
