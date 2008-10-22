From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/4] libata: clean up the SFF code for coding style
Date: Wed, 22 Oct 2008 17:48:38 +0200
Message-ID: <874p34ska1.fsf@denkblock.local>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180903.7781.51521.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:36699 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYJVPsq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 11:48:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@redhat.com>
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
>
>  drivers/ata/libata-sff.c |  136 +++++++++++++++++++++++-----------------------
>  1 files changed, 69 insertions(+), 67 deletions(-)
>
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 1afaa96..03c2d41 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
[...]
> @@ -1016,18 +1036,19 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
>   *	RETURNS:
>   *	1 if ok in workqueue, 0 otherwise.
>   */
> -static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
> +static inline int ata_hsm_ok_in_wq(struct ata_port *ap,
> +						struct ata_queued_cmd *qc)
>  {
>  	if (qc->tf.flags & ATA_TFLAG_POLLING)
>  		return 1;
>  
>  	if (ap->hsm_task_state == HSM_ST_FIRST) {
>  		if (qc->tf.protocol == ATA_PROT_PIO &&
> -		    (qc->tf.flags & ATA_TFLAG_WRITE))
> +		   (qc->tf.flags & ATA_TFLAG_WRITE))
>  		    return 1;

Sorry, I don't understand that at all. In my opinion, the nesting of
parentheses is more obvious and easier to understand without that
change. Moreover, the indentation of the return statement would have
needed fixing much more desperately ;-).

>  
>  		if (ata_is_atapi(qc->tf.protocol) &&
> -		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
> +		   !(qc->dev->flags & ATA_DFLAG_CDB_INTR))

Ditto.

[...]
> @@ -2711,17 +2760,18 @@ int ata_pci_sff_prepare_host(struct pci_dev *pdev,
>  	*r_host = host;
>  	return 0;
>  
> - err_bmdma:
> +err_bmdma:
>  	/* This is necessary because PCI and iomap resources are
>  	 * merged and releasing the top group won't release the
>  	 * acquired resources if some of those have been acquired
>  	 * before entering this function.
>  	 */
>  	pcim_iounmap_regions(pdev, 0xf);
> - err_out:
> +err_out:

Yes, I've wondered about these myself occasionally. Personally, I don't
insert a blank before those labels either and would be in favour of such
a change. But do we actually have a convention regarding this matter?

Regards,

Elias
