From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 15/64] pata_efar: always program master_data before slave_data
Date: Wed, 20 Jan 2010 23:16:35 -0500
Message-ID: <4B57D523.2000809@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171555.14623.3131.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:52402 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab0AUEQh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:16:37 -0500
In-Reply-To: <20100118171555.14623.3131.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_efar: always program master_data before slave_data
>
> We may need to set SITRE before programming slave_data.
>
> This makes pata_efar match the behavior of IDE slc90e66 host driver
> and also libata ata_piix one.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_efar.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

OK but did not apply to libata-dev.git


