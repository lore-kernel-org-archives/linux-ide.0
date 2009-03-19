From: Tim Small <tim@buttersideup.com>
Subject: AHCI link power management and surprise hotplug
Date: Thu, 19 Mar 2009 11:03:37 +0000
Message-ID: <49C22689.9050005@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([66.111.57.92]:39920 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZCSLdx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2009 07:33:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kristen.c.accardi@intel.com

Hello,

I've been configuring SATA link power management
(Documentation/scsi/link_power_management_policy.txt) on servers which
use software RAID for a while, but I happened to come across this in the
ICH9 datasheet:

"
For reliable device removal notification while in AHCI operation without
the use of interlock switches (surprise removal), interface power
management should be disabled for the associated port. See Section 7.3.1
of the AHCI Specification for more information.
"


Is this actually an issue from a libata point of view?  Do I need to
ensure that link power management is disabled prior to hot-removal, and
if so, I suppose link_power_management_policy.txt should be updated to
reflect this...

On a related topic, is there any way to do anything other than
"surprise" removal with libata?  It'd be nice to put a drive to sleep
(e.g. with "hdparm -Y"), and ensure that nothing comes along and causes
the drive to be reset and spin the drive attached to that SATA port back
up prior to a removal and reinsertion.

I'm assuming that physically unplugging a non-spinning drive is
preferable to unplugging a spinning one from a drive longevity point of
view (I use SATA drives as removable backup medium in some cases).

Cheers,

Tim.
