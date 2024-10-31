Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EEF7483
	for <linux-ide@vger.kernel.org>; Thu, 31 Oct 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383667; cv=none; b=GMXCw2Ip1PrK++F6kqUgiCEhiT3Tb9aDgB+WKrsxVCmdhXYNB3KWu4gsFTF2XIq7M3NpmTJw4IvLE+4pFLH9ul8cy0yGworTqo6iL0FtTOlZ18mg3AxLJ/A1xNbI5kVSOijJ7xREaJNel2Ay5TwRslCkJm/RejRAdEmcZcA0iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383667; c=relaxed/simple;
	bh=3PPuCyi/R1tgTyEIL++gAaFxVEpQcE9DJ41plQlag40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaTAb1DJe4s1lQQxnnZeD5wTXow+x4HPVAXC8zp+ZAw7+RLYgOWFde3g+SoqpaEm/pfihi14w7d+aPfrrGd1/+jE1BeYOZLDn3R/0wahO4imRt7i8MYIvtESNhhZj4907IKc8mueecCLR1cKc381SO4Uv8/dMxhlnVimtbz5dVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlxevHWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlxevHWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009ECC4CED3;
	Thu, 31 Oct 2024 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383667;
	bh=3PPuCyi/R1tgTyEIL++gAaFxVEpQcE9DJ41plQlag40=;
	h=From:To:Cc:Subject:Date:From;
	b=HlxevHWszQx4Bj4tiCWdVmaJr/WKwhyvFJ1KUR6tEVZVzirLCywxxcwqWpJCMwELq
	 TXmlSJqdfU2FaTwr1RV7xhtqFue8Mivkn8IgOja+a0wUIbEJFLU8LJTX9GcvDFvTOI
	 PEH5W3FWLt78uJBEaGALl7QV8flgQVuPhhyXnCFtUdV6enu/DOVSTefLAEX/gmN9QC
	 YkTRcvCcUr4hDOwn7Vu5rJeCJCyOsVufe3CtHQwm8rei8Yl+rLbiHFCi3wN2mzkU/1
	 d1y4TYbIoXmE6crVyGEAGNYCNMrFeK37wWRlts+5OUWmXWolxqe+2AUHg5nXFyjQBz
	 CnPGLGcrovAmg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Xingui Yang <yangxingui@huawei.com>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/2] Issue non-NCQ command via EH when NCQ commands in-flight
Date: Thu, 31 Oct 2024 15:07:31 +0100
Message-ID: <20241031140731.224589-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=cassel@kernel.org; h=from:subject; bh=3PPuCyi/R1tgTyEIL++gAaFxVEpQcE9DJ41plQlag40=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKV+5WfT/2UGiC2cPruWb0nV9TXb9w7rzJk5bW2de9S5 wku2rGfvaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATyd7HyLBEICnG3zO1qHJm /+K6pOfcHBIHLmsw2nc4JsaUxjTIfWb4K3/737282B3bZV7ovTWynfZy16VwxdsBaQJiS1Ny17/ ZzAYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

There is a problem when an application is continuously submitting NCQ
commands (e.g. fio with a queue depth greater than 1), this can completely
starve out another application that is sending a non-NCQ command (because
the non-NCQ command will be deferred forever).

Xingui Yang reported this problem here:
https://lore.kernel.org/linux-block/eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com/

This series addresses the reported problem.

Please test!


Kind regards,
Niklas


Niklas Cassel (2):
  ata: libata: Introduce new helper ata_qc_complete_success()
  ata: libata: Issue non-NCQ command via EH when NCQ commands in-flight

 drivers/ata/libata-core.c | 274 ++++++++++++++++++++++++++++++--------
 drivers/ata/libata-eh.c   |  60 ++++++++-
 drivers/ata/libata-scsi.c |  16 ++-
 drivers/ata/libata.h      |   1 +
 include/linux/libata.h    |   8 +-
 5 files changed, 297 insertions(+), 62 deletions(-)

-- 
2.47.0

