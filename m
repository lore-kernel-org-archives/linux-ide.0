From: "Winstel, Drew" <DWinstel@Miltope.com>
Subject: libata-scsi.c: ata_scsi_simulate question
Date: Wed, 23 Feb 2005 16:35:11 -0600
Message-ID: <66F9227F7417874C8DB3CEB057727417044FA2@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from firewall.miltope.com ([208.12.184.221]:23441 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261652AbVBWWfN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 17:35:13 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Linux-Ide (E-mail)" <linux-ide@vger.kernel.org>

I noticed that in libata-scsi.c, the ata_scsi_simulate() 
function calls for the SCSI commands SEEK_6 and SEEK_10 
are being simulated instead of being translated to the 
ATA SEEK command (0x70).  Why is this being done?

I know that the SEEK command was declared obsolete with draft 1c 
of ATA/ATAPI-7 after the April 2002 T13 meeting, but why
deny older (which AFAIK constitutes the majority of drives 
on the market) drives the ability to seek?  

The reason I ask is because this makes benchmarking a little
difficult. :)


Drew Winstel
Engineering Co-op
VT Miltope
(334) 613-6422
