From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Sat, 29 Sep 2007 15:14:55 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911D2A@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:44445
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXI2TNq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 15:13:46 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>, Tejun Heo <htejun@gmail.com>
Cc: Bruce Allen <bruce.allen@aei.mpg.de>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Thanks Bruce and Tejun,

I have replaced the hot swap drive tray of the drive in question,
rebooted and reinstalled the latest version of smartmontools.  So far I
have read and wrote about 50GB of data to the raid array over the last
18 hours with smartd running and have not seen any kernel error
messages.  Looks like the interconnect was at fault.

Thanks again for the help,
Jon

-----Original Message-----
From: Bruce Allen [mailto:ballen@gravity.phys.uwm.edu] 
Sent: Friday, September 28, 2007 9:48 PM
To: Tejun Heo
Cc: Jon Chelton; Bruce Allen; Smartmontools Mailing List;
linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

> All errors are interface CRC errors reported by device on FPDMA_WRITE.

> It doesn't seem to have anything to do with SMART.  In all cases,
SError 
> DIAG is reporting handshake error too (R_ERR received).  I'm fairly
sure 
> these were actual hardware problems.  You don't have to pay too much 
> attention unless it happens repeatedly.  Good cure for the problem is 
> probably to re-seat the harddrive.

Jon: as Tejun says, the ICRC errors indicate a problem with the data 
cabling or connections between the drive and the controller.  Replug, 
clean, examine (and perhaps replace) SATA cables and/or connectors. The 
SMART error log (smartctl -L) might also show entries for the ICRC
errors 
(with timestamps that might be useful).

> Bruce, I don't think this is SMART related.  Sorry about the noise. 
> Thanks.

Tejun: thank you again, no worries, and definitely no apologies needed!

Cheers,
 	Bruce

