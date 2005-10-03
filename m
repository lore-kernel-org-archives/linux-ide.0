From: Brian King <brking@us.ibm.com>
Subject: [RFC 0/2] libata: support SATA devices on SAS HBAs
Date: Mon, 03 Oct 2005 16:56:42 -0500
Message-ID: <4341A91A.3020000@us.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:41145 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932629AbVJCV4s
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 17:56:48 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93LtNqM009331
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 17:55:23 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93LuhtP389484
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 15:56:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j93LuhL2027982
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 15:56:43 -0600
Received: from [9.10.86.216] (kaled.rchland.ibm.com [9.10.86.216])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j93LugUo027972
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 15:56:43 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The following patches enhance libata to allow SAS device drivers
to utilize libata to talk to SATA devices. It introduces some
new APIs which allow libata to be used without allocating a
virtual scsi host. This is just a snapshot of what I've
come up with at this point and I figured I would post it to
see if I was heading in a reasonable direction or not, so
don't expect the code below to do anything useful at this point
as it is untested.

New APIs:

ata_sas_port_alloc - Allocate an ata_port 
ata_sas_port_init - Initialize an ata_port (probe bus, etc)
ata_sas_port_destroy - Free an ata_port allocated by ata_sas_port_alloc
ata_sas_slave_configure - configure scsi device
ata_sas_queuecmd - queue a scsi command, similar to ata_scsi_queuecomand

These new APIs can be used either directly by a SAS LLDD or could be used
by the SAS transport class. 

Possible usage for a SAS LLDD would be:

scsi_scan_host
	slave_alloc
		ata_sas_port_alloc
		ata_sas_port_init
	slave_configure
		ata_sas_slave_configure

Commands received by the LLDD for SATA devices would call ata_sas_queuecmd.

Device teardown would occur with:

slave_destroy
	ata_sas_port_destroy


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
