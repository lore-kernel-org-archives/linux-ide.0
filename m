From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: print device model and firmware revision
 for ATAPI devices
Date: Sat, 09 Jun 2007 22:42:19 -0400
Message-ID: <466B650B.6080607@garzik.org>
References: <4664EE2D.5040607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35841 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974AbXFJCmY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:42:24 -0400
In-Reply-To: <4664EE2D.5040607@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Albert Lee wrote:
>   For ATA/CFA devices, libata prints out the device model and firmware revision.
> Do the same for ATAPI devices.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Sometimes the error happens after identify but before the
> SCSI messages. Knowing the device model and firmware revision
> could also help.
> 
> Dmesg looks like below after the patch.
> ata1.00: ATA-6: WDC WD2000JB-00KFA0, 08.05J08, max UDMA/100
> ata1.00: 390721968 sectors, multi 16: LBA48 
> ata5.00: ATAPI: LITE-ON CD-RW SOHR-5238S, 4S07, max UDMA/33
> For your review, thanks.

good idea... applied to #upstream-fixes



