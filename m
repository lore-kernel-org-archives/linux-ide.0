Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7D397699
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077811; cv=none; b=tBu9Zv0igUyilYkEG9AyiN+8ADMNLSqc7xTFBdiD1blnTv4BA1d6HpzvGg+6jgqO+uZ+H1gqRm+z2tMY1AcwfP9sJH+koDtSRW94Z060bIM5Xd6Vo0/niSrI0C5R1wut47TQmyjqBbB1UKBwPfH7oRu5FRyLdVbbgM72OLIJRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077811; c=relaxed/simple;
	bh=ae3iBCz243xZv09japLXKiPtWq4+qWyM6Omr5g7cORE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSroIHWov5dWehWgaJEQaTKkGvGc7jcJIHUviDUrpW6IYaZbx8daTSWkzpmj+Z/3Aj1z5nY2xuMDNvD12gebnyTAG1JBWOvJH5SZoTzJC6KZ5vrcpvS9EGo15NlCNpvVHpFAw6kT+Nlw9rMTgpEudlr1jiHlaB1rVZGTned71sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FoL7EkxX; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FoL7EkxX"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRrnZ1x7dzlffvg;
	Fri, 29 May 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780077806; x=1782669807; bh=J34+8
	JlOhgYOiy0q8ip30yUhf3xNs9jeKE/lvciMUyc=; b=FoL7EkxX4XicqXouo8Byp
	3zcvikKGNZLlfFwAFz376py2NLGJ8f85t+Gi1wcIf8bz+DdkXDFh5bKLkVpjv95P
	X4x6gSgTAvcs0D+sv0oJUmdWV4tCw/pdA8DhJSNTo0eC+IPkU2UNuJvtjnVZhpnh
	TnQuCrag87GSUPlSeW1FF32x53hh/KkDHL6o2/Fx9D0LJR5xsg2UxhQKNie+Cwsw
	qKwnlvuJwagfBUS7YcrVGlaQi2fFMVz1oAw9OIJX8ek0WooWL5e29/Tfkn5llmKJ
	zpFcGQC14DZ3oww/qAPdRhwq56AFMD7cIOpQjEjKBnhd3WCl/DMtpCNigSDVNA99
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yMI6oXyWUHDc; Fri, 29 May 2026 18:03:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRrnS2dXGzlh2rB;
	Fri, 29 May 2026 18:03:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 1/2] ata: libata: Add an argument to ata_eh_reset()
Date: Fri, 29 May 2026 11:03:09 -0700
Message-ID: <fe5341488e942ba5158a94d1c4f1cd5bf695327b.1780077008.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1780077008.git.bvanassche@acm.org>
References: <cover.1780077008.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass the ATA port pointer as first argument to ata_eh_reset(). No
functionality has been changed. This patch prepares for enabling lock
context analysis. Without this patch, lockdep_assert_held() statements
would have to be added before each ata_eh_reset() call because the
compiler doesn't know that ap->link.p =3D=3D ap. See also ata_link_init()=
.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-eh.c  | 6 +++---
 drivers/ata/libata-pmp.c | 2 +-
 drivers/ata/libata.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6cb79a09423d..e331812ae0db 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2831,10 +2831,9 @@ static bool ata_eh_followup_srst_needed(struct ata=
_link *link, int rc)
 	return false;
 }
=20
-int ata_eh_reset(struct ata_link *link, int classify,
+int ata_eh_reset(struct ata_port *ap, struct ata_link *link, int classif=
y,
 		 struct ata_reset_operations *reset_ops)
 {
-	struct ata_port *ap =3D link->ap;
 	struct ata_link *slave =3D ap->slave_link;
 	struct ata_eh_context *ehc =3D &link->eh_context;
 	struct ata_eh_context *sehc =3D slave ? &slave->eh_context : NULL;
@@ -3882,7 +3881,8 @@ int ata_eh_recover(struct ata_port *ap, struct ata_=
reset_operations *reset_ops,
 		if (!(ehc->i.action & ATA_EH_RESET))
 			continue;
=20
-		rc =3D ata_eh_reset(link, ata_link_nr_vacant(link), reset_ops);
+		rc =3D ata_eh_reset(ap, link, ata_link_nr_vacant(link),
+				  reset_ops);
 		if (rc) {
 			ata_link_err(link, "reset failed, giving up\n");
 			goto out;
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..32fe7b60de24 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -763,7 +763,7 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *a=
p,
 		struct ata_link *tlink;
=20
 		/* reset */
-		rc =3D ata_eh_reset(link, 0, reset_ops);
+		rc =3D ata_eh_reset(ap, link, 0, reset_ops);
 		if (rc) {
 			ata_link_err(link, "failed to reset PMP, giving up\n");
 			goto fail;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b5423b6e97de..a5920c10aaca 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -187,8 +187,8 @@ extern void ata_eh_done(struct ata_link *link, struct=
 ata_device *dev,
 extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
-extern int ata_eh_reset(struct ata_link *link, int classify,
-			struct ata_reset_operations *reset_ops);
+extern int ata_eh_reset(struct ata_port *ap, struct ata_link *link,
+			int classify, struct ata_reset_operations *reset_ops);
 extern int ata_eh_recover(struct ata_port *ap,
 			  struct ata_reset_operations *reset_ops,
 			  struct ata_link **r_failed_disk);
