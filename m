From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 13:29:41 -0500
Message-ID: <4B423395.6070309@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk>	<4B420871.2090309@garzik.org>	<20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>	<4B421827.6050308@garzik.org> <20100104170236.5d85959f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:35993 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0ADS3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 13:29:43 -0500
Received: by ywh6 with SMTP id 6so15574826ywh.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 10:29:42 -0800 (PST)
In-Reply-To: <20100104170236.5d85959f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 12:02 PM, Alan Cox wrote:
> If we had any SFF PATA controllers using MMIO. I can't find any.

Well,

[jgarzik@bd linux-2.6]$ grep -l ATA_FLAG_MMIO drivers/ata/pata_*.c
drivers/ata/pata_at32.c
drivers/ata/pata_bf54x.c
drivers/ata/pata_ixp4xx_cf.c
drivers/ata/pata_macio.c
drivers/ata/pata_octeon_cf.c
drivers/ata/pata_palmld.c
drivers/ata/pata_pdc2027x.c
drivers/ata/pata_rb532_cf.c
drivers/ata/pata_scc.c

plus drivers/ata/pata_platform.c

