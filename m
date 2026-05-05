Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD913AE712
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2026 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955007; cv=none; b=Hg60B639MyZ0CFoXhYUfECnz5ADmUlRsu9S9MRzmZI1hsTiEJ0Quy0T1ShZrkxWZzSkl1IN5UQlFjpH/dLEzQ2GrI6WFDeJtdbi/zY/Hxxw20sVB2CyvKxQQnl1cvEBQXLvp/NP4ji+1Nu95qepqCU9zaacqeJxMoJjyyokzSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955007; c=relaxed/simple;
	bh=bMMsODCQS9pikyNgTch4pOx/s2kVJ+whgZpDBYSowr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DG0Ct7gjS+t9QQ/XTSitG9QO1+sf5Vb+Ef7seXygMruJUdNthc/AR+fEGHWsk4O85s74wOEvoBm98SfTavSg9cVfdqskgVS+3oP7RyqqsXCZar0qSNn1SegJbK+3l2zK9yDGktW42Kug/Y5ns077JVD1VkchxnYzOLGK36R4eYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1b/qJ4fg; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1b/qJ4fg"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g8lkP1z86z1XM6JG;
	Tue,  5 May 2026 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1777955002; x=1780547003; bh=Ucvxq2QOLKUUOv0oFSqdmQTG4GmybASrKSx
	OZGDKqZs=; b=1b/qJ4fgR/mmlPktD8NXqTZewlXBmQETmymbNXAmqtaMigvGeKN
	CFEhnobvKdS7fkselXNyQ01n+J/bio0pY0wCHaWdZDs1/n5ml/6VYOeud6FlRkxE
	HBTTreFjbxTtvAA9hegEB1ics0VfRU7JZ29XaW1rkF8alsg13aIV8nAjxTXyYqXh
	5p1Bm6uBY/n2mrBhH8W945BOIwnWxMsJSPL9aSxan5TjOitFTmNoSieMqkqsWmRs
	BL1gK8OEhZt55/cXq3tMBjp/pUGQ9vYSC3O6JwGvpmNAp1/UWjwO+hxuIL/b4z1J
	/yP29hGUR7jEc1166HWYH1GLi66t8ZgLffQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vHKPB6GGQ9D4; Tue,  5 May 2026 04:23:22 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g8lkJ5psmz1XM5kD;
	Tue,  5 May 2026 04:23:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ata: ahci: Move EXPORT_SYMBOL_GPL(ahci_do_softreset)
Date: Tue,  5 May 2026 06:23:10 +0200
Message-ID: <20260505042310.909857-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From Documentation/process/coding-style.rst:

-------------------------------------------------------------------------=
---
In source files, separate functions with one blank line.  If the function=
 is
exported, the **EXPORT** macro for it should follow immediately after the
closing function brace line.
-------------------------------------------------------------------------=
---

Hence, move EXPORT_SYMBOL_GPL(ahci_do_softreset) to just below the
definition of the ahci_do_softreset() function.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c79abdfcd7a9..99e85c767661 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1527,6 +1527,7 @@ int ahci_do_softreset(struct ata_link *link, unsign=
ed int *class,
 	ata_link_err(link, "softreset failed (%s)\n", reason);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_do_softreset);
=20
 int ahci_check_ready(struct ata_link *link)
 {
@@ -1544,7 +1545,6 @@ static int ahci_softreset(struct ata_link *link, un=
signed int *class,
=20
 	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
-EXPORT_SYMBOL_GPL(ahci_do_softreset);
=20
 static int ahci_bad_pmp_check_ready(struct ata_link *link)
 {
