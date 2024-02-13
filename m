Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441E4EB35
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829660; cv=none; b=UO0b2XB+dZJ62Jk8D6hofvumJtX/GOlc0i6yjtNHAoirsV1UYNCp7pONrRSoaGKw0zA2ar4seX0+DTevkQmiUUNOVOdRwSvuOvLkGHMI6zHYsXnYkOwNO2r5KjGYiL0XjHpJer8Ml8qOsm1DzTBMiZVyT4Ptp7pLUouvoYYHZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829660; c=relaxed/simple;
	bh=jRoB3QJQtoUWYkbghAY3UiElZQo5D5kHTrny/5duIAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOhNiuFwFk6ieU9MezkeeOmLBNQqAWVDtbUWcR9+lwQ0n0i5ZWIz8394c4+izJAooau4V2PjWHZ5ZuK1ypx5tOd2YpZ9tVqFIexeC8GeQHdsO3VIFAHK9XcGzZX799qAFgPrdGwWuMlJOPTABhyE0B2VCQKNurS9r6I4pfmjOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca1yCzMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca1yCzMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C27C43390;
	Tue, 13 Feb 2024 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707829660;
	bh=jRoB3QJQtoUWYkbghAY3UiElZQo5D5kHTrny/5duIAE=;
	h=From:To:Cc:Subject:Date:From;
	b=ca1yCzMi5wbsMqO1a9c4fELGSL5hMWb6nyPJXZEw/MHCCj0K+X/8K48FVFG6fDbn0
	 1ksZlThxhWq3qTE2gCeWRzeV9hIP2XiUFrwQQ9/IMc4+HniZYQJgKDLfGaB+5+17xR
	 K/vRGosomhHZbyPv5dPIclPxBgQ4MA2Enmqs03QufO9905WP9vT4PlGuho9UpEpJ4+
	 uGcr7Yx3X5xu2fbiTI688N9ioWtqVmH0/e0vJHuREY+fPBw9soNa7X23KS5Pgmvctb
	 nE6jUKyeSe8noAZncih6K+HoAJY7YRn2KoWJqQNIYofEOK6AKDPHUfaSIPIrEEQmkr
	 TlZ5WxNkujjQA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 0/2] ahci minor quirk cleanups
Date: Tue, 13 Feb 2024 14:07:29 +0100
Message-ID: <20240213130733.819524-1-cassel@kernel.org>
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


Niklas Cassel (2):
  ahci: rename board_ahci_nosntf
  ahci: clean up ahci_broken_devslp quirk

 drivers/ata/ahci.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

-- 
2.43.0

