From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] RESEND: SCSI, libata: add support for ATA_16 commands
 to libata ATAPI devices
Date: Thu, 01 Feb 2007 15:30:54 -0500
Message-ID: <45C24DFE.80202@garzik.org>
References: <200701021935.07840.liml@rtr.ca>	 <200701311346.26644.liml@rtr.ca> <45C1356B.6000907@gmail.com>	 <45C1377F.6070001@rtr.ca> <45C138E8.1040706@gmail.com>	 <45C1A4BD.3030909@garzik.org> <45C1A823.30008@gmail.com>	 <45C1B8D4.1070209@garzik.org> <1170342565.3388.4.camel@mulgrave.il.steeleye.com> <45C24BC5.6060305@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42390 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422993AbXBAUa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Feb 2007 15:30:59 -0500
In-Reply-To: <45C24BC5.6060305@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Linux IDE <linux-ide@vger.kernel.org>, linux-scsi@vger.kernel.org

Douglas Gilbert wrote:
> It is the ATAPI _transport_ that has the 12 byte cdb
> limit *** (at least according to MMC-5 rev Annex A;
> is S-ATAPI any better?).

Then the spec is wrong.

1) The transport does not limit the CDB size.

2) The ATAPI device limits the CDB size, and it exports this limit via 
IDENTIFY PACKET DEVICE.  It can be either 12 or 16 bytes.

3) In some rare cases, the host controller silicon may limit CDB size.

	Jeff


