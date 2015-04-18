From: Matthew Garrett <mjg59@coreos.com>
Subject: Rework AHCI LPM handling a little
Date: Sat, 18 Apr 2015 08:26:33 -0700
Message-ID: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37097 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbbDRP07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2015 11:26:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kristen@linux.intel.com

This patchset tries to get us closer to having reasonable defaults for link
power management on AHCI. Recent Intel CPUs can't enter deep power saving
states unless the SATA link is in a low power state, appearing to be limited
to PC6 in PARTIAL and PC7 in SLUMBER, and PC2 otherwise. This amounts to
a difference of several Watts in system idle. There appear to be two
components to how this is managed on Windows:

1) Firmware enables a set of power management features on platform init
2) The Intel Rapid Storage Technology AHCI driver enables a set of features

As far as (1) goes, we ignore all firmware config and start from scratch.
As far as (2) goes, we default to not enabling any power management features
because of concerns about reliability and performance.

These patches stash the firmware configuration at kernel init time, add a new
policy that simply reapplies the firmware configuration and changes the
semantics of the medium_power LPM configuration such that it matches the
configuration enabled by the IRST driver on Windows. We can then apply
udev rules that use the firmware_defaults policy in general and the
medium_power policy where we expect that to work, with a view to changing
the in-kernel defaults down the road if this doesn't appear to cause any
problems.

