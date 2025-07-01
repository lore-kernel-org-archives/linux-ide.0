Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668C2741A0
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374537; cv=none; b=fDDC9/QQxbWFTzkcWK32VweXo3a8+GliH2xrsUCxvaXV/5p9Gmu3pRVBJl+cCLcdmOfNVLnOqmNEQT7IIR8ZK/HILOFIgAwpcOokN8mJO9ju9PVB1crVAxVuFGIMDEqkM3sci035ZNlNPEvoz/cG69JTjjGtgxuDlo5u9jSnUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374537; c=relaxed/simple;
	bh=HLzU8No+PN34LzuzZVRCVWig0vqg5SvqTVXUSEwgfWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWzcUtar2z8RSlaysY1Ba50tlAtzg8qzut5Mb+zf74KVIlTfAobuFC7dpkYCn40FBgiul2VficTKVgGZc8CLBrUmNYgVSbnmXU+IIEnoD6FgxHOO6WQhmv0kKQHbIy2iWeINxdmZcwofSblSsjxiElYEiRBXt8g9TzKXH/Ef9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ5l/YuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ5l/YuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A435FC4CEEF;
	Tue,  1 Jul 2025 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374536;
	bh=HLzU8No+PN34LzuzZVRCVWig0vqg5SvqTVXUSEwgfWI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hQ5l/YuU7DkJhvkXsCQ0Tc2ATxxHy/YGsJRlzwrdI8+m8H8BALDN964GDevwtlq+O
	 m3Y/6bfm0tHhsEcPqKL+U0vZ/tgiXddPBTZuldtYgWpqdAbNiObVYPo/oqYadiAX48
	 1Rr7j8cNMBE/qLc1plxG7mPlCh+oICu6OmXCGII5jyu8hLgv/h+omCYFhkLKi5eNwm
	 KavZAmDixwXoOca8N2rcJhV+y2/NNZAae/LlSREXWIPpwSO064xishCXaOS9slJjAZ
	 QAzSiHS58sb2MqD5wvjEOsJiY2WHVhtwpfcxrurNeVpuYOdSgU8ghCQ8TRLnd/gcnt
	 Y/cu6Pwsm/I7g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 05/10] ata: libata-sata: Disallow changing LPM state if not supported
Date: Tue,  1 Jul 2025 21:53:16 +0900
Message-ID: <20250701125321.69496-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701125321.69496-1-dlemoal@kernel.org>
References: <20250701125321.69496-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify ata_scsi_lpm_store() to return an error if a user attempts to set
a link power management policy for a port that does not support LPM,
that is, ports flagged with ATA_FLAG_NO_LPM.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index cb46ce276bb1..47169c469f43 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -924,6 +924,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	spin_lock_irqsave(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_NO_LPM) {
+		count = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
 			if (dev->quirks & ATA_QUIRK_NOLPM) {
-- 
2.50.0

