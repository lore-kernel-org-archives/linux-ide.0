From: Grant Grundler <grundler@google.com>
Subject: Re: External port Multiplier Support in linux
Date: Fri, 10 Jul 2009 10:13:16 -0700
Message-ID: <da824cf30907101013n13fcc46x1e6e9540da970685@mail.gmail.com>
References: <4A5743E6.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:27975 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbZGJRNW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jul 2009 13:13:22 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id n6AHDJKt014679
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2009 18:13:20 +0100
Received: from qyk3 (qyk3.prod.google.com [10.241.83.131])
	by spaceape12.eur.corp.google.com with ESMTP id n6AHD5Df001774
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2009 10:13:16 -0700
Received: by qyk3 with SMTP id 3so842121qyk.20
        for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2009 10:13:16 -0700 (PDT)
In-Reply-To: <4A5743E6.9000302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pinchu <pinchu4u@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jul 10, 2009 at 6:36 AM, pinchu<pinchu4u@gmail.com> wrote:
> Hi Jeff,
>
> We have an external RAID Disk Array which is having a port multiplier and
> four HDD behind the port multiplier. The RAID box is connected to host via
> SATA interface. The port multiplier we are using is implemented in FPGA. The
> linux kernel 2.6.28 is not detecting the port multiplier and devices behind
> it.
>
> By any chance linux kernel 2.6.28 supports external port multiplier?

Yes.

> Does linux automatically detect port multiplier during bootup?

Yes.

> Di i need to write driver for detecting the port multiplier?

Yes. The SATA controller driver has to include support for port multipliers.

Here is how to determine if the SATA controller driver can support PMP:
grundler <2050>fgrep ATA_FLAG_PMP drivers/ata/*c
drivers/ata/ahci.c:             pi.flags |= ATA_FLAG_PMP;
drivers/ata/libata-core.c:      WARN_ON(ap->flags & ATA_FLAG_PMP);
drivers/ata/sata_fsl.c:                         ATA_FLAG_PMP | ATA_FLAG_NCQ),
drivers/ata/sata_mv.c:                            ATA_FLAG_PMP |
ATA_FLAG_ACPI_SATA,
drivers/ata/sata_sil24.c:                                 ATA_FLAG_AN
| ATA_FLAG_PMP,

So right now, it seems only 4 drivers can.

hth,
grant
