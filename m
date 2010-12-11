From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] ata: pata_at91.c bugfix for high master clock
Date: Sat, 11 Dec 2010 17:10:11 -0500
Message-ID: <4D03F6C3.5030709@pobox.com>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46628 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0LKWKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Dec 2010 17:10:15 -0500
In-Reply-To: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>
Cc: sshtylyov@mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, christian.glindkamp@taskit.de, ryan@bluewatersys.com, pgsellmann@portner-elektronik.at

On 12/11/2010 03:37 PM, Igor Plyatov wrote:
> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> does not detect ATA device.
>
> Signed-off-by: Igor Plyatov<plyatov@gmail.com>

Thanks, queued (absent further comments...)


