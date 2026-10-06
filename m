Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1023E5A35
	for <linux-ide@vger.kernel.org>; Tue,  6 Oct 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283531; cv=none; b=rciVOCQzsT9nkvvy+rUCtu6qFdwYQVc9IUVRom2nu+TYf5Mi4Zjif54Ozs7POBN+DVDwc56r4ttiGmATr2LvtRKarcomNTvkwdmX2dHtLhavDKz5KaE2NKRRf28zLLUzcdL2AuuuyhyZpsZkrqaWElscaJB+CqEfKhTlu2bjyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283531; c=relaxed/simple;
	bh=sFm2V3Ai5o6YYdViPqtePbCTXeOLl7v0rTsb0AnU5FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGm4RTvtNEcRwZpc+Eo5dvByYp4rR6Xn2oO7xIwPtCWQ/defwIPf8XBmL8HeHES5F63AAgrDS7u71nYYBpRsyz0E6NRfw8wp3tpSdfblTU5eD2qQsLfg8MzjAsawX2eiLBXOuzuVxP+dV5yxcFLFeScSRG2hgFS+r4AYTf4eO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG/3120N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG/3120N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF21F000FF;
	Tue,  6 Oct 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283524;
	bh=fGo2vOg3geZcI08HZ65lQF4RsCBMkF+CQnJ9Mrgkoa4=;
	h=From:To:Cc:Subject:Date;
	b=IG/3120NW74GlLCkQnKucUNEwyUxCpMlzv8zUuUEuZ+DNwxn1lG9AzaTvn3s+xOQO
	 m30E0GynqV2cy/T1iNfhXdFAERKcNaUrG/NchntweljGEID8yplQLHM3oZPorjdh75
	 0dqJhOTnQwUQrDUXjXwCXFeH+lSQ0GtdLgksDXNjLE37IhsJDZJKV+5M9gr9D+Wre9
	 AjKTs5bsJnYavZPJr/uj3ws+sV/cQgtZ+DcYmjOIsJlpVhISFGR5MAgBNHqd03McvA
	 534efmjtuutKBzBgQZ/QPEl1S/nqz04hX0CbUIIvxHalG3XFbaWHLcWxJk/CQpHNrD
	 EYaW2WKog0udQ==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.3-rc7
Date: Tue,  6 Oct 2026 12:45:16 +0200
Message-ID: <20261006104516.2347588-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 113dcdfadf30ea11fbbdfcd4f6ea87687655cc5b:

  MAINTAINERS: name the libata/linux for-next branch (2026-09-25 11:08:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc7

for you to fetch changes up to bc8ce2cea5f77c4bd1a5184705e300e83546c0c4:

  ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands (2026-09-30 10:42:26 +0200)

----------------------------------------------------------------
ata fix for 7.3-rc7

 - Set CHECK CONDITION for failed ATAPI commands.

   Since commit 2e1d2e65e773 ("ata: libata-scsi: terminate deferred
   commands on time out") failed ATAPI commands incorrectly stopped
   having CHECK CONDITION set for commands that had a SCSI midlayer
   byte set by scsi_check_sense(). SG_IO users therefore saw failed
   ATAPI commands as successful. (Hengyu)

----------------------------------------------------------------
Hengyu Liang (1):
      ata: libata-scsi: do not lose CHECK CONDITION for failed ATAPI commands

 drivers/ata/libata-scsi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
