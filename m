From: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH] [v2] sata_fsl: add workaround for data length mismatch
 on freescale V2 controller
Date: Thu, 6 Sep 2012 11:57:37 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C9079D3C6C@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1346905686-27912-1-git-send-email-Shaohui.Xie@freescale.com>
 <504888F8.5060907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:35003
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208Ab2IFL5m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Sep 2012 07:57:42 -0400
In-Reply-To: <504888F8.5060907@mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, Bhartiya Anju-B07263 <B07263@freescale.com>

> >
> >   	hstatus = ioread32(hcr_base + HSTATUS);
> >
> >   	sata_fsl_scr_read(&ap->link, SCR_ERROR, &SError);
> >
> > +	/* Read command completed register */
> > +	done_mask = ioread32(hcr_base + CC);
> > +
> > +	/* Workaround for data length mismatch errata */
> > +	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
> > +		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
> > +			qc = ata_qc_from_tag(ap, tag);
> > +			if (qc && ata_is_atapi(qc->tf.protocol)) {
> > +				u32 Hcontrol;
> 
>     No uppercase in variable names please. 
[S.H] OK.

Besides, you have 'hstatus'
> variable already and that would be inconsistent.
[S.H] Yes, but I ignored fatal error and device error, so this won't be an issue.

> 
> > +#define HCONTROL_CLEAR_ERROR	(1 << 27)
> > +				/* Set HControl[27] to clear error registers */
> > +				Hcontrol = ioread32(hcr_base + HCONTROL);
> > +				iowrite32(Hcontrol | HCONTROL_CLEAR_ERROR,
> > +						hcr_base + HCONTROL);
> > +
> > +				/* Clear HControl[27] */
> > +				iowrite32(Hcontrol & (~HCONTROL_CLEAR_ERROR),
> 
>     Parens not needed around ~HCONTROL_CLEAR_ERROR.
[S.H] OK.


Best Regards, 
Shaohui Xie

