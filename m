From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 18:12:16 +0200
Message-ID: <20121023161216.GC26756@x1.osrc.amd.com>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
 <20121020120047.GC17563@liondog.tnic>
 <50841CFC.2030802@talktalk.net>
 <20121021165756.GA20642@liondog.tnic>
 <50856AA8.1000607@talktalk.net>
 <20121022202734.GA16169@liondog.tnic>
 <20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
 <20121023101751.GA24656@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37150 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab2JWQMS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 12:12:18 -0400
Content-Disposition: inline
In-Reply-To: <20121023101751.GA24656@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>
Cc: phillip.wood@dunelm.org.uk, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Tue, Oct 23, 2012 at 12:17:51PM +0200, Borislav Petkov wrote:
> On Tue, Oct 23, 2012 at 11:05:49AM +0100, Alan Cox wrote:
> > > So yes, blacklisting it and verifying that your system still operates
> > > normally would be something to do. If it does, you could also build a
> > > kernel with pata_acpi disabled (that is, provided you build your own
> > > kernels).
> > 
> > The crash is still a bug. It needs chasing down.
> 
> Yes, ata_timing_find_mode gives NULL, we found that out.
> 
> Anton, Phillip, anyone willing to run this hunk below and get us the
> output:
> 
> ---
> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> index 09723b76beac..80d594d6e7c8 100644
> --- a/drivers/ata/pata_acpi.c
> +++ b/drivers/ata/pata_acpi.c
> @@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  
>  	/* Now stuff the nS values into the structure */
>  	t = ata_timing_find_mode(adev->dma_mode);
> +	if (!t) {
> +		pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
> +		       __func__, adev->dma_mode);
> +
> +		return;
> +	}
> +
>  	if (adev->dma_mode >= XFER_UDMA_0) {
>  		acpi->gtm.drive[unit].dma = t->udma;
>  		acpi->gtm.flags |= (1 << (2 * unit));
> --

Ok, here's the output from Anton's box
(https://bugzilla.kernel.org/show_bug.cgi?id=49151#c16):

pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

And in that case we should've matched XFER_PIO_SLOW but it is commented
out for some reason.

Judging by 70cd071e4ecc06c985189665af75c108601fd5a3, I think we should
involve Tejun into this.

@Tejun: so basically there are two people with oopses when using
pata_acpi because pacpi_set_dmamode queries xfer mode with
adev->dma_mode = 0x0 and ata_timing_find_mode returns NULL (presumably a
BIOS bug, I'd say).

More details if you follow the thread here:
http://marc.info/?l=linux-ide&m=135073445731432

I don't know how to fix this since if BIOS gives xfer_mode 0, how can
each pata controller find its max mode? Sure, we can always fall back to
0x0 but that is the slowest and not necessarily optimal.

One other possibility could be to load chipset-specific drivers first
and pata_acpi only as a last resort but I don't know whether this is
doable at all.

Thanks.

-- 
Regards/Gruss,
Boris.
