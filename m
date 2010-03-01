From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/5] Subject: [PATCH] pata_efar: add locking for parallel
 scanning
Date: Mon, 01 Mar 2010 15:12:14 -0500
Message-ID: <4B8C1F9E.8040703@garzik.org>
References: <20100217131532.16884.21696.stgit@localhost.localdomain> <20100217131556.16884.47082.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:56213 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0CAUM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 15:12:28 -0500
In-Reply-To: <20100217131556.16884.47082.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: jeff@garzik.org.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 02/17/2010 08:16 AM, Alan Cox wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>
> Add clearing of UDMA enable bit also for PIO modes and then add
> an extra locking for parallel scanning.
>
> This is similar change as commit 60c3be3 for ata_piix host driver
> and while pata_efar doesn't enable parallel scan yet the race could
> probably also be triggered by requesting re-scanning of both ports
> at the same time using SCSI sysfs interface.
>
> [Ported to current kernel without other patch dependancies by
>   Alan Cox]
>
> Original is
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
>
> This one is
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/pata_efar.c |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)

applied 2-5


