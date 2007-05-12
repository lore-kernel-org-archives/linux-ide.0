From: Andreas Arens <ari@goron.de>
Subject: Re: [git patches] libata updates
Date: Sat, 12 May 2007 12:06:11 +0200
Message-ID: <f243ht$iqa$1@sea.gmane.org>
References: <20070511223231.GA6551@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48212 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755623AbXELKGf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 May 2007 06:06:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HmoUT-0002qI-5E
	for linux-ide@vger.kernel.org; Sat, 12 May 2007 12:06:17 +0200
Received: from p50915a22.dip.t-dialin.net ([80.145.90.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 12 May 2007 12:06:17 +0200
Received: from ari by p50915a22.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 12 May 2007 12:06:17 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> upstream-linus
> 
..
> Andrew Morton (1):
>       git-libata-all: sata_via build fix
.. 
> diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> index 939c924..d105d2c 100644
> --- a/drivers/ata/sata_via.c
> +++ b/drivers/ata/sata_via.c
> @@ -116,10 +116,6 @@ static struct scsi_host_template svia_sht = {
>  .slave_configure     = ata_scsi_slave_config,
>  .slave_destroy               = ata_scsi_slave_destroy,
>  .bios_param          = ata_std_bios_param,
> -#ifdef CONFIG_PM
> -     .suspend                = ata_scsi_device_suspend,
> -     .resume                 = ata_scsi_device_resume,
> -#endif
>  };
>  
>  static const struct ata_port_operations vt6420_sata_ops = {
> @@ -415,7 +411,7 @@ static int vt6420_prepare_host(struct pci_dev *pdev,
> struct ata_host **r_host)
>  struct ata_host *host;
>  int rc;
>  
> -     rc = ata_pci_prepare_native_host(pdev, ppi, 2, &host);
> +     rc = ata_pci_prepare_native_host(pdev, ppi, &host);
>  if (rc)
>  return rc;
>  *r_host = host;

This, additionally to the obvious build fix, again removes the suspend support.
Is this intended?



