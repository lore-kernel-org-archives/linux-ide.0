From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 06/64] pata_atiixp: add locking for parallel scanning
Date: Wed, 20 Jan 2010 23:07:26 -0500
Message-ID: <4B57D2FE.9050702@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171437.14623.12197.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:58860 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab0AUEH3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:07:29 -0500
In-Reply-To: <20100118171437.14623.12197.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:14 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_atiixp: add locking for parallel scanning
>
> This is similar change as commit 60c3be3 for ata_piix host driver
> and while pata_atiixp doesn't enable parallel scan yet the race
> could probably also be triggered by requesting re-scanning of both
> ports at the same time using SCSI sysfs interface.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_atiixp.c |   14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

did not apply to libata-dev.git#upstream, so skipped this and patch #7


