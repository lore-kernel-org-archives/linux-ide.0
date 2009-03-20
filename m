From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: AHCI link power management and surprise hotplug
Date: Fri, 20 Mar 2009 10:42:57 -0700
Message-ID: <20090320104257.5cf1e7cc@appleyard>
References: <49C22689.9050005@buttersideup.com>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50177 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146AbZCTRma (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Mar 2009 13:42:30 -0400
In-Reply-To: <49C22689.9050005@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 19 Mar 2009 04:03:37 -0700
Tim Small <tim@buttersideup.com> wrote:

> Hello,
> 
> I've been configuring SATA link power management
> (Documentation/scsi/link_power_management_policy.txt) on servers which
> use software RAID for a while, but I happened to come across this in the
> ICH9 datasheet:
> 
> "
> For reliable device removal notification while in AHCI operation without
> the use of interlock switches (surprise removal), interface power
> management should be disabled for the associated port. See Section 7.3.1
> of the AHCI Specification for more information.
> "
> 
> 
> Is this actually an issue from a libata point of view?  Do I need to
> ensure that link power management is disabled prior to hot-removal, and
> if so, I suppose link_power_management_policy.txt should be updated to
> reflect this...

Hi,
Yes - this is an issue.  Right now we disable hotplug when link power
management is enabled because when your link is in a lower power state
it cannot detect the phy state changes.  Most platforms I've seen do
not support the interlock switches - so ATM link pwr management and 
hotplug are mutually excludive.  I agree that the documentation
should reflect this - would you like to submit a patch to the
link_power_management_policy.txt file?

Thanks!
Kristen
