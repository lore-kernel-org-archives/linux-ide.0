Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EF3A545E
	for <linux-ide@vger.kernel.org>; Fri,  1 May 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777640060; cv=none; b=m/14+qF7wMUqC58N8LkHOi6g8HTeo1N9A0BoyjUWU76GLQSd58Ef9v28+vO6XbpDWIZfkyeDz7m37i75nw4vlRVjkRAlYBje1Q8bmTOEm7XhvPmHmnPRn7WV4xs1HaNG+A0GoZ1aiJJFQj0DXoXqZ2ZEFvPfLPvYn/qJlhxsz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777640060; c=relaxed/simple;
	bh=L8uQm7kM3a+kcQdyEEYhxRl8Ejj5hBxFkHbbLREeoek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO6LYoK//b/qQ3TxNBoCVAqY0pu5NzurZxafbX1+X4oLmgrkADminucSuEYIqIdsiDOmwy9RvtbB4FtsrOZy4R3wU/MluSlbJaE6JzxOp56QxcuvOPu9t0qZeQfxUR8cXDhY8u8YtNCMXcPx3ssGOUmt1cVeeUoyAvZdr/uIYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTZ77YbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTZ77YbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF91C2BCB4;
	Fri,  1 May 2026 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777640059;
	bh=L8uQm7kM3a+kcQdyEEYhxRl8Ejj5hBxFkHbbLREeoek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTZ77YbJLkuGmr/M6iuhXIcIGm04N7nOgyL188IRADLz3NpQz9R5+Gq1O9i58Il0u
	 pD/X9AcATBJaqFEJfgLEaNUWgxrJbgEZmufMhcXuu+yqcy1s+i2+Lpzz0ikWgHYgwj
	 4VRbQzM5z3/2xR1308b4w0d+fmQPmwEWt7i8woSWVkATiL2vtmweh2x4gWGLuxBZne
	 cXx1JxIS86AIOENT58ZLL0o2E+XjWYxZ7tp3KENjQnPVKVfzGdGzsTT9WN6m5v3AOp
	 /QVVqzcMdl7oIdC4bEkea6mYALhFbXOsCzw8xPVvjeBpkgAk0YSbVBZZwvT5ZIIdod
	 pqgycEnfsbpPw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <htejun@gmail.com>,
	Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 1/3] ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
Date: Fri,  1 May 2026 14:54:11 +0200
Message-ID: <20260501125410.1204490-6-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501125410.1204490-5-cassel@kernel.org>
References: <20260501125410.1204490-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2598; i=cassel@kernel.org; h=from:subject; bh=L8uQm7kM3a+kcQdyEEYhxRl8Ejj5hBxFkHbbLREeoek=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK/LCpSuytYuGeVhe9M8VLlMyKih/8nyszM7P8czLlS4 GjzPvsVHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIJ1+GP5zfP86M72ZstGl4 fPWq0lrp6QtcWVoyD/zSk79ka8pWkMbIML83M65K9311isuei/sN3bieNm3SU2naIvna7Phcd80 ERgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
can only issue commands to one link at a time.

This is implemented in sata_pmp_qc_defer_cmd_switch() by setting
ap->excl_link if there is no link currently being exclusive, and setting
qc->flags ATA_QCFLAG_CLEAR_EXCL to clear the exlusive link in
__ata_qc_complete().

ATA_QCFLAG_CLEAR_EXCL is only set if this is the first link to become
active, or if (since CBS can only have one active link) the current link
is active. __ata_qc_complete() clears ap->excl_link as long as
ATA_QCFLAG_CLEAR_EXCL is set, it does not matter if there are still
outstanding requests to the same link. This works because
sata_pmp_qc_defer_cmd_switch() will only allow new commands to be queued
if (ap->nr_active_links == 0 || ata_link_active(link)).

However, since sata_pmp_qc_defer_cmd_switch() does a:
return ata_std_qc_defer(qc); before setting ap->excl_link, this means that
in the case where ap->excl_link == NULL and ata_std_qc_defer() returns 0
(i.e. the QC should not be deferred), we would not set ap->excl_link.

Additionally, think of the following example:
NCQ command1 to drive1 issued:
sets ATA_QCFLAG_CLEAR_EXCL
does not set ap->excl_link

NCQ command2 to drive1 issued:
sets ATA_QCFLAG_CLEAR_EXCL
does not set ap->excl_link

NCQ command3 to drive2 issued:
ap->excl_link gets set
does not set ATA_QCFLAG_CLEAR_EXCL
returns ATA_DEFER_PORT

For command3, it seems wrong to set ap->excl_link while also deferring the
command with ATA_DEFER_PORT.

Modify sata_pmp_qc_defer_cmd_switch() to only set ap->excl_link if we can
actually issue a command (i.e. if we don't return ATA_DEFER_PORT or
ATA_DEFER_LINK).

Fixes: 31f88384443b ("libata-pmp: implement qc_defer for command switching PMP support")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-pmp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..0575e1e283d8 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -113,11 +113,14 @@ int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
 
 	if (ap->excl_link == NULL || ap->excl_link == link) {
 		if (ap->nr_active_links == 0 || ata_link_active(link)) {
+			int ret;
+
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
-			return ata_std_qc_defer(qc);
+			ret = ata_std_qc_defer(qc);
+			if (!ret)
+				ap->excl_link = link;
+			return ret;
 		}
-
-		ap->excl_link = link;
 	}
 
 	return ATA_DEFER_PORT;
-- 
2.54.0

