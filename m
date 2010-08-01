From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream] sata_fsl,mv,nv: prepare for NCQ command
 completion update
Date: Sun, 01 Aug 2010 19:47:59 -0400
Message-ID: <4C5607AF.8020109@garzik.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C247B54.2050900@garzik.org> <4C247C36.6040007@kernel.org> <4C24A903.4060908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37224 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0HAXsG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Aug 2010 19:48:06 -0400
In-Reply-To: <4C24A903.4060908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org, Ashish Kalra <ashish.kalra@freescale.com>, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>

On 06/25/2010 09:02 AM, Tejun Heo wrote:
> Make the following changes to prepare for NCQ command completion
> update.  Changes made by this patch don't cause any functional
> difference.
>
> * sata_fsl_host_intr(): rename the local variable qc_active to
>    done_mask as that's what it is.
>
> * mv_process_crpb_response(): restructure if clause for easier update.
>
> * nv_adma_interrupt(): drop unnecessary error variable.
>
> * nv_swncq_sdbfis(): drop unnecessary nr_done and return 0 on success.
>    Typo fix.
>
> * nv_swncq_dmafis(): drop unused return value and return void.
>
> * nv_swncq_host_interrupt(): drop unnecessary return value handling.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Ashish Kalra<ashish.kalra@freescale.com>
> Cc: Saeed Bishara<saeed@marvell.com>
> Cc: Mark Lord<liml@rtr.ca>
> Cc: Robert Hancock<hancockr@shaw.ca>
> ---
> So, something like this.  I tested both flavors of sata_nv but don't
> have access to sata_mv or sata_fsl, but the conversion is pretty
> straight forward and failures should be pretty easy to catch.

applied


