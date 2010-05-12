From: Nick Bowler <nbowler@elliptictech.com>
Subject: T500 cdrom drive never stops spinning until mount.
Date: Tue, 11 May 2010 22:35:49 -0400
Message-ID: <20100512023549.GA22623@cpu18.student.cs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from services04.student.cs.uwaterloo.ca ([129.97.152.11]:39166 "EHLO
	services04.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730Ab0ELDLH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 May 2010 23:11:07 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

The ThinkPad T500 has a SATA cdrom drive attached to an Intel ICH9M/M-E
SATA ACHI controller.  Upon inserting a disk into this drive, if sr-mod
is loaded, the disk will never stop spinning by itself:  it will spin up
to full speed, then start slowing down, but just before it stops, it
will spin up to full speed, then start slowing down, ad infinitum.

If sr-mod is not loaded, the disk stops spinning right after insertion.
It is only possible to remove sr-mod when the disk is spinning at full
speed (all other times the module is in use), and then the disk stops.

Mounting the disk also causes it to stop spinning (and it remains
stopped after unmounting it).

I see this behaviour with both 2.6.32 and 2.6.34-rc7.
