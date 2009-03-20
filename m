From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI link power management and surprise hotplug
Date: Fri, 20 Mar 2009 10:56:26 +0900
Message-ID: <49C2F7CA.6090908@kernel.org>
References: <49C22689.9050005@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55965 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbZCTBz5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 21:55:57 -0400
In-Reply-To: <49C22689.9050005@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

Hello,

Tim Small wrote:
> "
> For reliable device removal notification while in AHCI operation without
> the use of interlock switches (surprise removal), interface power
> management should be disabled for the associated port. See Section 7.3.1
> of the AHCI Specification for more information.
> "
> 
> Is this actually an issue from a libata point of view?  Do I need to
> ensure that link power management is disabled prior to hot-removal, and
> if so, I suppose link_power_management_policy.txt should be updated to
> reflect this...

Yeap, libata wouldn't know the device is yanked out.  It will find out
later when it tries to issue a command later tho.  It could be a
problem if you hot-swap the drive.  libata wouldn't know that devices
have been exchanged.

> On a related topic, is there any way to do anything other than
> "surprise" removal with libata?  It'd be nice to put a drive to sleep
> (e.g. with "hdparm -Y"), and ensure that nothing comes along and causes
> the drive to be reset and spin the drive attached to that SATA port back
> up prior to a removal and reinsertion.

echo 1 > /sys/block/sdX/device/delete

> I'm assuming that physically unplugging a non-spinning drive is
> preferable to unplugging a spinning one from a drive longevity point of
> view (I use SATA drives as removable backup medium in some cases).

Yeah, you'll induce an emergency unload if you remove power while the
drive is spinning, but drives are designed to deal with certain number
of those events and if it doesn't happen regularly, you don't need to
worry about it.

Thanks.

-- 
tejun
