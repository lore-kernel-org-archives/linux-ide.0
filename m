From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: clear TF before IDENTIFYing
Date: Thu, 08 Feb 2007 09:56:25 -0500
Message-ID: <45CB3A19.6080205@rtr.ca>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com> <20070207193513.GA1929@artsapartment.org> <45CA2DBF.9040403@pobox.com> <45CA3895.5010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4698 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030649AbXBHO42 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 09:56:28 -0500
In-Reply-To: <45CA3895.5010108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Art Haas <ahaas@airmail.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, stable@kernel.org

Tejun Heo wrote:
> Some devices chock if Feature is not clear when IDENTIFY is issued.
> Set ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE for IDENTIFY such that whole
> TF is cleared when reading ID data.
> 
> Kudos to Art Haas for testing various futile patches over several
> months and Mark Lord for pointing out the fix.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Art Haas <ahaas@airmail.net>
> Cc: Mark Lord <mlord@pobox.com>

Signed-off-by: Mark Lord <mlord@pobox.com>

> I think this should go into -stable but a little bit hesitant because
> the code hasn't been tested widely.  This patch should really be
> harmless but who knows.  Jeff, Mark, what do you think?

If it was up to me, I'd plunk it directly into 2.6.20.1 and earlier.
But Jeff has his own ways..

 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 667acd2..d6fcf0a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1478,7 +1478,16 @@ int ata_dev_read_id(struct ata_device *dev, 
> unsigned int *p_class,
>     }
> 
>     tf.protocol = ATA_PROT_PIO;
> -    tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
> +
> +    /* Some devices choke if TF registers contain garbage.  Make
> +     * sure those are properly initialized.
> +     */
> +    tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
> +
> +    /* Device presence detection is unreliable on some
> +     * controllers.  Always poll IDENTIFY if available.
> +     */
> +    tf.flags |= ATA_TFLAG_POLLING;
> 
>     err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
>                      id, sizeof(id[0]) * ATA_ID_WORDS);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

