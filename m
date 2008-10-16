From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Thu, 16 Oct 2008 02:08:53 -0700 (PDT)
Message-ID: <20081016090853.E8567108057@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39684 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258AbYJPJIz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 05:08:55 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9G98ro7022220
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 02:08:55 -0700
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732





------- Comment #7 from axboe@kernel.dk  2008-10-16 02:08 -------
Initially it looks like IDE calling dma mapping for a request with no data
attached. blk_rq_map_sg() returns 0 if no data is attached, it has no error
case. So saying that IDE just passes that on to dma mapping doesn't say a whole
lot. To be sure, it would be interesting to catch a blktrace of this happening
so we can see more closely. So, IOW, do:

1) In one termimal, run blktrace /dev/hdX (eg /dev/hda, or whatever is your
cdrom).
2) In another terminal, mount the drive or whatever reproduces the error.
3) In that first terminal, ctrl-c blktrace. Then run blkparse hdX -o output and
attach output to this bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
