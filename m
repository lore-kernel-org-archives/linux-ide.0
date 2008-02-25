From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sun, 24 Feb 2008 23:56:04 -0500
Message-ID: <47C24A64.6060907@pobox.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BFAC06.5030805@rtr.ca> <47C116D4.1090600@gmail.com> <47C248C8.9090409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54668 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbYBYE4I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 23:56:08 -0500
In-Reply-To: <47C248C8.9090409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

To repeat myself from threads past...

In particular with the Marvell 6440 (SATA/SAS, drivers/scsi/mvsas.c) 
when SATA PMP support is completed, we will want to look at passing 
things other than normal ATA commands via ->qc_issue.

Although selection isn't necessarily, talking to a PMP is fundamentally 
an asynchronous, event-driven operation just like any other FIS 
"conversation."

We don't need to be adding hooks for each new and interesting type of 
FIS sent across the wire.  That just leads to an awful API.

	Jeff



