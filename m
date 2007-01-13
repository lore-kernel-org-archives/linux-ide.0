From: Faik Uygur <faik@pardus.org.tr>
Subject: Re: ahci_softreset prevents acpi_power_off
Date: Sat, 13 Jan 2007 14:10:33 +0200
Message-ID: <200701131410.34265.faik@pardus.org.tr>
References: <200701111231.26819.faik@pardus.org.tr> <45A831EA.50601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:47460 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030514AbXAMMKN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jan 2007 07:10:13 -0500
In-Reply-To: <45A831EA.50601@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Tejun,

13 Oca 2007 Cts 03:12 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1=
n=C4=B1z:
> If possible, please post dmesg of shutting down. =20

I have taken more detailed dmesg outputs of three configs with ATA_DEBU=
G and=20
ATA_VERBOSE_DEBUG defined. You can find them at this address:

http://cekirdek.pardus.org.tr/~faik/tmp/ahci/

* ahci file is the output of CONFIG_SCSI_SATA_AHCI compiled config
* noahci file is the output of CONFIG_SCSI_SATA_AHCI not compiled confi=
g
* ahci-nullsoftreset is the output of CONFIG_SCSI_SATA_AHCI compiled co=
nfig
but given NULL to softreset parameters of ata_do_eh in ahci.c

Also poweroff-config is the used .config file. Only CONFIG_SCSI_SATA_AH=
CI is
changed between them.

I am not familiar with AHCI nor ATA internals. So please ask if you wou=
ld like=20
to see anything more.

Regards,
- Faik
