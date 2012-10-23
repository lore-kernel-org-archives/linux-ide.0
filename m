From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 10:17:54 +0000 (UTC)
Message-ID: <20121023101754.91A7111FB3D@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34854 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab2JWKSD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 06:18:03 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 470BF2034C
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 10:17:58 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id E1A9420346
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 10:17:56 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #14 from Borislav Petkov <bp@alien8.de>  2012-10-23 10:17:54 ---
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
@@ -144,6 +144,13 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct
ata_device *adev)

     /* Now stuff the nS values into the structure */
     t = ata_timing_find_mode(adev->dma_mode);
+    if (!t) {
+        pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
+               __func__, adev->dma_mode);
+
+        return;
+    }
+
     if (adev->dma_mode >= XFER_UDMA_0) {
         acpi->gtm.drive[unit].dma = t->udma;
         acpi->gtm.flags |= (1 << (2 * unit));
--

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
