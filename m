From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Mon, 7 Jul 2014 11:19:25 -0700
Message-ID: <CAPcyv4gLb6i5PSi9_uxHv-UQA8-w=a55eOP1GtkXmvTzY5P+7A@mail.gmail.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
	<1404628121-8158-2-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:59271 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaGGST0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 14:19:26 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so4675141igb.5
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 11:19:26 -0700 (PDT)
In-Reply-To: <1404628121-8158-2-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Sat, Jul 5, 2014 at 11:28 PM, Kevin Hao <haokexin@gmail.com> wrote:
> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 17 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. This patch provides the function
> for libata to adjust the queue depth for a host controller.
>
> Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: Remove the changes for the ata tag helper functions.
>
>  drivers/ata/libata-core.c | 29 ++++++++++++++++++++++++++---
>  include/linux/libata.h    |  3 +++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8f3043165048..c9c51646d8e8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4728,14 +4728,14 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>  static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>  {
>         struct ata_queued_cmd *qc = NULL;
> -       unsigned int i, tag;
> +       unsigned int i, tag, max_queue = ap->host->queue_depth;
>
>         /* no command while frozen */
>         if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
>                 return NULL;
>
> -       for (i = 0; i < ATA_MAX_QUEUE; i++) {
> -               tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
> +       for (i = 0; i < max_queue; i++) {
> +               tag = (i + ap->last_tag + 1) % max_queue;

This change may cause the compiler to do a full divide where
previously it could optimize to power-of-2 math with the visibility of
the ATA_MAX_QUEUE constant.  How about converting
ap->host->queue_depth to ap->host->queue_depth_mask?  ...then this
becomes:

    tag = (i + ap->last_tag + 1) & max_queue_mask
