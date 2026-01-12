Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1991E4AF
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220458; cv=none; b=ttXJZLI2DvERbW/SKcvLvh3bQkFceCqP7XYflwGWvbUpl6NMyZsTLqBmrbSEEhxcgR3VfVltxP84+QB9zUGSetxh/KSUJsriTkEpNt5+k6iWrLiFnN4ZypkbPK1C+b1DfjtcoZpMmS7EVEXFGfdvG5bEA4MPHDE6zil33gXt69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220458; c=relaxed/simple;
	bh=Jo4rZONMkkx3DA2HP/uJb3wt2MkONkO2zVHFIhfTxrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKN61Aq5v6TzNEKkBdbRKfmqV2SwbfkX0VN6eHHTxXao2cdkCVDve2MVZclYCpxvEmm4Du0dmFzYLR5TNeN9IL1lgaMACplwgSCcH+K+9PUmwX81WgusAigP02wkzyLxsufVLw2kjLR3XPtTh6xCp7TZu+3IFK3z4kd/egIZhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KppJcQLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KppJcQLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADCDC16AAE;
	Mon, 12 Jan 2026 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220458;
	bh=Jo4rZONMkkx3DA2HP/uJb3wt2MkONkO2zVHFIhfTxrg=;
	h=From:To:Cc:Subject:Date:From;
	b=KppJcQLmUMtjLqc1AGsCw1EZXQtZYXVkYMP78cGRGnLqbDVuqP5xnAt0TNvPf54j+
	 cVp/X3NKwGJKt4h+r5/dMM6MrPJP7IoPImk2RCbUJu5DYrPhGv9RpelzdT8c8ZbvyH
	 1YYv9s2MB8YQhY7pFnDsQ4xfYsMAVrHlC+CVIBTkyoSce7EGXsZpJHQYll7Kc4uH9w
	 8DI9Jh7d2OMyGUAQ+xnCcA6m7Ki5FLdrJlDjpnaPNnA0y4NFxhzq3vIClLsyse1v7c
	 d8fpnkBZdy8Fgvv3OknFCxIUlmFpUxKpoSeDhQwD9hSAfp2jI1VK73z2LtWbIXqMF3
	 A6fNlWcC4n9ig==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/6] misc LPM related fixes
Date: Mon, 12 Jan 2026 13:20:45 +0100
Message-ID: <20260112122044.143637-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=cassel@kernel.org; h=from:subject; bh=Jo4rZONMkkx3DA2HP/uJb3wt2MkONkO2zVHFIhfTxrg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTnsuwZP6weH9CROmy4+ENPAuKtK83bWhfbFgeWv295 tWVL6pdHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIoCwjw8a2NCu7zmQfr6CS 5DkmFjrXQsW3P9Ovz6vx60m5+rlZiJHh567c+In8vs0FYk8yU15fmRG1VPRySauAxptl5i23c4V YAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

we had a recent bug report on the mailing list related to LPM, which made
me review the LPM related code.

While doing so, I found some issues. This series fixes those issues.

The most serious issue is that ATA_QUIRK_NOLPM was not getting applied for
ATAPI devices and that we read the per port area for unimplemented ports,
even though the AHCI specification explicitly forbids this.


Kind regards,
Niklas


Changes since v1:
-Fixed typos in commit messages
-Split early return patch into two, so that they only have a single
 Fixes-tag each.
-Reordered patches to make it easier to only apply the important ones
 for the current v6.19 kernel.


Niklas Cassel (6):
  ata: ahci: Do not read the per port area for unimplemented ports
  ata: libata: Call ata_dev_config_lpm() for ATAPI devices
  ata: libata-sata: Improve link_power_management_supported sysfs
    attribute
  ata: libata: Add cpr_log to ata_dev_print_features() early return
  ata: libata: Add DIPM and HIPM to ata_dev_print_features() early
    return
  ata: libata: Print features also for ATAPI devices

 drivers/ata/ahci.c        | 10 +++++-----
 drivers/ata/libata-core.c |  8 +++++++-
 drivers/ata/libata-sata.c |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)


base-commit: 97e01439e902b743b8f89497e9c144e3ddda5e59
-- 
2.52.0

