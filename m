Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427CB19F420
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063407; cv=none; b=tfJTZDp01nOttm+nJETCIVHtbwZs4VRi9mIA5Mgq0Pi+9u5+cwAFkckq/pDedhwrgggJ9EnJnjk9Mdgf+JGjqs8tg3zZ4h2VJBzNJLxJvLcMr+f9tlud3QD04G9UPXcaoWGBNahzG1oZDQs9v6/Vi0WGJ2dTYWVT5y6G7gT1EJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063407; c=relaxed/simple;
	bh=CYSOkaIspFblpD/pPL7abyOapoZvykPKemz5IzT1qls=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bKqFwacJ7dB+y72SWLpm/o9uRGNY/rSw2ejw8ON2EBLBnqDpJfMTSiBCqA3qZ00dV5oGgiuMF9vSeFf2WYKnfEXpBP7+Kbeg2ynzmBKnbtpbx4zq2rYzVI0bYLLs/xTpXKLzsir8boy5U2wtJ3EuaL5bfamoB9h3aAUbUPRVtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de; spf=pass smtp.mailfrom=kuehnke.de; dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b=gTOtPB0J; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuehnke.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b="gTOtPB0J"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4Yj21X6TNsz3ydK
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 11:42:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kuehnke.de; s=key2;
	t=1738060976; bh=CYSOkaIspFblpD/pPL7abyOapoZvykPKemz5IzT1qls=;
	h=Date:To:From:Subject:From;
	b=gTOtPB0Je4cdh+AY8viczIqw9Pk+cGOCONtxIfLKRGYMVK5IO6XiLUftdkUkLIE06
	 wnhRgVG3BhhnH/J3vYdK2smjxZFnPhrHez9QoUMTY/q7JmWdZlJ5K2wvLKCDnOAl7m
	 g97GBeFOvrnATV415DtUcVXnO4kk2mAqAfHpQUMdj45LFI1sUtxXauIThUZz4r6KpR
	 9Mo2F5r2Z8hMyfcCfXInfBOFPN/jrSQIihb7L9PuBZmfM0jBVS6PwiYo2ruG0ZrltI
	 IN9/vYXNivuIln3aCog7BwZPJB0uIjB2cJt1KtYGs3/Ign7sOwoMClt4Eyn4ggrQSz
	 DGXG2BF4BAyJg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4Yj21X5nH8z3w8J
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 11:42:56 +0100 (CET)
Received: from mx2f74.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Yj2jl5x1rz8sch
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 12:14:19 +0100 (CET)
Received: from [192.168.3.2] (p4feab3aa.dip0.t-ipconnect.de [79.234.179.170])
	by mx2f74.netcup.net (Postfix) with ESMTPSA id 4C8FC20201
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 12:14:15 +0100 (CET)
Authentication-Results: mx2f74;
        spf=pass (sender IP is 79.234.179.170) smtp.mailfrom=christian@kuehnke.de smtp.helo=[192.168.3.2]
Received-SPF: pass (mx2f74: connection is authenticated)
Message-ID: <1c79066a-9349-4f65-9ef2-dba4cf12361a@kuehnke.de>
Date: Tue, 28 Jan 2025 12:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ide@vger.kernel.org
From: =?UTF-8?Q?Christian_K=C3=BChnke?= <christian@kuehnke.de>
Subject: Problems while retrieving SMART information via C602 SAS controller
 since 6.6.51
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173806285554.3153.14464169932045880186@mx2f74.netcup.net>
X-Rspamd-Queue-Id: 4C8FC20201
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: RUAtE+bDuL9OKcEphZTmyrSMls3ZcA8Gz60yWSpkzZACei6a

Hi all,

i recently noticed that on my oldish Fujitsu Primergy Server with a C602 
SAS controller and SATA disks, I would get strange SMART results from 
smartctl:

=== START OF READ SMART DATA SECTION ===
SMART Status not supported: Incomplete response, ATA output registers 
missing
SMART overall-health self-assessment test result: PASSED
Warning: This result is based on an Attribute check.

instead of

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

The last known working kernel was 6.6.47, the first kernel where I noted 
the error messages was 6.6.62.

Additionally, when retrieving the SMART data, the kernel would log:

Nov 21 12:47:24 mischa kernel: sas: Enter sas_scsi_recover_host busy: 1 
failed: 1
Nov 21 12:47:24 mischa kernel: sas: ata3: end_device-0:2: cmd error handler
Nov 21 12:47:24 mischa kernel: sas: ata1: end_device-0:0: dev error handler
Nov 21 12:47:24 mischa kernel: sas: ata2: end_device-0:1: dev error handler
Nov 21 12:47:24 mischa kernel: sas: ata4: end_device-0:3: dev error handler
Nov 21 12:47:24 mischa kernel: sas: ata3: end_device-0:2: dev error handler
Nov 21 12:47:24 mischa kernel: sas: --- Exit sas_scsi_recover_host: 
busy: 0 failed: 1 tries: 1

Today, I was able to narrow the problem down to the following kernel 
patch, first introduced into 6.6.51:

 From 872f86e1757bbb0a334ee739b824e47c448f5ebc Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Tue, 2 Jul 2024 02:47:35 +0000
Subject: ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using 
result_tf

[ Upstream commit 816be86c7993d3c5832c3017c0056297e86f978c ]

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20240702024735.1152293-8-ipylypiv@google.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
  drivers/ata/libata-scsi.c | 21 +++++++++++++++++++++
  1 file changed, 21 insertions(+)

(limited to 'drivers/ata/libata-scsi.c')

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 27e0c87236ac04..c91f8746289f4a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -242,10 +242,17 @@ void ata_scsi_set_sense_information(struct 
ata_device *dev,
   */
  static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
  {
+    struct ata_device *dev = qc->dev;
      struct scsi_cmnd *cmd = qc->scsicmd;
      struct ata_taskfile *tf = &qc->result_tf;
      unsigned char *sb = cmd->sense_buffer;

+    if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+        ata_dev_dbg(dev,
+                "missing result TF: can't set ATA PT sense fields\n");
+        return;
+    }
+
      if ((sb[0] & 0x7f) >= 0x72) {
          unsigned char *desc;
          u8 len;
@@ -924,10 +931,17 @@ static void ata_to_sense_error(unsigned id, u8 
drv_stat, u8 drv_err, u8 *sk,
   */
  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
  {
+    struct ata_device *dev = qc->dev;
      struct scsi_cmnd *cmd = qc->scsicmd;
      struct ata_taskfile *tf = &qc->result_tf;
      u8 sense_key, asc, ascq;

+    if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+        ata_dev_dbg(dev,
+                "missing result TF: can't generate ATA PT sense data\n");
+        return;
+    }
+
      /*
       * Use ata_to_sense_error() to map status register bits
       * onto sense key, asc & ascq.
@@ -979,6 +993,13 @@ static void ata_gen_ata_sense(struct ata_queued_cmd 
*qc)
          ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
          return;
      }
+
+    if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+        ata_dev_dbg(dev,
+                "missing result TF: can't generate sense data\n");
+        return;
+    }
+
      /* Use ata_to_sense_error() to map status register bits
       * onto sense key, asc & ascq.
       */
-- 
cgit 1.2.3-korg

I reverted this patch on this system and the problem has gone away. I 
have not enough kernel debugging skills to dig deeper into it. Does 
anybody have ideas?

Thanks in advance
Christian

