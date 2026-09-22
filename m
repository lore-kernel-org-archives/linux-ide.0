Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD2366045;
	Tue, 22 Sep 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048297; cv=none; b=hKjGoatuxsGog/FM6prpSvI9xf13XUSAhooopPjFC818OFtuHTtHZ3rOjHCg0o3/nlis/J+ocQOIzPdMF3MfJPLqHNmNqsX8bkjzm7g4IP5byL4904+rULhwG7F9+pzyyT6YENa41GE5YMFswS5o+8XR2xF26SOjbPXvpfpTXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048297; c=relaxed/simple;
	bh=R1r9fc+OJPAhMMLpeoyF5Y6aLu85T3voXbCez0Aye7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XIYrwWnJJuvhWWbj9EUpbz+FwsZGqUA3T44Ezhxj3tNdmceI52f+qZKBEMk06RZNAtC4KVsH74PzaFRjDRYur7JKHUMQRTs5aa8QPDiAgpA9g4xL6RpOyyLwu6utQZyMEhRw45u2A0SpQKX9ae1Mt4Dj4HILwxxcOyEQBCtWKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0562e2f2b63711f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7b37104c-bc86-4166-98ef-928c31a7b319,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:133f1bbb071214244da35170ef2ee710,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0562e2f2b63711f19a56ed5b684f684d-20260922
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 497339626; Tue, 22 Sep 2026 11:38:05 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v3 0/2] some fixes in pata_parport
Date: Tue, 22 Sep 2026 11:37:59 +0800
Message-Id: <cover.1790047457.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit

Patch 1 pins the protocol module before the device becomes visible.
Previously try_module_get() ran after device_register(), so a forced
module unload in between left pi->proto dangling from the moment the
device appeared on the bus.

Patch 2：fix parport attach idr_alloc for port numbers > 0

remove this patch:
https://lore.kernel.org/lkml/cec58ea83362df88f516ba7a5b895cf07edd7728.1788867690.git.xiaopei01@kylinos.cn/#t

I have become cautious now, for fear of causing a disaster, so I removed
this patch. The other patches sent this time have undergone simple
compilation tests and simple tests such as rmmod. Since I don't have the
relevant hardware to test this patch, out of caution, I removed it this
time.

in v3:
1.ata: pata_parport: pin the protocol module before device_register() no
  changes
2.Add ata: pata_parport: fix parport attach for port numbers > 0
 
Pei Xiao (2):
  ata: pata_parport: pin the protocol module before device_register()
  ata: pata_parport: fix parport attach for port numbers > 0

 drivers/ata/pata_parport/pata_parport.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.25.1

