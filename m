Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052035E529
	for <linux-ide@vger.kernel.org>; Fri,  9 Jan 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969597; cv=none; b=gFPjo5QITpyARDAk/VRmekeN5DcXRPyzn+XymUvsgHCpL5BYntivI0tkfr85BYaFLEPCtzIzNLcswYO4Tx7HbHcwoRRMlbmcSIm9vHtbs7vxiZ6tPj6n11yQ2GpdG0L2OBFgkLA7QIeXmgqj06Y4VwSS98IyklWOx7hkbsM4U/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969597; c=relaxed/simple;
	bh=5/3OP+ix89CLRZwf7Md2zyLzTujceBSBP7WjdbVAJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8zKb4h3LiP3nLusZwlw/dkEu2ExW5m2rp1DUjWuztzqHcqlf3i4STQChZwe003ozvkNqskMvAA7nHMByjKqcBVaQYH5gZYot+sTHzN9FAJ1pX33cFhaH6gdONwGOey8AO1F7suOgTpFW30UUPcXRfjfdcOl8yNhbuGc/P4104I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqMnQGkz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqMnQGkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ADCC4CEF1;
	Fri,  9 Jan 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969596;
	bh=5/3OP+ix89CLRZwf7Md2zyLzTujceBSBP7WjdbVAJqY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqMnQGkzJK7WdRN6IxsGnW3NXPh1UcXSjmIUWmySYrwubkfCNYoUOaRigTY3ZZa3o
	 etPo75ElShrIBokt9K8MQ5lqa4qe+e4wlgnHrOpbrEXao+UuC/N8XrThZLcppFdXIV
	 TXbuVTYSuGOOA+aJ6OG4NaFuIqi0hk1I4pzGEf7hjF83HchogS/Qhxu5yoZQYwmHUh
	 oodql1k0vFguDi7XH0FyfMScPZz/ldEOPN95ggORIehKvCZAJyfFPnZTQp3ovo2jev
	 5HeWgX2qaKTL3AOKBUV22gPJKMnzmA2K7SXo1GziKluwgYtSIkXZ+3HWXJhZvqbmo3
	 3CTlTKWJwHllg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/5] misc LPM related fixes
Date: Fri,  9 Jan 2026 15:39:50 +0100
Message-ID: <20260109143949.331105-7-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=cassel@kernel.org; h=from:subject; bh=5/3OP+ix89CLRZwf7Md2zyLzTujceBSBP7WjdbVAJqY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIThU11TtTk3bF271RQmLQ5+jHrkjs2erLOwYszhHwCj jBfvpzZUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImIX2f4n84UfHj50lIJ65vx WVZX5t07eztEfqb1OkEGzjmWRgULnzP8d2iN3M5f277fTHNPpufepPSOnx92MU/ljM44ab/SZfo KZgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

we had a recent bug report on the mailing list related to LPM,
which made me review the LPM related code.

While doing so, I found some issues. This series fixes those issues.

The most serious issue is that ATA_QUIRK_NOLPM was not getting
applied for ATAPI devices.


Kind regards,
Niklas


Niklas Cassel (5):
  ata: libata: Call ata_dev_config_lpm() for ATAPI devices
  ata: libata: Fix ata_dev_print_features() early return
  ata: libata: Print features also for ATAPI devices
  ata: libata-sata: Improve link_power_management_supported sysfs
    attribute
  ata: ahci: Do not read per port area for unimplemented ports

 drivers/ata/ahci.c        | 10 +++++-----
 drivers/ata/libata-core.c |  8 +++++++-
 drivers/ata/libata-sata.c |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)


base-commit: 97e01439e902b743b8f89497e9c144e3ddda5e59
-- 
2.52.0

