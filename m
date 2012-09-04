From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on freescale V2 controller
Date: Tue, 4 Sep 2012 15:51:26 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohui Xie <Shaohui.Xie@freescale.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Anju Bhartiya <Anju.Bhartiya@freescale.com>
List-Id: linux-ide@vger.kernel.org

> +	/* Read command completed register */
> +	done_mask = ioread32(hcr_base + CC);
> +
> +	if (host_priv->quirks & SATA_FSL_QUIRK_V2_ERRATA) {
> +		if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> +			for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> +				qc = ata_qc_from_tag(ap, tag);
> +				if (qc && ata_is_atapi(qc->tf.protocol))
{
> +					atapi_flag = 1;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Workaround for data length mismatch errata */
> +	if (atapi_flag) {

Seems to me like the conditionals for this code are all
in the wrong order - adding code to the normal path.

The whole lot should probably be inside:
	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
and the 'atapi_flag' boolean removed.

I also wonder it this is worthy of an actual quirk?
Might be worth doing anyway.

	David
