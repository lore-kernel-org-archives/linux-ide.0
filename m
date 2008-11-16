From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 17:22:15 +0100
Message-ID: <18720.18615.938839.921189@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:57028 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbYKPQWV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 11:22:21 -0500
In-Reply-To: <49202CB0.60507@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: linux-ide@vger.kernel.org

Alexander Clausen writes:
 > Hi,
 > I'm trying to get suspend to ram working on one of the desktop systems here. The mainboard is a
 > MSI K8T Neo FIS2R with a Promise PDC20378 (FastTrak 378/SATA 378) (rev 02).
 > When trying to suspend the first time, everything works just fine, but when trying to suspend a
 > second time, the computer is unresponsive for a long time and does not complete the suspend
 > operation. After that, the file systems are not accessible any more, programs don't start etc...
 > So, then I saw on the wiki that suspend is not supported on sata_promise. Is this still the case, or
 > am I hitting a bug in the suspend code?

There is currently no suspend support in the sata_promise driver, so
whatever happens at suspend and resume is up to libata and ACPI.

Do you have anything connected to that mobo's VIA SATA ports? If not,
you could move the disk(s) from the Promise controller to the VIA
controller just to see how the machine behaves over repeated suspend/resume
cycles. (I'm not suggesting you move the disks permanently, this would
just be a data gathering experiment.)

/Mikael
