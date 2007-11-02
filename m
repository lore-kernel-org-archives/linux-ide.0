From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Fri, 02 Nov 2007 11:36:06 -0400
Message-ID: <472B43E6.2020402@garzik.org>
References: <472B402A.4030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50096 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbXKBPgJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Nov 2007 11:36:09 -0400
In-Reply-To: <472B402A.4030009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Add dev->acpi_init_gtm and store initial GTM values on host
> initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
> is set.  This is to remember BIOS/firmware programmed initial timing
> for later use before reset and mode configuration modify it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

It sounds like pata_via and pata_amd need a foo_save_initial_config() 
much like AHCI, during which they would fill ppriv->init_gtm rather than 
ap->init_gtm.  Thoughts?  Both drivers are calling ata_acpi_cbl() 
themselves, permitting the possibility of ppriv->init_gtm.

This avoids forcing everyone else to bear the memory cost in ata_port 
for just these two drivers.

	Jeff



