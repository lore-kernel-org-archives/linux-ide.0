From: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Sun, 27 Aug 2017 19:03:48 +0200
Message-ID: <20170827170348.GA22437@lst.de>
References: <20170824112932.GA12461@shredder.mtl.com> <20170824120728.GA23186@lst.de> <20170824121804.GA14057@shredder.mtl.com> <20170826171537.GA4755@shredder> <20170827090546.GA16766@lst.de> <20170827105331.GA18386@shredder.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34834 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdH0RDt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Aug 2017 13:03:49 -0400
Content-Disposition: inline
In-Reply-To: <20170827105331.GA18386@shredder.mtl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ido Schimmel <idosch@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

Does this make your boot issue go away?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fa7dd4394c02..697f5f896b19 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2079,6 +2079,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 	 */
 	if (ap_flags & ATA_FLAG_NO_LOG_PAGE)
 		return AC_ERR_DEV;
+	if (dev->horkage & ATA_HORKAGE_NO_LOG_PAGE)
+		return AC_ERR_DEV;
 
 retry:
 	ata_tf_init(dev, &tf);
@@ -4578,6 +4580,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "WDC WD3000JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 	{ "WDC WD3200JD-*",		NULL,	ATA_HORKAGE_WD_BROKEN_LPM },
 
+
+	{ "M.2 (S42) 3ME3",		NULL,	ATA_HORKAGE_NO_LOG_PAGE },
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 931c32f1f18d..9e927ae7fced 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -438,6 +438,7 @@ enum {
 	ATA_HORKAGE_NO_DMA_LOG	= (1 << 23),	/* don't use DMA for log read */
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
+	ATA_HORKAGE_NO_LOG_PAGE = (1 << 26),	/* Doesn't like Get Log Page */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
