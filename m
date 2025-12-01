Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55E1DC985
	for <linux-ide@vger.kernel.org>; Mon,  1 Dec 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592526; cv=none; b=YOStT5GK0MYcK55+DLHNKLVgH8ug/Setyc3tq47CC73vTzhLdTTflz+7TohX6iuMyAN7UcTjgNUFFfklF4kFdWv3OeJzFCsItUcQEg84v8oV1sSQ1RrahhXtNKB9CWWjXYNhdetIYvpuNY94RSlbvAdRxwAEQjDVSeBbYnodeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592526; c=relaxed/simple;
	bh=r20rXj9am/tzH7W6hnMx8SFzR7O2txQXCpqKvoVeHs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLQDxSbXUcgUUIJ60wgw0PkmOWyszq/c/+shibnw1SPsSGG5iBHt1PbduDmswVtZBE+dj3aJmyvepDnY3ieQeH+V8JuEqT+ugwDlArhfBlPjRlhcYXMnZ7UG2YN09H0uXYM/O1hd3vx9YIqAobTJKa1MEeheBSv49GiXfjHWPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZJMiPcC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZJMiPcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD82C4CEF1;
	Mon,  1 Dec 2025 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592526;
	bh=r20rXj9am/tzH7W6hnMx8SFzR7O2txQXCpqKvoVeHs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZJMiPcCOle5rcNraotewln7rkI4UMeHDabAknGfxgtZ0pFbpffyGvfTAuXv03j6X
	 ZvBHTsqWHXkjpndZwa4VCAGUrHkNXdqARogLkIvS+q5qgoOsS0GrcHXoIUrubAOXqw
	 LTJC26QvoOfigCtVHUm5PjK8TEsI4CIC9HovW1ETFlhufKemR0zPC8NGUU3frj9Qxm
	 mIlz3V/gw8mCifa4NknG1NVqqMflGGKOCNQKJHbsQsX9TAI63Zafvd3PTvPsmjim/O
	 m6qw/UStVdTrVsSi8Q3w0f28MaLj/768AThr/XPjZwCGhHU0j0zHL8JnPprRlTOFGL
	 npLL7vdBlFS0g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	xxjack12xx@gmail.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 7/8] ata: libata: Add libata.force parameter max_sec
Date: Mon,  1 Dec 2025 13:35:09 +0100
Message-ID: <20251201123501.246282-17-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201123501.246282-10-cassel@kernel.org>
References: <20251201123501.246282-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=cassel@kernel.org; h=from:subject; bh=r20rXj9am/tzH7W6hnMx8SFzR7O2txQXCpqKvoVeHs4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ1u6sN7zx+s16V6+3Jm+HqrYe6urRk3Cc92zPzs47K1 a6Y/CjZjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykuYiR4dspk6DbBS5X1R/t yTuu7BkynZ1VedLcZXIqLzdve/KqzpeRYX/1L0Oz7WECbr1RancOT1X/6jjH8+PEjXVx7BEJpQI OzAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a new libata.force parameter called max_sec.

The parameter can take an arbitrary value using the format:
libata.force=max_sec=<param_value>

e.g. libata.force=max_sec=8191
or
libata.force=max_sec=2048

This will allow the user to set an arbitrary max_sectors value using
libata.force.

We cannot remove the existing libata.force parameters "max_sec_128" and
"max_sec_1024", as these are a part of the exising user facing API.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 drivers/ata/libata-core.c                       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e5..c5464b11a2ad5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3294,6 +3294,10 @@
 			* [no]logdir: Enable or disable access to the general
 			  purpose log directory.
 
+			* max_sec=<sectors>: Set the transfer size limit, in
+			  sectors, to the value specified in <sectors>. The
+			  value specified in <sectors> has to be an integer.
+
 			* max_sec_128: Set transfer size limit to 128 sectors.
 
 			* max_sec_1024: Set or clear transfer size limit to
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7f59eca2a65be..c122a8aa27688 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6540,6 +6540,7 @@ static const struct ata_force_param force_tbl[] __initconst = {
 
 	force_quirk_val(max_sec_128,	ATA_QUIRK_MAX_SEC,	128),
 	force_quirk_val(max_sec_1024,	ATA_QUIRK_MAX_SEC,	1024),
+	force_quirk_on(max_sec=,	ATA_QUIRK_MAX_SEC),
 	force_quirk_on(max_sec_lba48,	ATA_QUIRK_MAX_SEC_LBA48),
 
 	force_quirk_onoff(lpm,		ATA_QUIRK_NOLPM),
-- 
2.52.0

