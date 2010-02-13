From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] non-existant config in kernel source (CONFIG_AHCI)
Date: Sat, 13 Feb 2010 17:49:17 -0500
Message-ID: <4B772C6D.5000600@pobox.com>
References: <20100205132959.GB6874@faui49.informatik.uni-erlangen.de> <201002051457.04135.elendil@planet.nl> <20100205152635.GC7299@faui49.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:44482 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0BMWtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 17:49:21 -0500
In-Reply-To: <20100205152635.GC7299@faui49.informatik.uni-erlangen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
Cc: Frans Pop <elendil@planet.nl>, knan-lkml@anduin.net, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de, alan@lxorguk.ukuu.org.uk

On 02/05/2010 10:26 AM, Christoph Egger wrote:
> On Fri, Feb 05, 2010 at 02:57:00PM +0100, Frans Pop wrote:
>> Christoph Egger wrote:
>>> --- a/drivers/ata/pata_marvell.c
>>> +++ b/drivers/ata/pata_marvell.c
>>> @@ -147,7 +147,7 @@ static int marvell_init_one (struct pci_dev *pdev,
>>> 	if (pdev->device == 0x6101)
>>> 		ppi[1] =&ata_dummy_port_info;
>>>
>>> -#if defined(CONFIG_AHCI) || defined(CONFIG_AHCI_MODULE)
>>> +#if defined(CONFIG_SATA_AHCI) || defined(SATA_CONFIG_AHCI_MODULE)
>>
>> Shouldn't the last be CONFIG_SATA_AHCI_MODULE ?
>
> Right my fault. Updated patch below
>
> -----
>> From 60136f94d9c97f9a788738e30731e25bd794322b Mon Sep 17 00:00:00 2001
> From: Christoph Egger<siccegge@stud.informatik.uni-erlangen.de>
> Date: Fri, 5 Feb 2010 13:26:33 +0100
> Subject: [PATCH] CONFIG_AHCI is really CONFIG_SATA_AHCI
>
> The marvell driver comtains a fallback to ahci for the sata ports
> which is incorrectly checked as CONFIG_AHCI while the only AHCI config
> item is actually called SATA_AHCI (which also sounds sensible
> considering it's a fallback for the sata ports).
>
> Signed-off-by: Christoph Egger<siccegge@stud.informatik.uni-erlangen.de>
> ---
>   drivers/ata/pata_marvell.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied


