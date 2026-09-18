Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBA42E40C
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735247; cv=none; b=paGQmGpElqR9ELjvYuqoEUJ6eiRwCA0Rpvnt+Jgxvnawk14F2d4kRvQszQMY5UlUuTYIzhC4EsKe9BXbxNxT+lPkblYUrPwuPHh57DwdatJmU7FukKvf41fI06B4oIgKjFPPKOkzRYc8S3Y1tfh8TL8lgxEZlhIeL+M2hTuIE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735247; c=relaxed/simple;
	bh=DgSHhlBiaR5+cNGdeQtl3IHXRFmHQaxu+3k9kBQ+M1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXXVvN7kmSbZ0n9ZkVBwb6latXElY8GqkDAv3HAXkSAXbSUF508ijqUx2sdf1ngurfTuqOK6F7ZFJK8zgGche0kEKJ7t1Hz7/fROZl4jVDB6rV35h9qLWW0SEjv44GRwp6jE9+lO4C0lX9ax8Mij7YmN3ZGauZ2wW3DRxBVVOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqoQpZGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqoQpZGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC241F000FF;
	Fri, 18 Sep 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735244;
	bh=Lf4Q7XgiignLL80fpQHdnOIw+MyFh5LaMKArvAbS0Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AqoQpZGzFitr0bq2uotB5FzUVlXvj7UDQfF4VxYw4CLx57QqAqj8qqtvtzVmjsRkw
	 /0+/f0txJbAe2jGrCiId/suC0sRfi95gymyEO5QlDEAHs/3e/AYl2wh/NUFlx3RuwQ
	 2nDf2wRRdcN8Oyz5XyJKoxYBOgGl/hYHs15H7gqfWmsL0JiOXj/KjtBcb6DKglzcRT
	 zK8EqX1boIu3Wk881AFrC/vqJX9bwFKqM8vtVieXzhmMldSTTe4NLJwlJICcC9CDUi
	 legh3moTKtGJcTBX5XR5Wd4Wb8HRSadvcixZ7bIwrh2cFIDUsLGGHcR+mvAFfqxVg+
	 DrLkbNPkRyriw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	grandmastertriplej@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] ata: libata: Correct libata.force parameter documentation
Date: Fri, 18 Sep 2026 14:40:33 +0200
Message-ID: <20260918124030.1962773-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918124030.1962773-4-cassel@kernel.org>
References: <20260918124030.1962773-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=cassel@kernel.org; h=from:subject; bh=DgSHhlBiaR5+cNGdeQtl3IHXRFmHQaxu+3k9kBQ+M1M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLWGto/erZb1mueuHXJm/D+cLXErOAFW9vbjP/lx4g1c jl5v/7fUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIlE+DD80whV38d6pIr1onXO 7DR93k6D7VpfPxpxnZQwf+ie0Zf6keGfsa72bZbqy0e/eRUqL6rYxF6gdOW5p5f2YvMPu89bP7v BBAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Align the documented libata.force options with their implementation.
The force table accepts PIO modes 0 through 6, not mode 7, and ncqati
controls NCQ generally rather than only queued TRIM.

The max_sec_1024 and max_sec_lba48 options only set transfer size
limits. Remove the misleading claim that they can also clear them.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..24459f7ff810 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3491,7 +3491,7 @@ Kernel parameters
 
 			* SATA link speed limit: 1.5Gbps or 3.0Gbps.
 
-			* Transfer mode: pio[0-7], mwdma[0-4] and udma[0-7].
+			* Transfer mode: pio[0-6], mwdma[0-4] and udma[0-7].
 			  udma[/][16,25,33,44,66,100,133] notation is also
 			  allowed.
 
@@ -3509,7 +3509,7 @@ Kernel parameters
 
 			* [no]ncqtrim: Enable or disable queued DSM TRIM.
 
-			* [no]ncqati: Enable or disable NCQ trim on ATI chipset.
+			* [no]ncqati: Enable or disable NCQ on ATI chipsets.
 
 			* [no]trim: Enable or disable (unqueued) TRIM.
 
@@ -3540,11 +3540,9 @@ Kernel parameters
 
 			* max_sec_128: Set transfer size limit to 128 sectors.
 
-			* max_sec_1024: Set or clear transfer size limit to
-			  1024 sectors.
+			* max_sec_1024: Set transfer size limit to 1024 sectors.
 
-			* max_sec_lba48: Set or clear transfer size limit to
-			  65535 sectors.
+			* max_sec_lba48: Set transfer size limit to 65535 sectors.
 
 			* external: Mark port as external (hotplug-capable).
 
-- 
2.55.0

