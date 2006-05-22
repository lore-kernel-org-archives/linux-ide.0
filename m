From: Jeff Garzik <jeff@garzik.org>
Subject: Random libata comments...
Date: Mon, 22 May 2006 19:26:49 -0400
Message-ID: <447248B9.6040304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51106 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751128AbWEVX0v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 19:26:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>


* I agree with others that using the "ata_drive_probe_reset" can lead to 
confusion on the uses of the word "drive".  Replacing that with "do" or 
something else would be nice.

* As the ata_drive_probe_reset argument list continues to grow, I lean 
more and more towards moving all those function pointers to struct 
ata_port_operations.  One of the problems with the drivers/ide layer IMO 
is that the list of all hooks used is not immediately clear upon first 
read, whereas with libata it is clear -- with the notable exception of 
ata_drive_probe_reset().


