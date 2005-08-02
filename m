From: Ian Oliver <lists@foxhill.co.uk>
Subject: Lockup when using three or more TX2plus/PDC20375 cards
Date: Tue, 02 Aug 2005 16:35:13 +0100
Message-ID: <VA.00001960.01b93e16@foxhill.co.uk>
Reply-To: linux-ide@vger.kernel.org
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.tidymail.co.uk ([217.146.107.7]:8845 "EHLO
	relay2.tidymail.co.uk") by vger.kernel.org with ESMTP
	id S261568AbVHBPfQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 11:35:16 -0400
Received: from [217.146.124.254] (helo=foxhill.co.uk)
	 by relay2.tidymail.co.uk  with esmtpa
	  (Exim 4.52)
	 id 1DzynR-0001Uf-6l
	for linux-ide@vger.kernel.org; Tue, 02 Aug 2005 15:35:13 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am using Ubuntu Hoary with the standard 2.6.10 kernel.
I have 4x Maxtor SATA cards using the PDC20375 (rebranded Promise 
TX2plus) in PCI slots. Each drive is cabled to 2 SATA HDs and these are 
used as two groups of four for software raid using mdadm. Boot drive is 
a non-raid PATA drive.

When I really hammer the sw raid that's on two of the cards it will 
generate lots of these in the log -
Jul 25 17:33:42 localhost kernel: ata7: status=0x51 { DriveReady 
SeekComplete Error }
Jul 25 17:33:42 localhost kernel: ata7: error=0x0c { DriveStatusError }

then I get the following on the console -
ata7: command timeout
and then the whole machine locks solid.

I can do whatever I like to the raid on the 1st four cards and it seems 
rock solid.

I hear talk of 3rd and subsequent cards not being initialised by the 
BIOS, and my "lspci -v" results back this up. (Please see 
http://bugzilla.ubuntu.com/show_bug.cgi?id=13046 rather than cluttering 
this list.)

How can I address this problem? I have just built a 2.6.10 kernel and 
modules (very much a first for me) so I think I can apply patches and 
try things out.

Note that I think Ubuntu has some patches from later kernels applied to 
their libata to add pass through, but I don't know the status of the 
sata_promise.

Regards

Ian



