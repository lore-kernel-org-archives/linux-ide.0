From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Mon, 29 Jun 2009 19:20:18 +0900
Message-ID: <4A489562.8080404@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>	 <1244746872.3998.88.camel@mulgrave.site>	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>	 <4A3B0D49.8070802@gmail.com>	 <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>	 <4A3CD738.1080105@gmail.com> <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030104060606010002030204"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:64641 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879AbZF2KUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 06:20:22 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1239662rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2009 03:20:24 -0700 (PDT)
In-Reply-To: <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030104060606010002030204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marc Bowes wrote:
> Ok. Just keep me informed :)

Please test the attached patch and report the resulting boot log.  Oh
and please turn on CONFIG_PRINTK_TIME.

Thanks.

-- 
tejun

--------------030104060606010002030204
Content-Type: text/x-patch;
 name="gigabyte-unreliable-online.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gigabyte-unreliable-online.patch"

 drivers/ata/ahci.c      |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c |   15 +++++++++++----
 include/linux/libata.h  |    1 +
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2141a31..58cf5f7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2677,6 +2677,48 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 	return !ver || strcmp(ver, dmi->driver_data) < 0;
 }
 
+static bool ahci_broken_online(struct pci_dev *pdev)
+{
+#define ENCODE_BUSDEVFN(bus, slot, func)			\
+	(void *)(unsigned long)(((bus) << 8) | PCI_DEVFN((slot), (func)))
+	static const struct dmi_system_id sysids[] = {
+		/*
+		 * There are several gigabyte boards which use
+		 * SIMG5723s configured as hardware RAID.  Certain
+		 * 5723 firmware revisions shipped there keep the link
+		 * online but fail to answer properly to SRST or
+		 * IDENTIFY when no device is attached downstream
+		 * causing libata to retry quite a few times leading
+		 * to excessive detection delay.
+		 *
+		 * As these firmwares respond to the second reset try
+		 * with invalid device signature, considering unknown
+		 * sig as offline works around the problem acceptably.
+		 */
+		{
+			.ident = "EP45-DQ6",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "Gigabyte Technology Co., Ltd."),
+				DMI_MATCH(DMI_BOARD_NAME,
+					  "EP45-DQ6"),
+			},
+			.driver_data = ENCODE_BUSDEVFN(0x0a, 0x00, 0),
+		},
+		{ }	/* terminate list */
+	};
+#undef ENCODE_BUSDEVFN
+	const struct dmi_system_id *dmi = dmi_first_match(sysids);
+	unsigned int val;
+
+	if (!dmi)
+		return false;
+
+	val = (unsigned long)dmi->driver_data;
+
+	return pdev->bus->number == (val >> 8) && pdev->devfn == (val & 0xff);
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2788,6 +2830,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   "BIOS update required for suspend/resume\n");
 	}
 
+	if (ahci_broken_online(pdev)) {
+		pi.link_flags |= ATA_LFLAG_UNK_IS_OFFLINE;
+		dev_info(&pdev->dev,
+			 "online status unreliable, applying workaround\n");
+	}
+
 	/* CAP.NP sometimes indicate the index of the last enabled
 	 * port, at other times, that of the last possible port, so
 	 * determining the maximum port number requires looking at
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 94919ad..cfc98c3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2595,16 +2595,23 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	if (classify && nr_unknown) {
-		if (try < max_tries) {
+		bool unk_is_offline = link->flags & ATA_LFLAG_UNK_IS_OFFLINE;
+
+		if (!unk_is_offline && try < max_tries) {
 			ata_link_printk(link, KERN_WARNING, "link online but "
 				       "device misclassified, retrying\n");
 			failed_link = link;
 			rc = -EAGAIN;
 			goto fail;
 		}
-		ata_link_printk(link, KERN_WARNING,
-			       "link online but device misclassified, "
-			       "device detection might fail\n");
+		if (unk_is_offline)
+			ata_link_printk(link, KERN_INFO,
+					"link online but device misclassified, "
+					"treating as offline\n");
+		else
+			ata_link_printk(link, KERN_WARNING,
+					"link online but device misclassified, "
+					"device detection might fail\n");
 	}
 
 	/* reset successful, schedule revalidation */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d501db..934e805 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -172,6 +172,7 @@ enum {
 	ATA_LFLAG_NO_RETRY	= (1 << 5), /* don't retry this link */
 	ATA_LFLAG_DISABLED	= (1 << 6), /* link is disabled */
 	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
+	ATA_LFLAG_UNK_IS_OFFLINE = (1 << 8), /* treat unknown sig as offline */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */

--------------030104060606010002030204--
