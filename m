From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/15] libata: use SATA speeding down in ata_drive_probe_reset()
Date: Sat, 01 Apr 2006 14:56:09 -0500
Message-ID: <442EDAD9.9040308@pobox.com>
References: <11438230992911-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30173 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751480AbWDAT4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:56:17 -0500
In-Reply-To: <11438230992911-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, "Eric D. Mudama" <edmudama@gmail.com>

Tejun Heo wrote:
> Make ata_drive_probe_reset() use SATA SPD configuration.  Hardreset
> will be force if speed renegotiation is necessary.  Also, if a
> hardreset fails, PHY speed is stepped down and hardreset is retried
> until the lowest speed is reached.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Tentative ACK:  I wonder if a naked COMRESET is the best procedure for 
changing PHY speeds.  We might even power down the phy, change speeds, 
and then power it up again.  Need to reach my SATA docs, and maybe talk 
to some device/controller vendors.

	Jeff



