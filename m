From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/7] ide: merge ide_disk_special() into do_special()
Date: Wed, 13 May 2009 13:55:02 -0700
Message-ID: <1242248102.4639.17.camel@Joe-AcerAspire>
References: <20090513205139.28638.87226.sendpatchset@localhost.localdomain>
	 <20090513205200.28638.90827.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:3073 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZEMUzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 16:55:06 -0400
In-Reply-To: <20090513205200.28638.90827.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2009-05-13 at 22:52 +0200, Bartlomiej Zolnierkiewicz wrote:
> While at it:
> - change debug printk() level to KERN_DEBUG
> - update documentation
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ide-io.c |   44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -184,11 +184,28 @@ static void ide_tf_set_setmult_cmd(ide_d
[]
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "%s: %s: 0x%02x\n", drive->name, s->all);
> +#endif

pr_debug?


