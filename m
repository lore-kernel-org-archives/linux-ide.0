Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23E37F730
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755435; cv=none; b=YKvNaSaOB5M4cvXDvHVPRE51kEqlDhDLcyOFjs+2LB7t+9+PGcVm0msdjm8K7CqbJu4WV/HDOXvT1uCitI/qOyrVYTCPlivZg+4EGUQ4soz7r8tECMFG6ISUPq1RzzPFUCcjW0y6Clvc6/s4fhuaEXiR+TUfznZK6KBRH66VPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755435; c=relaxed/simple;
	bh=JtffbzqprzTrViYQ7Taos0buIS293qCwvbzfLpbTA6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EOp5UyXRkEDLAH+kdg3pwTFnNgwnhkVOnpAK4pebiOhJe+0EmVj2XosTU+62XRnRE0s/wdtOUBgmdNx0H4cmhW0h/UnuSZIHO74B/5ruNVL5BSqDSQQf83USzTzc/z7bP1oY0OdTQAUM6dX9KhK7S4sWFnJLKunn9PiOxleHNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzM0b45E; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkaruna.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzM0b45E"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30cb2bcbf7cso3278217eec.1
        for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782755431; x=1783360231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ceqTzvtFNR9yN/O8PsFGzAqkapSnmGAj9xm7IvizCmI=;
        b=XzM0b45EQ+uLFFG349MqT7hlCTH5EYe0/NXROT2mvKydXbFCB8bWY88pmbi1vRvAZ9
         yiaZxxkDtQ13a+yY5hQvZJsrsPzZ9mWYBtcobsLmsW7rZsjU4TPoIDC32AxvBl6sUK6d
         ldLdQ5Pnd/9uAut6tt5p9jcHTE90Pt0OuS7X8acT7ruesrB3YoQW/jS8UYSO3YIYEabD
         7fu1RaQCbqhAH6FhLeRIaUh5A22Saz8q5qzIAIN6SuVIMSZ26gj0+3NmLFbMBN3ptOPs
         QCrAz5OjNqtORrLMws2KBvVekmhJ5RZ7IfB7HBrYqMw4FBL6fLeOERk2kpdln3n/5DQs
         f95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755431; x=1783360231;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceqTzvtFNR9yN/O8PsFGzAqkapSnmGAj9xm7IvizCmI=;
        b=gB4MCzFdCkpI+JLL/VtS6sZBw8eGMUoRsd8hv/F4omGuiIoV0mufH88xlqUGMh4rwN
         DMPDmgeB38L8IkcN9ncQB/48O1Un2CryyTNPblq8lh8VLVyXh+D6SZHLneoZnx1XT8NK
         cD4BQUB53jY+cMOzJS/gUx3a0TklwreEWm7K7OPmHxHD7H2RArfkawpvH1wgW7MAeW8S
         +mMMVzORm0AG9e0Dx3BXlnpa/uuMcy1OcJEhQuuH7wdA5tjclOqnFzVRMtbul9sM+Jq4
         ZzEnPTw3CQoGYAy3E/c4x0TjgbHAOOvH/miARCwdfhPjz5Nhh5Vciven3jTtMrxkrmII
         u88g==
X-Gm-Message-State: AOJu0YwpUcJEgabbE+shSYAopEWjiZLpspW74JE1XAR7AVGH/R+yaXJo
	6BOvSX2IGboOSHnOWBrM0drWQIEq8aCtLVBSg9rR1q8MRuIM1dAwCOEvG+kREi/Lb/5rJZm/of2
	NjAUqfsC+iA==
X-Received: from dycqw14-n1.prod.google.com ([2002:a05:7300:c00e:10b0:30c:9bbe:7d17])
 (user=rkaruna job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b89:b0:30c:ab4d:da44
 with SMTP id 5a478bee46e88-30ee13bd124mr305872eec.40.1782755430047; Mon, 29
 Jun 2026 10:50:30 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:50:24 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629175024.2187500-1-rkaruna@google.com>
Subject: [PATCH] ata: libata-scsi: limit simulated SCSI command copy to
 response length
From: Karuna Ramkumar <rkaruna@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ipylypiv@google.com, tadamsjr@google.com, 
	Karuna Ramkumar <rkaruna@google.com>
Content-Type: text/plain; charset="UTF-8"

The function ata_scsi_rbuf_fill() is used to copy the response of
emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
scatterlist.

Currently, sg_copy_from_buffer() is called with the size argument
set to ATA_SCSI_RBUF_SIZE (2048 bytes). Since ata_scsi_rbuf is
zeroed out before the simulation actor is invoked, copying the
full buffer size causes the remainder of the SCSI command's
transfer buffer (beyond the actual response length 'len') to be
overwritten with zeroes. This clobbers any pre-existing sentinel
values or data in the caller's buffer tail, even though the
correct residual count is reported via scsi_set_resid().

Fix this by passing the actual response length 'len' as the copy
size to sg_copy_from_buffer(), ensuring that the tail of the
caller's buffer remains untouched. Also, add a defensive
WARN_ON() check to ensure that the actor does not return a
length exceeding the static buffer capacity.

The fix was tested by invoking an SCSI SG_IO INQUIRY on
an ATA disk on vanilla build, and build with the fix. Confirmed
that the input buffer's tail end remains unmodified with the fix.

Fixes: 5251ae224d8d ("ata: libata-scsi: Return residual for emulated SCSI commands")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Karuna Ramkumar <rkaruna@google.com>
---
 drivers/ata/libata-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..0ddec111a78c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1933,8 +1933,10 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
 	len = actor(dev, cmd, ata_scsi_rbuf);
 	if (len) {
+		if (WARN_ON(len > ATA_SCSI_RBUF_SIZE))
+			len = ATA_SCSI_RBUF_SIZE;
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
+				    ata_scsi_rbuf, len);
 		cmd->result = SAM_STAT_GOOD;
 		if (scsi_bufflen(cmd) > len)
 			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

