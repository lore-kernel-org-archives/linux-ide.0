From: Chuck Ebbert <cebbert@redhat.com>
Subject: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA controller
Date: Thu, 28 Jun 2007 15:47:46 -0400
Message-ID: <46841062.2080800@redhat.com>
References: <468408F1.3080307@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030707090704060502000603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756624AbXF1Try (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 15:47:54 -0400
In-Reply-To: <468408F1.3080307@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jason Gaston <jason.d.gaston@intel.com>

This is a multi-part message in MIME format.
--------------030707090704060502000603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 06/28/2007 03:16 PM, Chuck Ebbert wrote:

[Forgot to mark subj: as a patch; attached]

> From: Christian Lamparter <chunkeey@web.de>
> 
> ATA: add a PCI ID for Intel Santa Rosa PATA controller.
> 
> Signed-off-by: Christian Lamparter <chunkeey@web.de>
> ---
> 
> [against 2.6.22-rc6; patch also attached, use the attachment]
> 
>  drivers/ata/ata_piix.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 9c07b88..b210726 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -200,6 +200,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
>         /* ICH7/7-R (i945, i975) UDMA 100*/
>         { 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
>         { 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
> +       /* ICH8 Mobile PATA Controller */
> +       { 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
> 
>         /* NOTE: The following PCI ids must be kept in sync with the
>          * list in drivers/pci/quirks.c.

--------------030707090704060502000603
Content-Type: text/plain;
 name="ich8m-add-pciid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ich8m-add-pciid.patch"

From: Christian Lamparter <chunkeey@web.de>

ATA: add a PCI ID for Intel Santa Rosa PATA controller.

Signed-off-by: Christian Lamparter <chunkeey@web.de>
---
 drivers/ata/ata_piix.c |    2 ++
 1 file changed, 2 insertions(+) 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9c07b88..b210726 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -200,6 +200,8 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* ICH7/7-R (i945, i975) UDMA 100*/
 	{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 	{ 0x8086, 0x269E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_100 },
+	/* ICH8 Mobile PATA Controller */
+	{ 0x8086, 0x2850, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich_pata_133 },
 
 	/* NOTE: The following PCI ids must be kept in sync with the
 	 * list in drivers/pci/quirks.c.

--------------030707090704060502000603--
