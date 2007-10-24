From: Jeff Garzik <jeff@garzik.org>
Subject: sata_fsl error handling
Date: Wed, 24 Oct 2007 09:50:24 -0400
Message-ID: <471F4DA0.8020702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51595 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbXJXNu1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 09:50:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Ashish Kalra <ashish.kalra@freescale.com>, Li Yang <leoli@freescale.com>

Could you please address some problems in sata_fsl error handling?

sata_fsl_hardreset() should be deleted, it simply duplicates a libata 
function.

sata_fsl_softreset() should be removed greatly.  It is incorrect to send 
LOG EXT command here, as the SATA error handling code (libata-eh) 
already handles that.

	Jeff


