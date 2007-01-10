From: Mike Accetta <maccetta@laurelnetworks.com>
Subject: Re: ICH6-M libata disk timeouts 2.6.18 -> 2.6.19
Date: Tue, 09 Jan 2007 23:56:07 -0500
Message-ID: <17923.1168404967@mdt.dhcp.pit.laurelnetworks.com>
References: <10741.1168384577@mdt.dhcp.pit.laurelnetworks.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from paperclip.laurelnetworks.com ([63.94.127.69]:43735 "EHLO
	paperclip.laurelnetworks.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932542AbXAJE4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2007 23:56:09 -0500
Received: from notepad.laurelnetworks.com (notepad.laurelnetworks.com [63.94.127.20])
	by paperclip.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0A4u89l006893
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 23:56:08 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (mdt.dhcp.pit.laurelnetworks.com [10.0.21.56])
	by notepad.laurelnetworks.com (ECI-DND/ECI-DND) with ESMTP id l0A4u8jp011408
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 23:56:08 -0500
Received: from mdt.dhcp.pit.laurelnetworks.com (localhost.localdomain [127.0.0.1])
	by mdt.dhcp.pit.laurelnetworks.com (8.13.8/8.13.4) with ESMTP id l0A4u7LX017924
	for <linux-ide@vger.kernel.org>; Tue, 9 Jan 2007 23:56:08 -0500
In-reply-to: Your message of "Tue, 09 Jan 2007 18:16:17 EST."
             <10741.1168384577@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Here's a bit more information on these timeouts.  I noticed a mention
of changing the command queue depth in a recent lkml post and decided
to give that a whirl.

This problem seems to be related to the depth of the queue.  When I
set the value for /sys/block/sdb/device/queue_depth to 4 the raid1
re-sync completes without incident.  When set to 5 it eventually gives
the timeout error message (although at well past 50% of the re-sync).
The problem was originally observed with the default setting (31).
-- 
Mike Accetta

ECI Telecom Ltd.
Data Networking Division (previously Laurel Networks)

