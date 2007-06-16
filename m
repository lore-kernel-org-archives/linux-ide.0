From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Combined mode quirk removal kills performance
Date: Sat, 16 Jun 2007 11:36:53 -0400
Message-ID: <46740395.6080702@garzik.org>
References: <465EDF89.9050207@tuxrocks.com>	<20070601165054.114e8b9d.akpm@linux-foundation.org>	<4660B47A.1030604@garzik.org>	<20070601171938.87989b62.akpm@linux-foundation.org>	<4661B2CC.8030409@garzik.org> <20070616075347.96b2405d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36543 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757721AbXFPPg4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Jun 2007 11:36:56 -0400
In-Reply-To: <20070616075347.96b2405d.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Andrew Morton wrote:
> So I revisited [...]
> http://bugzilla.kernel.org/show_bug.cgi?id=8636
> 
> I don't see why it's not-a-bug.  The second guy (Stephen Clark) had to toss
> out the FC6 kernel and build his own kernel to fix this regression.

(I hope you don't mind me copying linux-ide)

The combined mode removal changed the driver load configuration.  Some 
distros updated with that knowledge, but apparently Fedora did not.

Combined mode would explicitly reserve ports for libata in pci/quirks.c, 
a horrible layering violation that created special case module load 
order dependencies.

The change made libata and the old-IDE driver behave like normal Linux 
drivers.  They can both grab an entire PCI device and drive it 
correctly, so -- just like every other situation where two drivers can 
match the same PCI ID -- the one that loads first wins.

Kernel configs need to be tweaked a bit, due to this change.  That's why 
it was communicated in advance (but poorly, as it appears from your 
questions and existing bug reports).  Two common results appear in bug 
reports:

1) One possible result of a complete lack of kconfig tweaking (blindly 
hitting <enter> during 'make oldconfig') is falling back to the 
most-compatible configuration, the legacy IDE driver (either libata or 
old-IDE), with resultant slow performance.

2) "no root! panic!" and similar I-cant-find-your-hard-drive results for 
people with hardcoding root= configurations, for the minority where a 
device moved from /dev/hdX -> /dev/sdX, or vice versa.

The damage is hoped to be limited to:

* Intel ICH5/6[/7?] users with combined mode enabled, which is a 
not-small subset of all ICH[567] users.

* Users that did /not/ choose the combined_mode=libata kernel command 
line option, a popular option for restoring performance /broken/ by 
running two drivers in tandem [i.e. the old way, recently removed].

* In the combined mode configuration, one device is /dev/hdX (often the 
CD-ROM) and one device is /dev/sdX, so only one of those devices will 
move.  Standard LVM and mount-by-label/uuid found in standard distro 
installs makes this move seamless for many.

* ...in distros that hopefully took stock of their compatibility 
picture, and modified their kernel configs and drivers accordingly. 
Some distros were defaulting to combined_mode=libata (==libata drives 
all applicable Intel ICHx IDE devices), others were not.  That affects 
the decision about kernel config changes.

	Jeff





