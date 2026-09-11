Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7740DB25
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153626; cv=none; b=VxbdEDpova64wzWDqCrYKFvdgJXFfN1fWgSxQK9Gn/6dgYHokiI+v4rLtgX7hsmbCFf8feeW13Uvgyiu1beB7PW/y2qw5HOREjLCagNlCPtcKhOQO8h4qTkW21MQ9bMNec3vp5VYv+wCWSdMtuIN2CKCG6q2AfqGUqNSZ/nX6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153626; c=relaxed/simple;
	bh=7kCR7JjujWop+dgd5S1qCEgV0Q2u00oClhWZb5hN8+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPhPVhRvQQnnSpOLeC7hiS5LhtoVj85vjwjJVSN2cI1qYnnAK9DIA9YvhU2M1dTtt64NXMPjL1IApjEfoaHq3tTnavllg/8o6QtwSiMQpbj1M8mbeJJKB4jFkI+EVHT+JOE00eLsSTgzfMLOKicE2csQE8xwg8bJAJSuHAN5vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeNN+9wn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeNN+9wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ABD1F000FF;
	Fri, 11 Sep 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789153610;
	bh=Aq3zF1Je0ouzMrE588B80JDySLM02A0CT//MSCA95Ug=;
	h=From:To:Cc:Subject:Date;
	b=IeNN+9wnhtm/7ZQ91wyn64n7FpEV0mSckDfi36BWFCxlHoJcTHtuph6hg1LwJ7+SI
	 KxYe9bzD6EZqRuvJotT6z3Pq4AxyuEEKYAoGSiQga4nbSieho1GZ5mWnAzf9CZZX9n
	 /m53yVDd6Ue73kGWReuCaozi7ktxu5Tw6BP1EjZk0K+SJmG/I3Pe2RD6YSyRzKPsWw
	 VmwT0lpP/+I014vjjoBeLuaDIu8ayERJ7Xh+UK1VInJayUAFi0PENtz+qjPA5ZcI+e
	 tIBPDoUUsxr4rtMt5A4+x8um/EBslo6v9RjKoEDBpP3FcmEvWcM0MeSxUDE28EpwmW
	 tzxmAAvkVMLyw==
From: Niklas Cassel <cassel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [GIT PULL] ata fixes for 7.3-rc3
Date: Fri, 11 Sep 2026 21:06:44 +0200
Message-ID: <20260911190644.55161-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 6d81700ad7c4871f94fb72e469cb0f3f55843ef7:

  ata: libata-scsi: do not raise UA for storage element depopulation and restoration (2026-09-03 16:10:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-7.3-rc3

for you to fetch changes up to a19d4f9b8befdcfcd5a87bab91312fe64af3bbb8:

  ata: pata_legacy: remove documentation for removed module parameters (2026-09-10 19:25:48 +0200)

----------------------------------------------------------------
ata fix for 7.3-rc3

 - Drop documentation for no longer existing pata_legacy kernel
   parameters (Ethan)

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      ata: pata_legacy: remove documentation for removed module parameters

 Documentation/admin-guide/kernel-parameters.txt | 37 -------------------------
 1 file changed, 37 deletions(-)
