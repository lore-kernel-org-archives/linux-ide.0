From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add Intel SCH PATA Support
Date: Tue, 06 May 2008 08:09:11 -0400
Message-ID: <48204A67.7070308@pobox.com>
References: <20080505172356.636649e6@dxy.sh.intel.com>	<481EE284.2010708@ru.mvista.com>	<20080505224420.44730838@dxy.sh.intel.com>	<481F2144.5000409@ru.mvista.com> <20080506094131.4bd70c8a@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40225 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbYEFMJY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 08:09:24 -0400
In-Reply-To: <20080506094131.4bd70c8a@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Also...



Alek Du wrote:
> +/*
> + *  Supports:
> + *    Intel SCH (AF82US15W, AF82US15L, AF82UL11L) chipsets
> + */

a link to the public datasheet would be nice, somewhere in a comment


> +static const struct pci_device_id sch_pci_tbl[] = {
> +	/* Intel SCH PATA Controller */
> +	{ 0x8086, 0x811A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },

recommend using PCI_VDEVICE() macro

[and it would be nice if someone converted ata_piix.c, too]


> +	{ }	/* terminate list */

> +static int __init sch_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&sch_pci_driver);
> +	if (rc)
> +		return rc;
> +	in_module_init = 0;
> +	return 0;
> +}

with the in_module_init thing removed (per Alan's comment), this can 
become 'return pci_register_driver(...)' nicely


