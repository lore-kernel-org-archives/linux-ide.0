From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: 2.6.25 semantic change in bay handling?
Date: Mon, 5 May 2008 23:33:57 +0100
Message-ID: <20080505223357.GA2839@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:33824 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYEEWeL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 18:34:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tejun@gmail.com, Holger Macht <hmacht@suse.de>, Jeff Garzik <jeff@garzik.org>

48feb3c419508487becfb9ea3afcc54c3eac6d80 appears to flag a device as 
detached if an acpi eject request is received. In 2.6.24 and earlier, an 
eject request merely sent an event to userland which could then cleanly 
unmount the device and let the user know when it was safe to remove the 
drive. Removing the device would then send another acpi request that 
triggered the actual hotplug and bus rescan.

This seems like a regression - it's no longer possible to ensure that a 
bay device is cleanly unmounted. Was this really the desired behaviour? 
It should be noted that not all hardware sends the eject request at all 
(Thinkpads do, but Dell and HP laptops don't), so we can't depend on 
receiving this when dealing with a bay event.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
