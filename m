From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2.6.26-rc4] ata: Convert deprecated static spinlock_t
 lock	instance to static DEFINE_SPINLOCK(lock)
Date: Fri, 30 May 2008 18:11:22 -0400
Message-ID: <48407B8A.4030507@pobox.com>
References: <20080529175814.GB4926@kernelpanic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44928 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbYE3WLY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:24 -0400
In-Reply-To: <20080529175814.GB4926@kernelpanic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pradeep Singh Rautela <rautelap@gmail.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

Pradeep Singh Rautela wrote:
> Replace deprecated static spinlock_t instance to static DEFINE_SPINLOCK(lock).
> 
> Signed-off-by: Pradeep Singh <rautelap@gmail.com>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 3c89f20..cc816ca 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5403,7 +5403,7 @@ static void ata_host_stop(struct device *gendev, void *res)
>   */
>  static void ata_finalize_port_ops(struct ata_port_operations *ops)
>  {
> -	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
> +	static DEFINE_SPINLOCK(lock);
>  	const struct ata_port_operations *cur;
>  	void **begin = (void **)ops;

applied


