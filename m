Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFA1A2C09
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267159; cv=none; b=brweDWyLng3p3IonzR3lJ5wGmNebWdNKKRcAMvOeH283v5wo2n7VMPxAz0yeUfU/Hi9a2jOtUcqzAFVbwcV/G1xX+diSGZ7Kx8eQOjRpUDeTa9X4ElKAP+FHT1BfBdNhGZAWV/ZuvIvhCB56c/drNq64w3Pq5hDlmu9OD5VCRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267159; c=relaxed/simple;
	bh=4ci67SVFpkWmJkYCTkpx+ig9XBfHau+20YcfXOFnufI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpaI6gag/R924WnGaI6elLwuBalXAjZzRRUN6akpexjNn5U6aONFMepB9qmdwB2rZs5wM9kyUw1G01goPfFlat2OaiyF2sUzI6Eyd9M+IngYAZuRkMoUj5JqUhOKFBNLBGrLBEYLO3GbZPjyRhRKF7vgFojhRoTeP6h3EuNLIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7/ciOLH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7/ciOLH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e35e34f9b7so3934815a12.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267157; x=1719871957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=am7s8zTwG1CQ1DLlONdgBD04NQU7cty5c4MreVuPbFc=;
        b=G7/ciOLH6m9StJN4nPtD4v+pJj9TGy3y8UqUf+YjvAuaE1ucF4ZbF508wSRz08VbtY
         jY3Kic/eXE5cVf1xdwQbXrB9EyZt0eA7r4ATWiQvjdBEpcZg7qkUrgsIzAjyMY3g79l1
         y5NWMYsB0ojXutD65UGhR5fnMThQtMNlyqijtfYecKVVm4n1JHrFnTNMKZa2sqwxYPMq
         vagRnBLNs2X1hle4lWy0ZJ2SYcX516zHJrzeKx8EXNM152soJwF71uyttmJPo14IZ3ft
         acwb2Zv3Lh6IS7H8PEomAIgSMq9U+noTOnL8bzbyel2/yEZEPHW6S73w9OanxDUVXCWx
         RQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267157; x=1719871957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am7s8zTwG1CQ1DLlONdgBD04NQU7cty5c4MreVuPbFc=;
        b=hL2/3J4AcrWItCqnIh6HJy+870IfV5YUx7QAWwt/D7Wx8URr4TfFxTuKELbufnXHPn
         kO9EtvAjiQ0hgixfaC3fyqN8qLE9RHjoAOxGSlR8aLG4VmDyP+1UXHusC3gZHd1Vo5SY
         ts9bDUqgPfbjZ8/OEfXIYF8GsGa0RLkdG/qgE2+iF6sHklbsWKYIasMaj9rnkz/x2BsE
         L7p+CYQw7/9ufooavvBraAOFDuR9JVzyAGzfzUnsxpOmlmSGYE1SHENiNpPKU/9Wf2S8
         a57291OWX9c1p0U0U53pg1R1xbCG7RRr8Hw6ZQXK6/njDbj+GpCK6f/d7yT4K3mfHqGi
         atuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIDcLNhmH/Dfs1SjIEEBibijIsAHp9N3PM/BrQfS++av8jdjITM7aY+/XPcRZo62fJyj0DRuWuIG5YsVHNl2qIqV9AyvCxAFtO
X-Gm-Message-State: AOJu0Yz+YV6m45yjs/FBnSXAa54XqCP83b0YU0HVi5OUC0ekiS6uShxz
	uF4D0BqWbArXPwByv/OX7p8I9byEI8sNe1NzH1kAP3iSJPIyAdOuEPAetL2kZNexxyt6DEM8DGN
	pYU10XfZWaw==
X-Google-Smtp-Source: AGHT+IGUdOx20r7NDEUvU1cytoPKAzBTVDx7VmCUnni5NL4Qq9RkQzd3oASNoeizoFcr889fkOjJmC0s/e4Cxw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:eccb:b0:1f9:cc3c:9dc with SMTP id
 d9443c01a7336-1fa104968e4mr1692405ad.5.1719267157123; Mon, 24 Jun 2024
 15:12:37 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:08 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-5-ipylypiv@google.com>
Subject: [PATCH v2 4/6] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Fixes: ff8072d589dc ("ata: libata: remove references to non-existing error_handler()")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1aeab6e1c8b3..e5669a296d81 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
-			       u8 *asc, u8 *ascq)
+static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
+			       u8 *ascq)
 {
 	int i;
 
@@ -935,7 +934,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -977,7 +976,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.741.gdbec12cfda-goog

