From: Chuck Ebbert <cebbert@redhat.com>
Subject: libata timeouts when stressing a Samsung HDD
Date: Mon, 2 Feb 2009 16:40:53 -0500
Message-ID: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42931 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbZBBVnM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 16:43:12 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n12LhBVD002856
	for <linux-ide@vger.kernel.org>; Mon, 2 Feb 2009 16:43:11 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n12LhBPb015531
	for <linux-ide@vger.kernel.org>; Mon, 2 Feb 2009 16:43:12 -0500
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com [10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n12LhB4s003671
	for <linux-ide@vger.kernel.org>; Mon, 2 Feb 2009 16:43:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

If I use an ext3 filesystem with noatime I never see problems, but if I use XFS
with barriers and atime enabled, I keep getting this:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
end_request: I/O error, dev sda, sector 13851948


The errors always happen in the XFS log which then causes filesystem shutdown.

The drive reports itself as:
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: SAMSUNG HD160JJ/P, ZM100-34, max UDMA7
ata1.00: 312500000 sectors, multi 8: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133

Kernel is 2.6.27.12, using the ahci driver on this hardware:
Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller
