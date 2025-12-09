Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD91DE4CE
	for <linux-ide@vger.kernel.org>; Tue,  9 Dec 2025 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254245; cv=none; b=G3mjCpHT4r5ISfNYN8BWLpQIMNOyC7dOe8+BjC0V14K1WH2yzieJ+Lx/Gw2k+dJRBI5Qq3HxRXOtoaf//2RaCvsHLnrSWNr3TzvaqVV6gZ+vGgaSW+mTGT+92W2uRnwDCn8XYyC6qnJXUXYaZKcfqAKtV3aAUBVjRedOhIj2FOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254245; c=relaxed/simple;
	bh=f7Qpn/jOMevNe43Is9e9Qe7svjJtoU1Ozpg6ZJxkxXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyjQF1/xN8e89+avE0h/AZA4D2RXW8SMo5uh74tPUNBN4UQRdVKezHVXzFrlLGTR/8zpOwzKqC2KZNgBaAHspio8diHKqaKWn05Qiuw6WzxboLwMrTCxVtEqp19nCNN0y1j64rybm4eYyKGdd8hvf0NcqSclXCrQjT5+HztcZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdjrUtcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdjrUtcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FEDC4CEF5;
	Tue,  9 Dec 2025 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765254244;
	bh=f7Qpn/jOMevNe43Is9e9Qe7svjJtoU1Ozpg6ZJxkxXY=;
	h=From:To:Cc:Subject:Date:From;
	b=QdjrUtcdGVqj6koz0PMcF81zrT1h6iqmbcTpWPT6VQS3sOsFu1eMShDESsYJW6VvZ
	 WbF6dIfB0Skzd+Ir+LA/D5d/9BwX6cd7jdS6AtU8otVEgwu7T0SQRXssvBURZQFykY
	 jqPWmy23wdetbRwblyUEZ7UvzBZh5bSLWXG9eSS9CTIJbF/1HuLxkbSeyHJRGl/lx9
	 0S53tpLlETHxyTL0CCnn/Yj/o7JEHJnWlFUc/wH8E7C9fWwS7y2fNTWhQaWcSiBh1W
	 ulqZErzAtmJZ39uWjbrkeANn1AxL+7hNhgKO9ZP3nDMZz1ipd21cUFh9fRVRlu85H6
	 1m6tRj+gANxnQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
Date: Tue,  9 Dec 2025 05:24:00 +0100
Message-ID: <20251209042359.1467124-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=cassel@kernel.org; h=from:subject; bh=f7Qpn/jOMevNe43Is9e9Qe7svjJtoU1Ozpg6ZJxkxXY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLNl8QXXquad3+Lw/nLggnveC0f9Vg9kMi869E2fxdX2 vRtrHJcHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIMhcjw2mzu3cZDltJtc0t bV8RyHJ5Rfi+t90rxPbfsvt4I7Bp0iOG/xE3fqs+P6qeEt4zISh34bXVQfLPCl9d280S3pXhdcR bmhcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

According to a user report, the ST2000DM008-2FR102 has problems with LPM.

Reported-by: Emerson Pinter <e@pinter.dev>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b96105481784..94c0e0ff981f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4187,6 +4187,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_NOLPM },
 	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
 
+	/* ST disks with LPM issues */
+	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
+
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_QUIRK_NONCQ },

base-commit: a26a0b4b48e181ff5ff340f9dc83612c74f2ccad
-- 
2.52.0

