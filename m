From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA failures ("link offline, clearing class 1 to
 NONE")
Date: Tue, 01 Dec 2009 17:12:51 +0900
Message-ID: <4B14D003.30407@kernel.org>
References: <1258054583-sup-4108@utwig> <4B14B207.9010208@kernel.org> <1259652273-sup-686@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57942 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbZLAIOH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 03:14:07 -0500
In-Reply-To: <1259652273-sup-686@utwig>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Vandiver <alex@chmrr.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

Hello,

On 12/01/2009 04:37 PM, Alex Vandiver wrote:
> My original post included both 'goodboot' and 'badboot' files, which
> were the dmesg output from a successful boot, and a failed boot with
> the event -- is that not what you are looking for?  Apologies if I'm
> misunderstanding.

Ooh... sorry, I missed them.  A problem with large screen is that
those attachments show up so far down in the screen that they become
pretty easy to miss.  :-)

> I tried 2.6.32-rc6 at the time as well -- it happened to have the
> fault much more often, and showed that both ata2.00 and ata2.01 could
> be affected.  I've attached dmesg output from a successful boot, as
> well as dmesg output from a boot which affected sdc, and a boot which
> affected sdd.

Hmmm... Okay, the problem is that, ata_piix has SCR regs but doesn't
have PHY event notification.  libata reset protocol does the following
during reset.

1. plug interrupts.
2. reset and determine device presence.
3. clear PHY events.
4. unplug interrupts.
5. check link status and retry if link status doesn't match device
   presence so that no hotplug event is lost.

The assumption is that a controller which reports link status will
notify EH if something happens after #4.  ata_piix doesn't have such
thing and #5 sees that the link is offline (this sometimes happens
after hardreset, links bounces between on and offline states) and
marks that the device is not present.  As the link was temporarily
down, when it gets back up, it would notify another link event and
libata will retry probing but that never happens with ata_piix so it
misses the devices.

Removing PIIX_FLAG_SIDPR from ich8_sata and ich8_2port_sata entries in
ata_piix.c::piix_port_info fixes the problem, right?

Thanks.

-- 
tejun
