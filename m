From: Jeff Garzik <jeff@garzik.org>
Subject: Gigabyte i-Ram cards
Date: Mon, 20 Mar 2006 21:24:38 -0500
Message-ID: <441F63E6.2090204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12263 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030270AbWCUCYn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 21:24:43 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1FLWY3-0006D5-Jj
	for linux-ide@vger.kernel.org; Tue, 21 Mar 2006 02:24:43 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


While responding to email related to Bugzilla# 6163 [1], I took a look 
at the Gigabyte i-Ram[2]:  PCI card, where PCI only provides power to 
some DIMMs.  Data xfer to/from DIMMs via SATA cable.  So, at current 
prices[3] one can get a 1GB Solid State Disk for US$206:  US$153 for the 
card, and US$53 for 1GB pc2700 ddr.

I'm impressed.  I ordered one to help debug BZ#6163, but I think these 
cards will help expose bugs in libata due to their high speed.  With 
these cards, we can push more data through libata than would normally be 
possible with a standard disk drive.

I've seen these for PATA before, but this is the first inexpensive SATA 
SSD that I've seen.  Let's hope its not riddled with hardware bugs 
<crosses fingers>.

	Jeff


P.S. Full disclosure:  I've had no contact with Gigabyte at all, nor has 
Red Hat (my employer) to the best of my knowledge.  I just like the gadget.


[1] http://bugzilla.kernel.org/show_bug.cgi?id=6163
[2] http://www.gigabyte.com.tw/Products/Storage/Default.aspx
[3] http://www.cdw.com/shop/products/default.aspx?EDC=929424

