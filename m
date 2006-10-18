From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv problems on Marvell MV88SX5081
Date: Wed, 18 Oct 2006 08:36:01 -0400
Message-ID: <45361FB1.4060304@rtr.ca>
References: <Pine.LNX.4.64.0610181258330.29022@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:19723 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030249AbWJRMgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Oct 2006 08:36:03 -0400
In-Reply-To: <Pine.LNX.4.64.0610181258330.29022@twin.jikos.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Jiri Kosina wrote:
> Hi,
> 
> I have this piece:
> 
> 01:06.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX5081 
> 8-port SATA I PCI-X Controller (rev 03)
> 
> It's RocketRAID 1820A controller.
> 
> With sata_mv libata driver from 2.6.18, I am getting a load of these:
> 
> Buffer I/O error on device sda1, logical block 122126336

Scroll WAY BACK in the log, and find the error messages which preceeded
the first occurance of that one.  (with a bad sector, it is very likely
you will see a zillion "Buffer I/O errors", as the SCSI mid-layer is not
at all nice about how it handles them).

Cheers
