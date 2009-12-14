From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's EP93xx
 CPUs
Date: Mon, 14 Dec 2009 17:06:34 -0500
Message-ID: <4B26B6EA.8050403@garzik.org>
References: <200911261651.40928.bzolnier@gmail.com> <4B15BAA1.2010408@bluewatersys.com> <200912020206.59659.bzolnier@gmail.com> <4B26B0D6.4080809@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53684 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758593AbZLNWGh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 17:06:37 -0500
In-Reply-To: <4B26B0D6.4080809@bluewatersys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Joao Ramos <joao.ramos@inov.pt>, H Hartley Sweeten <hsweeten@visionengravers.com>

On 12/14/2009 04:40 PM, Ryan Mallon wrote:
> I have added some of my own debugging. The problem appears to be that
> __pata_ep93xx_write gets called from probe (via ata_host_activate), but
> ap->private_data (ata_timing) is still null. The timing private_data is
> set by pata_ep93xx_set_piomode, but that needs adev->pio_mode set, but I
> don't know where this happens. I assume the ATA core handles this. Do I
> need to call pata_ep93xx_set_piomode from pata_ep93xx_probe before
> ata_host_activate, or should the private_data timing be set to some
> default in the probe?


ap->private_data is traditionally initialized in the ->port_start() hook.

Likely, you should follow other drivers and allocate a useful data 
structure containing useful default values, which can then be adjusted 
in other hooks such as ->set_dmamode() or ->set_piomode()

	Jeff



