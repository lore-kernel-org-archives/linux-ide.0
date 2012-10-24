From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 10:52:56 +0000 (UTC)
Message-ID: <20121024105256.71A8511FC6B@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49668 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758120Ab2JXKxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 06:53:01 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F313A20290
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 10:52:59 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id DE7AD202B5
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 10:52:57 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #25 from Alan <alan@lxorguk.ukuu.org.uk>  2012-10-24 10:52:56 ---
On Wed, 24 Oct 2012 10:28:42 +0100
Phillip Wood <phillip.wood@talktalk.net> wrote:

> On 10/23/2012 11:17 AM, Borislav Petkov wrote:
> > ---
> > diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> > index 09723b76beac..80d594d6e7c8 100644
> > --- a/drivers/ata/pata_acpi.c
> > +++ b/drivers/ata/pata_acpi.c
> > @@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
> >
> >   	/* Now stuff the nS values into the structure */
> >   	t = ata_timing_find_mode(adev->dma_mode);
> > +	if (!t) {
> > +		pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
> > +		       __func__, adev->dma_mode);
> > +
> > +		return;
> > +	}
> > +
> >   	if (adev->dma_mode >= XFER_UDMA_0) {
> >   		acpi->gtm.drive[unit].dma = t->udma;
> >   		acpi->gtm.flags |= (1 << (2 * unit));
> > --
> 
> pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

Which is an ATA layer bug - adev->dma_mode should never be called without
a DMA mode in normal use.

> as well here if I build pata_acpi as a module, if I build it into the 
> kernel I don't get any message.

If you build the drivers into the kernel the link order ensures the
generic drivers execute last so the native driver will already have been
used. When loading modules it is expected that the distribution is smart
enough to get this right.

So the built in case is covering up the failure case because the code
never gets executed,

 Alan

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.