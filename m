Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDC20FAB5
	for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641021; cv=none; b=Mkl/vMg1PL6CuufTrWnq0Vp6w7uNFdH3BdrZVgiFBa6InesC6prxnUz3tUOWx+lD0ReNmDoKFIwr+6sSORURh2QGCULDOVpxAhFsXRUinxDb4iPd05eB0fnpLol9yajlUyGgcg6Swhmf8jiwtSiRwRrq36FZSHvWtDsoxbM9zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641021; c=relaxed/simple;
	bh=5xKJSKb92T+9Xe0pF1Wmd/kTnWCuVOlTTr43k398buM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9BF7m4238fibkvMuBkNF4GOKJ4z9467uEuJ7tHBDX1VwcaOEDDsdPSxObN2xdEu3Wf9tY4uMF05mlOvQbIy0oOyOmMUlPxudI7XSVj9gauWNg9aFb1kSOCmRLqM6oAQr5hbwN4uR/FOpY+OBkBpY62xFdR3378S9LVz4GrCw1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9bIZ0NG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9bIZ0NG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADCBC4CEC3;
	Fri, 11 Oct 2024 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728641020;
	bh=5xKJSKb92T+9Xe0pF1Wmd/kTnWCuVOlTTr43k398buM=;
	h=From:To:Cc:Subject:Date:From;
	b=r9bIZ0NGF7BLRj6N1kC4ZkU39T2joI1voNxYvT9Nz5GmZUck78TDnM62UdOSXDDEp
	 wuuMGzLmVSlzucbcJLyuKMPEbwjFXm3Fa4xa9AjCqsj+byO4BqCXMJ7Xxok0YeViLv
	 T80yDyGZuSwsqyGnO6w2DuV4r5rFTlJkOgPmrI8LmntDs/FyQKtnFpJ+xdVC22DcG+
	 0L3rDnmb/VwEL2c+Cd17J3mGaXnhYo0hd3L6LH1zQO6nT7xCtVAPLkCIk9xc2z9lvF
	 XRdaF9+C4P8/nJ9L6WAxx95caiHMXXSGc+OtCPFEsw851W2+SmvE5fVMG0M+ePX4zb
	 s4XNr8L1amJ+Q==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 6.12-rc3
Date: Fri, 11 Oct 2024 12:02:41 +0200
Message-ID: <20241011100241.1825849-1-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.12-rc3

for you to fetch changes up to 0df4b9d91488922859db8dde4ee56936e01d547c:

  ata: libata: Update MAINTAINERS file (2024-10-10 10:58:27 +0200)

----------------------------------------------------------------
ata fixes for 6.12-rc3

 - Fix a hibernate regression where the disk was needlessly spun down and
   then immediately spun up both when entering and when resuming from
   hibernation (me)

 - Update the MAINTAINERS file to remove remnants from Jens maintainership
   of libata (Damien)

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata: Update MAINTAINERS file

Niklas Cassel (1):
      ata: libata: avoid superfluous disk spin down + spin up during hibernation

 MAINTAINERS             |  6 ------
 drivers/ata/libata-eh.c | 18 ++++++++++++++----
 2 files changed, 14 insertions(+), 10 deletions(-)
