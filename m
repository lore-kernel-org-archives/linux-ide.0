From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] ata_scsi_verify_xlat() fix
Date: Fri, 25 Feb 2005 00:28:14 -0500
Message-ID: <421EB76E.4030005@pobox.com>
References: <421D7E5A.80702@tw.ibm.com> <421D85C2.6050103@pobox.com> <421EB06E.5040504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48017 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262543AbVBYF23 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 00:28:29 -0500
In-Reply-To: <421EB06E.5040504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>


As far as I can tell, your patches are diff'd correctly.  Yet, they 
still do not apply:

drivers/scsi/libata-scsi.c 1.68: 1661 lines
2 out of 2 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-scsi.c.rej

I do not understand the problem, so I simply applied them by hand.

Thanks for your patience,

	Jeff



