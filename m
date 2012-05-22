From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v3 1/3] PATA host controller driver for ep93xx
Date: Tue, 22 May 2012 16:05:00 -0400
Message-ID: <4FBBF16C.4090100@garzik.org>
References: <4F86C63C.6030908@metasoft.pl> <4F86C6DC.8060101@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46653 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab2EVUFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 May 2012 16:05:05 -0400
Received: by qcro28 with SMTP id o28so4286150qcr.19
        for <linux-ide@vger.kernel.org>; Tue, 22 May 2012 13:05:02 -0700 (PDT)
In-Reply-To: <4F86C6DC.8060101@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/12/2012 08:13 AM, Rafal Prylowski wrote:
>
> Add PATA host controller driver for ep93xx.
>
> Signed-off-by: Rafal Prylowski<prylowski@metasoft.pl>
> Cc: Joao Ramos<joao.ramos@inov.pt>
> Cc: H Hartley Sweeten<hsweeten@visionengravers.com>
> Cc: Ryan Mallon<rmallon@gmail.com>
> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
> Cc: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>
> ---
>   drivers/ata/Kconfig       |    9
>   drivers/ata/Makefile      |    1
>   drivers/ata/pata_ep93xx.c | 1044 ++++++++++++++++++++++++++++++++++++

applied



