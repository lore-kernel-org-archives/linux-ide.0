From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Fri, 18 Feb 2005 22:02:53 -0800
Message-ID: <20050219060253.GC720678@sgi.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org> <4213BADF.8000307@motorola.com> <4213C852.4070105@pobox.com> <4213F1AA.6060500@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from omx3-ext.sgi.com ([192.48.171.20]:8889 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261642AbVBSGD0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Feb 2005 01:03:26 -0500
Content-Disposition: inline
In-Reply-To: <4213F1AA.6060500@motorola.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ajit Prem <Ajit.Prem@motorola.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Feb 16, 2005 at 06:21:46PM -0700, Ajit Prem wrote:
> 
> It's just a dirty hack that works
> for the limited case where I'm
> using only 1 disk off port 1 on a
> board that makes 3 ports available.
> I'm not sure what the side effects
> are, or how things will work if
> all 3 ports are used (which I'm
> unable to test).
> 
> Anyway, here's the hack I used:
> 
> @@ -174,6 +174,9 @@
>    if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
>        struct ata_queued_cmd *qc;
> 
> +       vsc_sata_scr_write(ap, VSC_SATA_SCR_ERROR_OFFSET, 0x00010001);

I think this should be 0x00010002, since you're trying to clear
bits 1 and 16.

> +       readl((void *)ap->ioaddr.status_addr);
> +
>        qc = ata_qc_from_tag(ap, ap->active_tag);
>        if (qc && (!(qc->tf.ctl & ATA_NIEN)))
>            handled += ata_host_intr(ap, qc);


jeremy
