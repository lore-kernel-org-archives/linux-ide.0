From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/15] libata: add dev->sata_spd_limit and helpers
Date: Sat, 01 Apr 2006 14:51:33 -0500
Message-ID: <442ED9C5.3080301@pobox.com>
References: <11438230982257-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:16861 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751530AbWDATvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:51:39 -0500
In-Reply-To: <11438230982257-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> dev->sata_spd_limit contrains SATA PHY speed of the device and is
> initialized to the configured value on probing.
> 
> Currently, This is only valid for dev[0] but still put into ata_device
> instead of ata_port.  This is because 1. it's device constraints
> (ie. when hotpluggin, it should be cleared with other device info)
> 2. for port multiplier, link actually belongs to each device.
> 
> Three helper functions - ata_down_sata_spd_limit(),
> ata_set_sata_spd_needed() and ata_set_sata_spd() - are implemented.
> They will be used by ata_bus_probe() rewrite and later by EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK, I definitely don't want to closely associate phy and device 
parameters, because they are fundamentally two different things.

We program and address PHYs, so perhaps a sata_phy struct is needed.

Port multipliers also get interesting because we need to use ATA-ish 
commands to talk to the PM phys.  Perhaps a struct ata_port_mult inside 
ata_device is warranted, where one stores an array of sata_phy structs, 
and other PM-specific details.

	Jeff



