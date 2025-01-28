Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3C1A00F2
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068962; cv=none; b=M6yq49mk3fcKnTEH158StDYfflnWmlviomGzLYVl+k18vqlrxOJ9CQSAsrwo8rb6LjT1vM0c62dYaR6UTtcicRLKXbyRkIbQYYMZYecb8YjzUJFv6GSGTPtrqVPOj5Oew0emyuIXAH/Upe3ywQaPuiCPnxg3neM4NI4evzofcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068962; c=relaxed/simple;
	bh=e7AJPUW21yQXHz2l9fw+WCyTwJG8VhWl4g1ph7ank6Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GKFQ8JDyl+6q8BoLdsVv5jP3Os/Z1kpvchNR6VSviJcl69zqcwmmy3hOSRxoXOqoqwu1tpgSqF7X5PSJgCVM50B87atYV319u80e9BRWH4Q6EKN1f67Vm15+lFsYht9IhKoJMnRZZvh8mijJji7pen99HahwHpzpK5ph3BZlAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de; spf=pass smtp.mailfrom=kuehnke.de; dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b=W0RI6SDQ; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kuehnke.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuehnke.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuehnke.de header.i=@kuehnke.de header.b="W0RI6SDQ"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Yj4nN0g0Mz671y
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 13:47:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kuehnke.de; s=key2;
	t=1738068456; bh=e7AJPUW21yQXHz2l9fw+WCyTwJG8VhWl4g1ph7ank6Q=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=W0RI6SDQXqMsHE3ASZAe0BWCKGatCjowkw+K2kSRb3ayxOMP8T8uGYLObmow8E6/j
	 C7XBb8p07c9rgQIYhTHb1f1/Q1r8oX7V4s+Wdyj/8VawsWw2/3CSSpbga2YdiifxzL
	 u93/FUr3Nf46c4R1QumKwrjKfeQVUcxyz0T1SoPdMlJnM7YqAuKwfyHaZjfx70FZrx
	 2zY13/sMMBmorxjAjiXH18wEr6VRYzrE1gjDQVaKeGAJm84GgjowDTInhql/VcvuXL
	 5Ej64yqFzeUXhybOZ4GslqfIwpt4q5yRkvswP0914mxT77529iYT0gHPI7aYG8cLC7
	 fF/Kh+kEiRaVg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Yj4nM73R2z4xl8
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 13:47:35 +0100 (CET)
Received: from mx2f74.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Yj4nM5K9Tz8scM
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 13:47:35 +0100 (CET)
Received: from [192.168.3.2] (p4feab3aa.dip0.t-ipconnect.de [79.234.179.170])
	by mx2f74.netcup.net (Postfix) with ESMTPSA id 32F9420C1F
	for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2025 13:47:31 +0100 (CET)
Authentication-Results: mx2f74;
        spf=pass (sender IP is 79.234.179.170) smtp.mailfrom=christian@kuehnke.de smtp.helo=[192.168.3.2]
Received-SPF: pass (mx2f74: connection is authenticated)
Message-ID: <f437dee3-4236-4146-bd91-abb6f611874f@kuehnke.de>
Date: Tue, 28 Jan 2025 13:47:25 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems while retrieving SMART information via C602 SAS
 controller since 6.6.51
From: =?UTF-8?Q?Christian_K=C3=BChnke?= <christian@kuehnke.de>
To: linux-ide@vger.kernel.org
References: <1c79066a-9349-4f65-9ef2-dba4cf12361a@kuehnke.de>
In-Reply-To: <1c79066a-9349-4f65-9ef2-dba4cf12361a@kuehnke.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173806845146.29772.17524731626035717460@mx2f74.netcup.net>
X-Rspamd-Queue-Id: 32F9420C1F
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: aYyF0kamrgnaBIKaDLCitorht09KGDF14ZvgLHZZ5XEHlRI0

I think, I found the root cause.

Kernel 6.12.11 and Kernel 6.13 do _not_ exhibit the problem and to my 
untrained eye, the affected layer has been reworked quite a bit in these 
versions.

After reviewing the mailing list archives and the kernel commit logs I 
suspect the following patch is missing from the kernel 6.6 stable 
series. It was developed by Igor together with the patches to 
libata-sata, but it did not make it into the 6.6 stable branch of 
offical kernel.

After applying this to 6.6.74, that version also works like a charm 
(without backing out the libata-sata patch).

 From 18676c6aab0863618eb35443e7b8615eea3535a9 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Tue, 2 Jul 2024 02:47:34 +0000
Subject: ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20240702024735.1152293-7-ipylypiv@google.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
  drivers/ata/libata-core.c | 8 ++++++++
  1 file changed, 8 insertions(+)

(limited to 'drivers/ata/libata-core.c')

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f35aab81a0a38..45e3acb466c32a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4794,8 +4794,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
  {
  	struct ata_port *ap = qc->ap;
  
+	/*
+	 * rtf may already be filled (e.g. for successful NCQ commands).
+	 * If that is the case, we have nothing to do.
+	 */
+	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
+		return;
+
  	qc->result_tf.flags = qc->tf.flags;
  	ap->ops->qc_fill_rtf(qc);
+	qc->flags |= ATA_QCFLAG_RTF_FILLED;
  }
  
  static void ata_verify_xfer(struct ata_queued_cmd *qc)
-- 
cgit 1.2.3-korg

Am 28.01.2025 um 12:14 schrieb Christian Kühnke:
> Hi all,
>
> i recently noticed that on my oldish Fujitsu Primergy Server with a 
> C602 SAS controller and SATA disks, I would get strange SMART results 
> from smartctl:
>
