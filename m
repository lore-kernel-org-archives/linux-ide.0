From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Known problems with Maxtor 120GB SATA?
Date: Fri, 05 Mar 2004 15:49:37 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40489381.6010601@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:55225 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262613AbUCEOth
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Mar 2004 09:49:37 -0500
Received: from stesmi.com (deltaflyer.stesmi.com [192.168.1.14])
	by K-7.stesmi.com (8.12.8/8.12.5) with ESMTP id i25EnaPh001328
	for <linux-ide@vger.kernel.org>; Fri, 5 Mar 2004 15:49:36 +0100
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi people.

Are there any knows problems with Maxtor's line of SATA drives,
maybe specifical to the 120GB units?

I've had 3 (out of 3) die on me in the course of 2 weeks and
it's feeling spooky.

They've been connected to different motherboards but the
motherboards have had the same SATA chipset, namely the VIA
8237.

Motherboards :
Soyo SY-KT600 (VIA 8237 + SiI 3112A)
Asus K8V Deluxe (VIA 8237 + Promise 20368)
MSI K8M (VIA 8237 + Promise 20368).

The machines have run both linux (RH FC1 latest updates with libata
replaced by latest) and Windows (the included VIA SATA driver)
and what has happened was that all of a sudden the machines won't
boot into windows but just reboots after showing the moving
dots on the screen. Using powermax on the drives have shown
error XXXS57 on all of them. Most data have been rescuable
but not all and in two cases a full lowlevel format (in powermax)
has cured the problem, at least temporarly. The third one
is currently being formatted.

Powermax refuses to redognize the drives if they are connected
to the VIA 8237 controller so all tests using powermax have
been using the alternate controller on the same board (meaning
SiI 3112A or Promise 20368).

Is there any errata or steps one should take or anything one can do?

Three drives in this sort time feels spooky. The third drive was
bought just one week ago.

Any more info needed, let me know.

When a drive has failed, running 'badblocks -sv' on the drive
makes it either a) fail (if on VIA 8237) b) lock up the system
but the system can be rebooted (if on Promise 20386) or
c) lock up the system so that it can't even be rebooted,
linux is dead (a few times on Promise 20386).

Tests have been done in both 32bit mode and 64bit mode.

Same revision kernel with same patches.

// Stefan
