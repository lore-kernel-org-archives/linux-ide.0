From: Jeff Garzik <jgarzik@pobox.com>
Subject: ATAPI issues (was Re: Issues with SIS 964 chipset on SATA)
Date: Thu, 17 Feb 2005 03:37:38 -0500
Message-ID: <421457D2.5090104@pobox.com>
References: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37868 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262270AbVBQIhx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 03:37:53 -0500
In-Reply-To: <E0854782-793A-11D9-A80A-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Gary Poppitz <poppitzg@iomega.com>, Jens Axboe <axboe@suse.de>

Another issue with ATAPI is that it _may_ or may not send an interrupt 
prior writing the CDB.

This behavior is dependent on an obsolete and undocumented in ATAPI7 bit 
5 of IDENTIFY PACKET DEVICE word 0, apparently.

	Jeff



