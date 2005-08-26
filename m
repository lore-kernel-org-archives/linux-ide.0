From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: RE: libata-dev queue updated
Date: Fri, 26 Aug 2005 17:41:15 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF001660ADB@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:11257 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S1751054AbVHZInS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Aug 2005 04:43:18 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>

Hi Bunk,

Thank you for your replay.

> With SCSI=m and SCSI_SATA=y this allows the static enabling 
> of the SATA drivers with unwanted effects, e.g.:
> - SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y
>   -> SCSI_ATA_ADMA is built statically but scsi/built-in.o is 
> not linked 
>      into the kernel
> - SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y, SCSI_SATA_AHCI=m
>   -> SCSI_ATA_ADMA and libata are built statically but 
>      scsi/built-in.o is not linked into the kernel,
>      SCSI_SATA_AHCI is built modular (unresolved symbols due 
> to missing 
>                                       libata)

I agree. 

Thanks again,
Haruo
