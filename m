From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Thinkpad 760ED configuration problems
Date: Fri, 23 Jul 2004 15:56:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4100E0BA.1050562B@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out001pub.verizon.net ([206.46.170.140]:43142 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S267775AbUGWO4P
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jul 2004 10:56:15 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-laptop@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, linux-ide@vger.kernel.org

I have a Thinkpad 760 ED. (Model 9546-U3A, BIOS HZET72WW 08/07/99)

There is fairly strong evidence that the BIOS on this machine is not
setting up the PCI configuration registers to the standard Linux 
expects.  For example, a temporary patch suggested by Bartlomiej 
Zolnierkiewicz on the linux-ide list ended up crashing the 2.6.7 
kernel during init and there are messages about unassigned IRQs and
DMA addresses in the log.

I suspect that the correct way to fix this problem is to have a
routine redo the PCI configuration fairly early in the kernel setup 
sequence, but I'm not sure exactly where/when to put it.  It should be 
done after the CPU and memory are setup, but before PCI setup ends.  
I suspect that it should be done at the beginning of the PCI setup 
process.  There is a whole bunch of stuff in 'quirks' that seems to be
similar but I've only skimmed that code so far.  Does this belong there?
If so, which list has people who fiddle with PCI on it?

I'm also not sure how to detect when this correction is needed. I
suspect that the revision number of some BIOS component would be
key to determining if this should be done, but I have no idea
how to get that information.  It is probably covered by some
standard specification, but I've been looking for a couple weeks
and I don't think I've found the correct specification yet. (I
did find a new load of specifications yesterday and haven't finished
reading them, thus the 'think'.)  Suggestions on where this might
be documented would be appreciated.

Finally, the actual configuration information is stored someplace.
I suspect that it is in the cmos memory.  The kernel-module-thinkpad
project has a module in it that provides access to this information,
but I suspect a NIH problem and that there are other standard ways to
get at the information.  Aside from that, there is the question of
which cmos bytes control which part of the configuration process.
Again, I suspect that I can dig this out of other peoples projects,
particularly the tpctl project, but a more original source might be
more appropriate.  Again, advice on where to look would be appreciated.

If nothing else, I can RE the BIOS, but I'd really like to avoid that.

max@mtew.isa-geek.net
