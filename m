From: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Wed, 5 Sep 2012 03:20:04 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079C4915@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6FD6@saturn3.aculab.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bhartiya Anju-B07263 <B07263@freescale.com>
List-Id: linux-ide@vger.kernel.org

> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Tuesday, September 04, 2012 10:51 PM
> To: Xie Shaohui-B21989; jgarzik@pobox.com; linux-ide@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Bhartiya
> Anju-B07263
> Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
> freescale V2 controller
> 
> > +	/* Read command completed register */
> > +	done_mask = ioread32(hcr_base + CC);
> > +
> > +	if (host_priv->quirks & SATA_FSL_QUIRK_V2_ERRATA) {
> > +		if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +			for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> > +				qc = ata_qc_from_tag(ap, tag);
> > +				if (qc && ata_is_atapi(qc->tf.protocol))
> {
> > +					atapi_flag = 1;
> > +					break;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Workaround for data length mismatch errata */
> > +	if (atapi_flag) {
> 
> Seems to me like the conditionals for this code are all in the wrong
> order - adding code to the normal path.
> 
> The whole lot should probably be inside:
> 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) { and the
> 'atapi_flag' boolean removed.
[S.H] OK. But I need to move the "done_mask = ioread32(hcr_base + CC);" before these codes,
 because these codes will clean command completed register.

> 
> I also wonder it this is worthy of an actual quirk?
> Might be worth doing anyway.
[S.H] The quirk is useful for our internal use(there is another errata but got fixed by silicon upgrade),
but you are right it's worth doing anyway in upstream, since the upstream code only handles this errata.

Best Regards, 
Shaohui Xie
