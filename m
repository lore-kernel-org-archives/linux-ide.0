Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350852;
	b=PfL7IFOvxpjn5ScjkEL5SnkmuYCPgDRxAD2B5Oa3ox2dw3hTAcpetqI8CqJeztER8L1c
	 oS6IYEoHJvGGwiUjONUFLPxD6dsdDERV9IE2Pwo0qsw1ENGcm1IqjvwmTjEWibd8/pd3n
	 Wr30GlBqPnTBgeLn2Rl7e3AX8Cm8C/8GuomeBjTNSV9U5D6lsfEnC7Kb1J7+4CnD/PLsU
	 pL0tPqIftyymRwqt0Bj+7E+b7DWo7U9W9TJv9FXbvzofuicQX7K6ElM1dtwS1SkNdGSd1
	 t7bfd8ch+Uy+dfGhnO0syfKFMYNmRsvmjbR0uZ8VUmZc56+e72ikFQ9YAvbah/LuQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=HVB3/ENMbgWRySaxq3NIxaKC+aOEmDhLWkwa7TWeRC8=;
	b=zxBv1m9R1VJkSPEEtu/uClC3K8z3AEPSiftfnnA4YlAg1qcLwy2957jbt2zgEeGB1b0q
	 G0oOMRYUm7PK1+nSjKjoWlIQ5RLHOFna7HNZ+zITDgY2+bp/3dyVYii1eqtsRmZz4uVJD
	 b0NLtVim84Ob4rXx121xjjigszY27elsyuZorwKIKCEHWqw2rMMnP8EP3hB3dW9XqFhbX
	 lRnzvqxUJYu8APXlFbQ2R3KdLskcwJUnlVW+PY1dTNBJfoxspw3rrVrVwDj19C2/dw2EW
	 fwuVRW4alSwJyj/lM1EM8z03aBtCKFlLAgSz40jnub0pSE4xRxEQnZU9OgRq24l027A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhQsxvYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F1606A31A
	for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhQsxvYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0991F000C1;
	Fri, 30 Oct 2026 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350851;
	bh=HVB3/ENMbgWRySaxq3NIxaKC+aOEmDhLWkwa7TWeRC8=;
	h=From:To:Cc:Subject:Date;
	b=lhQsxvYtizT/SIby5Qix4NLZILeu65+TtnWIBMOuRx2bWrUG+iY5p/JZAO1F8Z87o
	 yTyRWPvu6Qmp8qEN3vL+vL1BW+yWPZ8QXmzaaef+/+O3tOqABIdCpeRbWG3getJ5md
	 A4/T+qDApBPfiJs1HRTMwr1OY7yiWoBi/9/UmoIqWIU225mua3ZOyfUVAcGvT2D6xn
	 nwOh+DxKFZ5dEwnHiGQucFwURYFhWkhIqn13cnuCa2Z5TXF//eWUyup1GMZ546bxIf
	 3RTD9PonQrK45sv5X3dPi2rUTbA+r/U97WKMxKqe4W8EtpB6+IbDMfNVZ02e0ORjiY
	 tad/c+PXUpJig==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-eh: Retry non-NCQ commands when their sense data asks for it
Date: Fri, 30 Oct 2026 10:00:48 +0100
Message-ID: <20261030090047.407906-2-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=cassel@kernel.org; h=from:subject; bh=fxRqa3EYfJS9cfZAxSB/OOZMXQ4Fp7iBJj0FpnYFqOI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKexOyf5WTzk9FoJ4v3/1CbeLmpyv18uStsmR8dNWGOn X2nYsn2jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzEro3hv4+Iwfuyp7Eq6+I8 yrp+LPIIiLu3J2P31Ojyu9z/jTa7sTAyvO7WU4h6cfC5o29I569HzHtCJE8yM+1+mPzd9pSGz8+ TTAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When a failed command has valid sense data, ata_eh_analyze_tf() asks
scsi_check_sense() whether the command should be retried, and sets
ATA_QCFLAG_RETRY if it should. ata_eh_link_autopsy() then clears
AC_ERR_DEV and AC_ERR_OTHER from qc->err_mask, relying on that decision.

For an NCQ command, qc->err_mask still has AC_ERR_NCQ, so
ata_eh_finish() honors ATA_QCFLAG_RETRY. For a non-NCQ command, whose
sense data comes from REQUEST SENSE DATA EXT, qc->err_mask is now zero,
and ata_eh_finish() completes the command with scmd->retries set to
scmd->allowed, without looking at ATA_QCFLAG_RETRY. Such a command is
thus never retried, even when its sense data asks for a retry, e.g. a
transient error reported as ABORTED COMMAND.

Make ata_eh_finish() honor ATA_QCFLAG_RETRY for commands with valid
sense data. ata_eh_qc_retry() cannot be used for this: as qc->err_mask
is zero, it increments scmd->allowed, so every retry would allow one
more, and a persistent error would be retried forever. Instead,
complete the command without touching scmd->allowed or scmd->retries,
so that the SCSI midlayer retries it at most scmd->allowed times, like
any other failed command.

Fixes: 3852e3738266 ("libata: evaluate SCSI sense code")
Signed-off-by: Niklas Cassel <cassel@kernel.org>

---
Tested in QEMU: blkdebug fails a non-NCQ (PATA) read with EIO, and the
disk reports ABORTED COMMAND sense data. Before this patch, the read was
not retried (1 attempt); after it, a transient error is retried and the
read succeeds, and a persistent error is retried 5 times. NCQ commands,
and errors without sense data, were already retried and are unchanged.
---
 drivers/ata/libata-eh.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b7e8545e569e..f99e422dfd9f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4080,8 +4080,20 @@ void ata_eh_finish(struct ata_port *ap)
 				ata_eh_qc_complete(qc);
 			}
 		} else {
-			if (qc->flags & ATA_QCFLAG_SENSE_VALID ||
-			    qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) {
+			if (qc->flags & ATA_QCFLAG_SENSE_VALID &&
+			    qc->flags & ATA_QCFLAG_RETRY) {
+				/*
+				 * The sense data asks for a retry, see
+				 * ata_eh_analyze_tf(). ata_eh_link_autopsy()
+				 * cleared qc->err_mask, so ata_eh_qc_retry()
+				 * would increment scmd->allowed. Leave
+				 * scmd->allowed alone, so that upper layer
+				 * only retries the command if it has not
+				 * already been retried too many times.
+				 */
+				__ata_eh_qc_complete(qc);
+			} else if (qc->flags & ATA_QCFLAG_SENSE_VALID ||
+				   qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) {
 				ata_eh_qc_complete(qc);
 			} else {
 				/* feed zero TF to sense generation */
-- 
2.56.0

