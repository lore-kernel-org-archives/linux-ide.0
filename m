Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E235F4EB
	for <linux-ide@vger.kernel.org>; Sun,  1 Sep 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725231875; cv=none; b=DDkNN51P4dyIyt2dBDBP2hF32fwtdird3HBCC6cekbZP46AcE6I7sVbupfwMzjbzfUbMlbMm3YJuEGcrQZOLJlLeX7b3fhZQHYA1t7mH2KnJU9zLoz6hXi0WSrbz+1bOlWuLpBTtGhVV2Xr9QbW6Vz9nh4SL/YgDHOqaWFK7sEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725231875; c=relaxed/simple;
	bh=0pLsfBnuR6LRd7bhMg8Sd+DY6pE+qHVPhfH5I42NC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkmmWrpgvN/CvUSL6AdRLkE+jiTzfAkeJ9ie0KcfSpHjY/QriEJiHZjDlpEbhcwxR0Pk8FMd4tRJeU5xWPjQn/TR0kgsdGNe5EyXLkgI0fp10EcxFPjLTOkKobG1cziuv51EiC+u455yW2PkWHtBogNynbBe26RM9NlU7uxcJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqIwIxLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqIwIxLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BACEC4CEC3;
	Sun,  1 Sep 2024 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725231875;
	bh=0pLsfBnuR6LRd7bhMg8Sd+DY6pE+qHVPhfH5I42NC7k=;
	h=From:To:Cc:Subject:Date:From;
	b=cqIwIxLRtAUOQyffaTEuQWIihJLPFnIBqQ7BCs0Re119tv+85P98psQZtSSwWYU2Y
	 I91OlzZyrO6nXACsg2XeHvd7LjAaBJ1mjMZDu6DcrO4a3PWC+HZprmtFj5GWqUFUUX
	 IjslacHoT5ufgbKuqxLfi4tEkeEMMU+hVRia1YPMJDnKjUhc7BpXwe0wrVv1bHPfgb
	 v+qr3Z6Rgtj5un3OQ3drCjwi7CL6pDx9bj7pegOu73AeG2kb9KHTZE2ZOvmKOKJmxQ
	 XDlkjfFUMTgMA82VIi3pmEB9O5zoJM+gzOFIqwf4aQoA+PJu2zQqmadOwdOv/juYO6
	 QuSJD9c+BU9+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.11-rc7
Date: Mon,  2 Sep 2024 08:04:31 +0900
Message-ID: <20240901230431.35937-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit d4bc0a264fb482b019c84fbc7202dd3cab059087:

  ata: pata_macio: Use WARN instead of BUG (2024-08-21 14:33:23 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.11-rc7

for you to fetch changes up to 284b75a3d83c7631586d98f6dede1d90f128f0db:

  ata: libata: Fix memory leak for error path in ata_host_alloc() (2024-08-27 06:54:36 +0900)

----------------------------------------------------------------
ata fixes for 6.11-rc7

 - Fix a potential memory leak in the ata host initialization code (from
   Zheng).

----------------------------------------------------------------
Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

 drivers/ata/libata-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
