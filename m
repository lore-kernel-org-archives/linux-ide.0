Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783422616
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721963999; cv=none; b=cxI7I3uoeCgdb/J/vGcWgG2+VKHlFX2/yMeSL6eLk2ryzEPsYciS92i7bOVjzT4pqGxTVsAuXwDidMKKAQFZTfA1dKgwEuI5oEPuOCK7oIqXN4C7uYR4NZUB3NVnCPqU7J12ibvjQy27PrtoJLeV50fSgezP2LhsovGiX9j5xC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721963999; c=relaxed/simple;
	bh=TScLt22oYdKRSkiSCnXRbD6Ky2xgpYuimsg94LRYr/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7R5ONGYHA3+Sj3GGkRxRpCZ1Z/szfyDK8ThHw6LWUJNWq4n5tUUW38/AgzZJhfYi6/yxYr+0Wrekovc7qY45krBvxUMYl1rgPwGwPQr9IGgV9UH5ydBxOYpMyB8BhuWetwC4Gj2gdOwzGw000/7MJbzJ9NmSRpwkK7SJyJIiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdWSIDEJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdWSIDEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A07C4AF0C;
	Fri, 26 Jul 2024 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721963999;
	bh=TScLt22oYdKRSkiSCnXRbD6Ky2xgpYuimsg94LRYr/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LdWSIDEJGvUZhzs3TaJZpPB808JtGTcLJsdv7qPMv4ZmG/e7OtlT+gobzM4SWQ9qj
	 5qBReIGmefcuhBlKgTYcJ1CiDFQd030qY5Q7Z63H+u98gVd5PfzUa+YxFcpXoms+kU
	 yekCXG+8+HBW5XjQi34RmcjHeUmfNXPwUHb+vsrhtjnOb3kxZcvPqcrfsAMwT80t87
	 uqvmbcvYGAuDAA1VtSzjArvqWqBSI4v0cAPwRVNYNmI9z0Ttba8BWGggyfnm74Hub0
	 fE/vsEk2IUio8Qa3oBx9zIWI4u2/GUW9O3WzU2KcxKThm3tdm6Wg3HajFZ7r0y0IA0
	 uQrqkVf6gYBRQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 05/11] ata: pata_serverworks: Do not use the term blacklist
Date: Fri, 26 Jul 2024 12:19:48 +0900
Message-ID: <20240726031954.566882-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's not use the term blacklist in the function
serverworks_osb4_filter() documentation comment and rather simply refer
to what that function looks at: the list of devices with groken UDMA5.

While at it, also constify the values of the csb_bad_ata100 array.

Of note is that all of this should probably be handled using libata
quirk mechanism but it is unclear if these UDMA5 quirks are specific
to this controller only.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_serverworks.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 549ff24a9823..4edddf6bcc15 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -46,10 +46,11 @@
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
 
-/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
- * can overrun their FIFOs when used with the CSB5 */
-
-static const char *csb_bad_ata100[] = {
+/*
+ * Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5.
+ */
+static const char * const csb_bad_ata100[] = {
 	"ST320011A",
 	"ST340016A",
 	"ST360021A",
@@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
  *	@adev: ATA device
  *	@mask: Mask of proposed modes
  *
- *	Check the blacklist and disable UDMA5 if matched
+ *	Check the list of devices with broken UDMA5 and
+ *	disable UDMA5 if matched.
  */
-
-static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
+static unsigned int serverworks_csb_filter(struct ata_device *adev,
+					   unsigned int mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
-- 
2.45.2

