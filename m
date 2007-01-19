From: Mike Accetta <maccetta@laurelnetworks.com>
Subject: ICH6-M libata disk timeouts in 2.6.19 (except with small queue depth)
Date: Thu, 18 Jan 2007 21:49:37 -0500
Message-ID: <798.1169174977@mdt.dhcp.pit.laurelnetworks.com>
References: <27103.1168657787@mdt.dhcp.pit.laurelnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from staple.laurelnetworks.com ([63.94.127.68]:42862 "EHLO
	staple.laurelnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858AbXASCti (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 21:49:38 -0500
Received: from postit.laurelnetworks.com (postit.laurelnetworks.com [63.94.127.21])
	by staple.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0J2nbR1004534
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 21:49:38 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (mdt.dhcp.pit.laurelnetworks.com [10.0.21.56])
	by postit.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0J2nbda000420
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 21:49:37 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (localhost.localdomain [127.0.0.1])
	by mdt.dhcp.pit.laurelnetworks.com (8.13.8/8.13.4) with ESMTP id l0J2nbd0000799
	for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 21:49:37 -0500
In-reply-to: Your message of "Fri, 12 Jan 2007 22:09:47 EST."
             <27103.1168657787@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


The subject of this thread has been adjusted to reflect my revised
understanding of the problem.  I had previously thought the problem
with a RAID1 re-sync generating timeout errors on the active (reading)
disk appeared with 2.6.19 but it turns out the problem was also present
in 2.6.18.  I was running the 2.6.18 tests with a modular kernel and
hadn't loaded the ahci module in that scenario (so there was no queueing)
but was using a kernel with SATA built in for the 2.6.19 test (which
enabled queueing).  When ahci is loaded with 2.6.18, the same timeout
problem appears.

The distinguishing factor appears to be the queue depth (4 works, 5
and various values up to and including 31 fail) not the kernel version.
I am going to try running with the queue depth clamped at 4 to see if
this consistently masks the problem.  I may also try some more experiments
if I have the time, like instrumenting what command was issued right
before the group that all time out or increasing the SCSI timeout,
in order to get some more insight into what is going on at the time of
the failure.

I'd be happy to run any tests people with expertise in this area can
suggest to help better understand what is going on.  I guess this problem
looks like the disk becomes wedged somehow at this point.  For what its
worth, it is usually possible to regain control of the system if I stop
the RAID re-sync after the first timeout is reported but when I let it
try to run to completion, the SATA sub-system system usually eventually
gets stuck issuing reset after reset with no success and a power-cycle
is the only recourse.
--
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)
