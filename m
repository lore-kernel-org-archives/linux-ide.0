From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] ata_scsi_verify_xlat() fix
Date: Fri, 25 Feb 2005 15:52:22 +0800
Message-ID: <421ED936.9050500@tw.ibm.com>
References: <421D7E5A.80702@tw.ibm.com> <421D85C2.6050103@pobox.com> <421EB06E.5040504@tw.ibm.com> <421EB76E.4030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:22515 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262644AbVBYHwh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 02:52:37 -0500
In-Reply-To: <421EB76E.4030005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>



Jeff Garzik wrote:

> 
> As far as I can tell, your patches are diff'd correctly.  Yet, they 
> still do not apply:
> 
> drivers/scsi/libata-scsi.c 1.68: 1661 lines
> 2 out of 2 hunks FAILED -- saving rejects to file 
> drivers/scsi/libata-scsi.c.rej
> 
> I do not understand the problem, so I simply applied them by hand.
> 

Thanks!

Albert


