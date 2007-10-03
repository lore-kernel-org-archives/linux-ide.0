From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 01/10] pata_acpi: restore driver
Date: Wed, 03 Oct 2007 17:16:01 -0400
Message-ID: <47040691.7080302@garzik.org>
References: <200710022052.l92Kqx0w021673@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34916 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbXJCVQE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 17:16:04 -0400
In-Reply-To: <200710022052.l92Kqx0w021673@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

akpm@linux-foundation.org wrote:
> --- /dev/null
> +++ a/drivers/ata/pata_acpi.c
> @@ -0,0 +1,403 @@
> +/*
> + *	ACPI PATA driver
> + *
> + *	(c) 2007 Red Hat  <alan@redhat.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/blkdev.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <scsi/scsi_host.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acnames.h>
> +#include <acpi/acnamesp.h>
> +#include <acpi/acparser.h>
> +#include <acpi/acexcep.h>
> +#include <acpi/acmacros.h>
> +#include <acpi/actypes.h>
> +
> +#include <linux/libata.h>
> +#include <linux/ata.h>
> +
> +#include "libata-acpi.h"


Just to recap the conversion in IRC, this patch contains two fatal problems:

* libata-acpi.h was not included, thus it doesn't build

* it depends on non-existent symbol CONFIG_SATA_ACPI (should be 
CONFIG_ATA_ACPI), which also means it never gets built

So the ball and lyrics are back in Alan's court ;-)
(or should I say submarine back in Alan's coastal waters)

	Jeff


