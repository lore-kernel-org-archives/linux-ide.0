Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB893FC5A3
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989342; cv=none; b=nSB1ZQlHgNopMqRNr309uT4O6dKEvq2RQbhLdrWB+FLo+jVXluXsFcjD0dh2cZcRk5l0J8uytfC1NUlhHLjF9cMTDwK3B73WyLnXLLhMYyoM/G/F2uV9FH2WyuSg3l9+qUfwTyCvbM+ihZGC9DoPQbR+ZTcerdQU5h6P5eoxcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989342; c=relaxed/simple;
	bh=DG2eGMJGHfCeMAJALSuQNOVwdx+ROM70VEBJLaxdvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjGpvDzTvDuye0CxqR6D0CQCFGtW9MCzPKA1UPCXlB7GOtly+i/UcR4j57LGb2hA0nRuYC7h8lRpwyT1l1cl804sC/6gYObM057HnfwGYhga7/VQ0hvDWrkHKJ0tZSlwnS23Nofq4kFCKyh3k9gi6qtM+3ih0NGmszw/0+zmiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2qg5iPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2qg5iPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9467E1F000E9;
	Thu, 28 May 2026 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989340;
	bh=uBoJSfiyYehUEYisYEo58nb6+qYE+YbW9sFtvwqpCV0=;
	h=From:To:Cc:Subject:Date;
	b=n2qg5iPXnHQCsdkMYpSLuxJyYLOO7YDFWksX0m6ZHM/59dnV2syrtcl8T9kvYE25b
	 gjh+u1Z0ccj7EsgOzwNCNlU9GLaXnlfuQ+2QaIBb22jZkthndzUYNRj++GvDzfeiwF
	 2SZ3byPjf3iYQqUf0D5Fspp5SzReqOjRylBHlyENNmlSoK4z7emJCqtknFtOQwqyem
	 atIjwtWXYJGpoAtj6O26qyvVADhprS1/7m0FamNHA4MrM5VoF6wLrilnIyBc9FkEWV
	 Ojjc5D8+dOohBXXmUMVNJI/n29fH4YRZkLbK496W9ve+fHd0F/wHTM8R/QimJPvw4o
	 pnVlMYTu5YH9g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/3] ata: add __must_hold(ap->lock) annotations in issuing path
Date: Thu, 28 May 2026 19:28:56 +0200
Message-ID: <20260528172855.703631-5-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=cassel@kernel.org; h=from:subject; bh=DG2eGMJGHfCeMAJALSuQNOVwdx+ROM70VEBJLaxdvTI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIkqsP/6t348en3tJgAPl9xJska7gnXXCxfNjPyTvzxm P9tsS1vRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaSOoHhnxrLEYsJFc8aN++4 pG/888izP9PfTthr+qAgbrrA3W8zz1Uy/GaNXnAow/D3ox2W1xr/+i3OWHn0682pz+TTM1ftCJr OcZMXAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series is meant to be applied on top of Bart's patch that already sets:
CONTEXT_ANALYSIS := y
and adds __must_hold(ap->host->eh_mutex) for EH functions.


This adds __must_hold(ap->lock) annotations in the issuing path.

This only adds annotations to a small number of functions.
Additional functions can be annotated later.


By only annotating the issuing path, we are not blocked by first needing to
fix some of the ata_port_freeze() callers not taking the lock.

I tried to look at nv_do_interrupt(), but AFAICT, it does take the lock.



I much prefer adding a "struct ata_port *ap" parameter to the issuing functions,
because it avoids the problem that the context analysis cannot recognize that
qc->ap == ap. (Since it relies on static code analysis.)

Because the alternative, adding a bunch of lockdep_assert_held() before a
function call to a function annotated with __must_held(), simply tells the
compiler to assume that the lock is held (because the lockdep_assert_held()
macro has a call to __assume_ctx_lock()).

By adding an ap parameter, there is no need to assume any lock context,
it can be verified all the way from the function taking the lock.


Kind regards,
Niklas


Bart Van Assche (2):
  ata: libata: Pass ap parameter directly to functions in the issuing
    path
  ata: Annotate functions in the issuing path with __must_hold()

Niklas Cassel (1):
  ata: libata-scsi: Remove lockdep_assert_held() in ata_scsi_translate()

 drivers/ata/libata-core.c |  6 +++---
 drivers/ata/libata-sata.c |  3 ++-
 drivers/ata/libata-scsi.c | 20 ++++++++++----------
 drivers/ata/libata.h      |  7 +++++--
 include/linux/libata.h    |  3 ++-
 5 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.54.0

