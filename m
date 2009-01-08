From: "Eamonn Hamilton" <EAMONN.HAMILTON@saic.com>
Subject: Re: problems with sata_nv and MV88SX5081 under 2.6.28, fineunder2.6.17.6
Date: Thu, 08 Jan 2009 10:51:50 +0000
Message-ID: <1231411910.20422.142.camel@ukabzc383.uk.saic.com>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com> <49656F6A.3020103@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mclmx2.mail.saic.com ([149.8.64.32]:49198 "EHLO
	mclmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZAHKwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 05:52:07 -0500
In-Reply-To: <49656F6A.3020103@shaw.ca>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

Sure

Jan  5 18:37:47 talis kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Jan  5 18:37:47 talis kernel: ata4.00: cmd 35/00:08:08:90:93/00:00:2e:00:00/e0 tag 0 dma 4096 out
Jan  5 18:37:47 talis kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  5 18:37:47 talis kernel: ata4.00: status: { DRDY }
Jan  5 18:37:47 talis kernel: ata4: hard resetting link
Jan  5 18:37:47 talis kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  5 18:37:47 talis kernel: ata4.00: configured for UDMA/133
Jan  5 18:37:47 talis kernel: ata4: EH complete
Jan  5 18:37:47 talis kernel: sd 3:0:0:0: [sdd] 781422768 512-byte hardware sectors: (400 GB/372 GiB)
Jan  5 18:37:47 talis kernel: sd 3:0:0:0: [sdd] Write Protect is off
Jan  5 18:37:47 talis kernel: sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
Jan  5 18:37:48 talis kernel: sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jan  5 18:37:48 talis kernel: svc: 127.0.0.1, port=56936: unknown version (3 for prog 100003, nfsd)
Jan  5 18:39:29 talis kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Jan  5 18:39:29 talis kernel: ata4.00: cmd 35/00:08:08:90:93/00:00:2e:00:00/e0 tag 0 dma 4096 out
Jan  5 18:39:29 talis kernel:          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  5 18:39:29 talis kernel: ata4.00: status: { DRDY }
Jan  5 18:39:29 talis kernel: ata4: hard resetting link
Jan  5 18:39:30 talis kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  5 18:39:30 talis kernel: ata4.00: configured for UDMA/133
Jan  5 18:39:30 talis kernel: ata4: EH complete

This is immediately after booting.

Regards,
Eamonn



On Wed, 2009-01-07 at 21:13 -0600, Robert Hancock wrote:
> Eamonn Hamilton wrote:
> > Hi,
> > 
> > I look after a server with a bunch of drives hooked up to two 8 port
> > PCI-X sata cards, detected as above.
> > 
> > The server was running 2.6.17.6 which has sata_mv version 0.7, which
> > worked fine. I recently upgraded the kernel to 2.6.18 with version 1.24,
> > and started getting
> > 
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> 
> Can you post the full output (that part of the message is not very useful..)

SAIC Limited is a private limited company registered in England and Wales. Registered number 1396396. Registered office at 120 New Cavendish Street, London, W1W 6XX. VAT number 599 5474 64.
This e-mail and any attachments are private and confidential.  If you are not the intended recipient of this e-mail, any disclosure, copying, distribution or use of its contents is strictly prohibited. Please notify the sender immediately and then delete it (including any attachments) from your system.
All emails and attachments are virus scanned. It is your responsibility to ensure that any onward transmission, opening or use of this message and any attachments will not adversely affect your or the onward recipients' systems or data. Please carry out such virus and other such checks as you consider appropriate.
SAIC Limited may monitor email traffic data and, also, the content of email for the purposes of security, staff training and compliance with SAIC policies.

