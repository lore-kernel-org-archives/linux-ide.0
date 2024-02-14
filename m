Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A052F6E
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915672; cv=none; b=YciCsSx7KStXixGjJFG3JUqPJ0yKtSWIqmQlPKknF14tnsslJqXhQ6TlF5FR/lj8FJatEDemx8nPd5YGJs8F5Hc7k25L3FYKkGCjzV9F/8YjKomMXw9isHD7MZTHfpzHBcqvtKRmP4JLxc/r12CLO9fm1pADkA+kZA6wYQqjJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915672; c=relaxed/simple;
	bh=EnEDgigg8PH6aauZCL0C5X3HvdP0FXovOKM1bIJPEFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvdGkKcU0fsIPjrPUNQ1JpgmT6Wf5vjWCzbVWCbmYyEfVNw0AKVH/3FQqlI8S8BbIPWZgVvEZ/4hcrZqIwUljHWe+RAQCQxdxh77PYq9rg4SKXohvL+gxSwGQLkFjYD6+4PXrkD6o5FURtT6xeb3pD9oQ8eIpF8qtdPS+OOWMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOPFFLlI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOPFFLlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC77C433F1;
	Wed, 14 Feb 2024 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915672;
	bh=EnEDgigg8PH6aauZCL0C5X3HvdP0FXovOKM1bIJPEFc=;
	h=From:To:Cc:Subject:Date:From;
	b=tOPFFLlILhtZALHi7mHmkyyb22hs9rIc86BqtxjcGeryzESCCXdBQTUObpfgQon3Z
	 DU9vJJRgItc2yOsLzs4JVJYAoCWOB6C3cGqbz1zbgaYvCGhv9nx0AnrgsnyWMwgEFu
	 EoA0kaJcYfbMPGJyJrAAlpnj7/HQgzjrIJE1vt3ZzsoHyLgiGm2IwpjtY1mBJ2tyyE
	 ujhfaZ9eIh8v3uWPTka1ZUmVhIxi4YLZj6/yjdxb4IX/nGK4RjF0Zw+X0cWkc0RzZL
	 6tYMfi55sUp+6u4myNj0UqpQTR58ZmHm+5/DD8lgM+Y2GW2zjXErWd2mK9atjjQ7j1
	 UQLHn3Ee61xHQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2 0/4] ahci minor quirk cleanups
Date: Wed, 14 Feb 2024 14:00:08 +0100
Message-ID: <20240214130015.952685-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some minor AHCI quirk cleanups.

Kind regards,
Niklas


Changes since V1:
-Renamed boards to start with board_ahci_pcs_quirk_* as suggested by
 Damien.
-Moved the entries futher down to keep them alphabetically with the new
 names.
-Changed the order of the HFLAGS for the boards to match the new names.
-Added underscore in _no_sntf to make the name more clear and to match
 board_ahci_no_debounce_delay.
-Added new patches 3/4 and patch 4/4.
-Dropped Reviewed-by tags because of too many changes.


Niklas Cassel (4):
  ahci: rename board_ahci_nosntf
  ahci: clean up ahci_broken_devslp quirk
  ahci: drop unused board_ahci_noncq
  ahci: rename board_ahci_nomsi

 drivers/ata/ahci.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

-- 
2.43.0

