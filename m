From: Dennis Bijwaard <bijwaard@home.nl>
Subject: 2.6.0test10 hangs just after IDE detection
Date: Wed, 26 Nov 2003 22:54:48 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031126215448.GA1801@bijwaard.dyns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cc76797-a.ensch1.ov.home.nl ([213.51.205.160]:6528 "EHLO
	jumbo.gronausestraat") by vger.kernel.org with ESMTP
	id S264294AbTKZVyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2003 16:54:53 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

Hi,

I've been running 2.6.0test9 and earlier without much problems w.r.t.
IDE. Now with test10 it hangs just after IDE detection. I suspect this 
is because I have IDEDISK configured as a module because my main drives are 
all SCSI. I use CONFIG_PREEMPT.

This is the last that the kernel reports before it stops (does not react
to SysRq interupts):

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
-- 
Kind regards,
            Dennis Bijwaard
