From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 18:18:51 +0100
Message-ID: <18720.22011.404066.905870@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
	<18720.18615.938839.921189@harpo.it.uu.se>
	<49204DB2.2040400@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:57598 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYKPRS4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 12:18:56 -0500
In-Reply-To: <49204DB2.2040400@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Alexander Clausen writes:
 > Mikael Pettersson wrote:
 > > 
 > > There is currently no suspend support in the sata_promise driver, so
 > > whatever happens at suspend and resume is up to libata and ACPI.
 > > 
 > > Do you have anything connected to that mobo's VIA SATA ports? If not,
 > > you could move the disk(s) from the Promise controller to the VIA
 > > controller just to see how the machine behaves over repeated suspend/resume
 > > cycles. (I'm not suggesting you move the disks permanently, this would
 > > just be a data gathering experiment.)
 > 
 > Yeah, I tried moving the disk, but for whatever reasons, the controller BIOS did not detect it, so
 > it did not boot.

Enter the "Integrated Peripherals" BIOS setup page and make sure the
VT8237 SATA controller is enabled. Also check if there's an option
anywhere for choosing between raid and non-raid modes, and choose
non-raid.

(I have the exact same mobo, but mine is running 24/7 as a file server
at another location, so I can't experiment with it right now.)

 > Can the linux driver detect drives that the BIOS can't? If so, I can retry with
 > another boot medium.

Linux should detect the drives even if the firmware didn't.
