From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Tue, 14 Oct 2008 14:51:54 +0900
Message-ID: <48F4337A.50307@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43635 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbYJNFxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 01:53:53 -0400
In-Reply-To: <20081011142735.GB5904@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

Lars Michael Jogback wrote:
> I've got trouble to get a drive to reconnect to the system after
> hotplug.
> 
> I'm using Linux 2.6.26 (Debian 2.6.26-8) on AMD64. The controller card
> is any Sil3124-based, and the disks are connected to a Sil3726.
> 
> The disks in this case (but I've got the same behaviour on different
> disks) is SAMSUNG HD103UJ. Their Spin_Up_Time according to smartctl is
> 11030 (which I translate to approx 11 seconds, right?)
>
...
> [75101.684114] ata4.03: failed to IDENTIFY (I/O error, err_mask=0x11)
...
> 
> As I understand it, the first IDENTIFY happens 1 second after hotplug,
> the second 5 seconds after hotplug, and the last and third one happens 9
> seconds after the hotplug, and as I understand this disk need at least
> 11 seconds to spin-up.
> 
> The only way I can get the disk back online is to yank the cable between
> the controller and the PMP, then it works.
> 
> Is it someway to extend the timeout to wait for spin-up of the disk?

Hmmm.. drives usually make reset wait while they're spinning up so
that's where the spin wait logic is implemented.  Strange.  Can you
post full boot log and the result of "hdparm -I" on the drive?  Also,
if you first spin up the drive by conneciting only the power connector
and then connect the SATA cable a bit later, does it work?

Thanks.

-- 
tejun
