Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A812E6D
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724950; cv=none; b=dntiUSV0ACuDgdboKdmvS9kSKA3zb1DoO5DLqMCpErZj76Ys62xjIo1co+RAZpk5PkrQSQo8GOkzjZ9PxW8Stb6zrNK7ZfCcAIQFAYVSQszJ/Izdj2YzbxoQTK0RJsbqGUtDoeun8TDgY1s9dw821KNLEKR9SDVxvu6QAYkWrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724950; c=relaxed/simple;
	bh=01KYK0VI2IvYhPmSvuceUy7M3FOCYBEe8sjGTqQ9sMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeezjGH6i2dfosi/NfCaDj44q/XdHUI3Cv9bxxFs+ZCqqacrE4wLB3KUXB9bcinPra2jz+bn9qZdsjnK0W/gRSDWpL9Tjf1cnDfGAo/5nENA0wnbWIN8OmQpyvwcfhBxTCyqmp66EBAPcJE3I8cqj0OmfvvAvBL18bkgxJaDwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpIV2XV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpIV2XV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86460C3277B;
	Tue, 18 Jun 2024 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724950;
	bh=01KYK0VI2IvYhPmSvuceUy7M3FOCYBEe8sjGTqQ9sMs=;
	h=From:To:Cc:Subject:Date:From;
	b=lpIV2XV2bkvBlrUO7O1uPqeUN97qkoCVKY8ymYjReko5NgDMdnshjvgueyfjd8KSm
	 BtqCEM4qq1QF9P28HFDJPIsiJTDnMiWLewNCBVDk8mqc7rgRYhqsgTC1N3n4xwrQRA
	 ETteHYA8fMo7oA/L47lFrOnL1EjI0IEFbU2Gd2RMK5si6jvNZxlEvLxFrWlm9Twyza
	 EHv5IbOcoh5qiXfbUaT2KOolZDmxhAtH8FR/ZicHLSC9RVyFiOUOXUn2Srf+hsVvFv
	 CE3M3/BK5hMl8RqHhbcuZNafJJN4BgVpIP6XoRBAwfqE3bWosqfS2amNX+JTajvL0g
	 J29nzHn2xQ7hw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/5] Assign the unique id used for printing earlier
Date: Tue, 18 Jun 2024 17:35:38 +0200
Message-ID: <20240618153537.2687621-7-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=cassel@kernel.org; h=from:subject; bh=01KYK0VI2IvYhPmSvuceUy7M3FOCYBEe8sjGTqQ9sMs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKV3r2df3j9nr/YvbOzWVHp2/XdSvIaftUxM8jv+LVu 61mF25mdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiHNmMDF/utoiEJfZX7zOO muKezhL/+2NkyPdHR5oa38VvNjjoV8Dw3y/x3+LDuj+9os68/Bp62/J7u7ji0T1b3tfnmE1w//f /KCsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series moves the assignment of ap->print_id, which is used as a
unique id for each port, earlier, such that we can use the ata_port_*
print functions even before the ata_host has been registered.


Kind regards,
Niklas

Niklas Cassel (5):
  ata: libata-core: Remove support for decreasing the number of ports
  ata: libata-scsi: Remove superfluous assignment in
    ata_sas_port_alloc()
  ata: libata: Assign print_id at port allocation time
  ata: libata-scsi: Assign local_port_no at host allocation time
  ata: ahci: Add debug print for external port

 drivers/ata/ahci.c        |  4 +++-
 drivers/ata/libata-core.c | 33 ++++++++++++---------------------
 drivers/ata/libata-sata.c |  2 --
 3 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.45.2

