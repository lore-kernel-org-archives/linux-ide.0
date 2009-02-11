From: Chuck Ebbert <cebbert@redhat.com>
Subject: ahci fails with SATA DVD drive, IDE mode works
Date: Wed, 11 Feb 2009 17:45:58 -0500
Message-ID: <20090211174558.505354fe@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41311 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487AbZBKWs2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 17:48:28 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1BMmRja028981
	for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 17:48:27 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1BMmRb5021553
	for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 17:48:27 -0500
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com [10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1BMmRlJ022965
	for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 17:48:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Using kernel 2.6.29-rc3...

lspci says this device in IDE mode is ID 8086:292d Intel (ICH9M/M-E)
In that mode it works with the ata_piix driver.

But with ahci mode I get:
ata2: Sata link up 1.5Gbps (SStatus 113 SControl 300)
ata2.00 ATAPI: TSSTcorp CDDVDW TS-L633A, UO00, max MWDMA2, ATAPI AN
ata2.00 applying bridge limits
ata2.00 configured for PIO4
ata2.00 qc timeout (cmd 0xa0)
ata2.00 failed to clear UNIT ATTENTION (err_mask=0x5)
ata2: Sata link up 1.5Gbps (SStatus 113 SControl 300)
ata2.00 configured for PIO4
ata2.00 qc timeout (cmd 0xa0)
ata2.00 failed to clear UNIT ATTENTION (err_mask=0x5)
ata2: limiting SATA link speed to 1.5Gbps
ata2.00 limiting speed to PIO3
ata2: link is slow to respond, please be patient (ready=0)
ata2: COMRESET failed (errno=-16)
ata2: link is slow to respond, please be patient (ready=0)
ata2: COMRESET failed (errno=-16)
ata2: link is slow to respond, please be patient (ready=0)
ata2: COMRESET failed (errno=-16)
ata2: COMRESET failed (errno=-16)
ata2: reset failed, giving up
ata2.00: disabled
ata2: hard resetting link
ata2: link is slow to respond, please be patient (ready=0)
ata2: COMRESET failed (errno=-16)

etc.

