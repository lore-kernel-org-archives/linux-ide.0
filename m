From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6] AHCI: print port ID not number
Date: Thu, 24 Feb 2005 14:49:53 -0500
Message-ID: <421E2FE1.7090703@pobox.com>
References: <421E2A62.9060303@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51892 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262458AbVBXTuP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 14:50:15 -0500
In-Reply-To: <421E2A62.9060303@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org

Brett Russ wrote:
> The attached patch fixes the "ata#: error occurred, port reset" line to 
> display the port id instead of the port number.
> 
> Signed-off-by: Brett Russ <russb@emc.com>
> 
> 
> ------------------------------------------------------------------------
> 
> --- libata-2.6/drivers/scsi/ahci.c      Thu Feb 24 14:18:35 2005
> +++ libata-2.6-ahci-printk/drivers/scsi/ahci.c  Thu Feb 24 14:21:41 2005
> @@ -574,7 +574,7 @@
>         writel(tmp, port_mmio + PORT_CMD);
>         readl(port_mmio + PORT_CMD); /* flush */
> 
> -       printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->port_no);
> +       printk(KERN_WARNING "ata%u: error occurred, port reset\n", ap->id);

Your patch is corrupted, as <something> converted tabs to spaces.

I highly recommend finding a Unix machine with sendmail, and sending 
patches like this:

The ideal is an inline patch, rather than an attachment anyway.  e.g.

To: ...
From: ...
Subject: ...
<blank line>
Patch description
Patch

cat'd to 'sendmail -t'.  Sendmail (or another MTA which provides a 
/usr/sbin/sendmail wrapper) will automatically fill in other headers 
like Message-ID and Date.

	Jeff


