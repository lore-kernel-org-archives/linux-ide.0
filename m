From: Willy Tarreau <w@1wt.eu>
Subject: Re: SATA update in 2.4, ICH8
Date: Tue, 26 Jun 2007 16:02:13 +0200
Message-ID: <20070626140212.GA24269@1wt.eu>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu> <87myysfqo4.fsf@naruto.ifr.lan> <20070622191344.GB3629@1wt.eu> <87sl8ge9uw.fsf@naruto.ifr.lan> <20070626120904.GD23524@1wt.eu> <46811686.6050408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3175 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbXFZOCS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 10:02:18 -0400
Content-Disposition: inline
In-Reply-To: <46811686.6050408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Vincent Bernat <Vincent.Bernat@wallix.com>, linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>

On Tue, Jun 26, 2007 at 09:37:10AM -0400, Jeff Garzik wrote:
> Any chance you could email me what is pending?

Of course! it was in first mail of this thread. Here it is.

Thanks,
Willy


------

Hi !                                                                            

I have patched 2.4.34 with the  following patch to allow the use of SATA        
drive on an ICH8 motherboard (it is a Dell OptiPlex 745).


--- linux/drivers/scsi/ata_piix.c~	2006-12-22 17:06:45.000000000 -0500
+++ linux/drivers/scsi/ata_piix.c	2007-06-14 05:27:02.000000000 -0400
@@ -115,6 +115,8 @@
 	{ 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, esb2_sata },
 
 	{ }	/* terminate list */


