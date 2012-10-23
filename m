From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 12:17:51 +0200
Message-ID: <20121023101751.GA24656@liondog.tnic>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
 <20121020120047.GC17563@liondog.tnic>
 <50841CFC.2030802@talktalk.net>
 <20121021165756.GA20642@liondog.tnic>
 <50856AA8.1000607@talktalk.net>
 <20121022202734.GA16169@liondog.tnic>
 <20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41878 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2JWKRy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 06:17:54 -0400
Content-Disposition: inline
In-Reply-To: <20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: phillip.wood@dunelm.org.uk, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Tue, Oct 23, 2012 at 11:05:49AM +0100, Alan Cox wrote:
> > So yes, blacklisting it and verifying that your system still operates
> > normally would be something to do. If it does, you could also build a
> > kernel with pata_acpi disabled (that is, provided you build your own
> > kernels).
> 
> The crash is still a bug. It needs chasing down.

Yes, ata_timing_find_mode gives NULL, we found that out.

Anton, Phillip, anyone willing to run this hunk below and get us the
output:

---
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 09723b76beac..80d594d6e7c8 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 
 	/* Now stuff the nS values into the structure */
 	t = ata_timing_find_mode(adev->dma_mode);
+	if (!t) {
+		pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
+		       __func__, adev->dma_mode);
+
+		return;
+	}
+
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		acpi->gtm.drive[unit].dma = t->udma;
 		acpi->gtm.flags |= (1 << (2 * unit));
--

Thanks.

-- 
Regards/Gruss,
    Boris.
