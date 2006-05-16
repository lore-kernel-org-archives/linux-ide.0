From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 21/22] libata: implement ATA printk helpers
Date: Tue, 16 May 2006 18:23:08 +0800
Message-ID: <4469A80C.5090807@tw.ibm.com>
References: <11473487912421-git-send-email-htejun@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:63958 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751754AbWEPKXO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 06:23:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4GAN9ee012474
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 06:23:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4GAN9rI176338
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:23:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k4GAN8OO008998
	for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 04:23:09 -0600
In-Reply-To: <11473487912421-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_{port|dev}_printk() which prefixes the message with
> proper identification string.  This change is necessary for later PM
> support because devices and links should be identified differently
> depending on how they are attached.
> 
> This also helps unifying device id strings.  Currently, there are two
> forms in use (P is the port number D device number) - 'ataP(D):', and
> 'ataP: dev D '.  These macros also make it harder to forget proper ID
> string (e.g. printing only port number when a device is in question).
> 
> Debug message handling can be integrated into these printk macros by
> passing debug type and level via @lv.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  include/linux/libata.h |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> 387b4ba08bdce6d729cf441e7c1173d9863f4c04
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index bd8cd3b..7b54d92 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -650,7 +650,18 @@ extern void ata_eng_timeout(struct ata_p
>  extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
>  extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
>  
> +/*
> + * printk helpers
> + */
> +#define ata_port_printk(ap, lv, fmt, args...) \
> +	printk(lv"ata%u: "fmt, (ap)->id , ##args)
> +
> +#define ata_dev_printk(dev, lv, fmt, args...) \
> +	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
>  
> +/*
> + * qc helpers
> + */
>  static inline int
>  ata_sg_is_last(struct scatterlist *sg, struct ata_queued_cmd *qc)
>  {

A minor question:
Messages like "ata5.01" are seen in the log. Do we ever have more than 2 devices per port?
(with port multiplier?) Otherwise, maybe "ata5.1" is shorter?

--
albert

