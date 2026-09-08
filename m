Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BC531B11;
	Tue,  8 Sep 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868070; cv=none; b=YOsQV6rX9Vbt3iYcLnkd0fmwmdr9IlXJUQ0Vs4cql1ym/DNEyfPykkSUFOm7ETUy9PaBdw4YPFkzHy9BL4svKk3vQbbHDIUug5ky1GrbrlZKvffEZN0RAyGk6z9Q4U1EgmqJa4v5Qq/eHsLJGwYYmsE0UPOjc1ZLNfmDXxFJ1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868070; c=relaxed/simple;
	bh=1U+N1Ns/Lf9TvGJixS7NaMGSRzmp2O8ivTkY/Pzdl6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfHTn/8MFJICd6sOi10GfcvBwJay+8fT4YXIc8e/IcLZQC8OAhq9+niRKEkuGEyEV5ANOgIhlQeCmPgld+wrsd6Z6nn8s4n/r++VzxdbXNBpGkH4xmvXEqRsnSaYrO5/P/D0CLi3BjrQ4yKb0pkzZQ7+nzYFORKb9mcYRUbgJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 13502bf2ab7b11f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b0082c63-06c8-4f86-8041-e79ea5e7efc4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:43031b9f34de78c825aeb3e2470fff37,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 13502bf2ab7b11f19a56ed5b684f684d-20260908
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 215187228; Tue, 08 Sep 2026 19:47:31 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 0/2] ata: pata_parport: fix UAF on protocol module unload
Date: Tue,  8 Sep 2026 19:47:26 +0800
Message-Id: <cover.1788867690.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes use-after-free issues in pata_parport when a protocol
module goes away while pi_adapter devices created by it are still
attached.

Patch 1 pins the protocol module before the device becomes visible.
Previously try_module_get() ran after device_register(), so a forced
module unload in between left pi->proto dangling from the moment the
device appeared on the bus.

Patch 2 makes pata_parport_unregister_driver() tear down all adapters
using the protocol. Without this, the rollback path of a multi-protocol
module init (e.g. kbic registering k951 then k971) left the devices of
the already-registered protocol alive while the module loader freed the
module memory; removing such a dangling device later crashed in
pi_disconnect() dereferencing pi->proto->disconnect.

Pei Xiao (2):
  ata: pata_parport: pin the protocol module before device_register()
  ata: pata_parport: unregister devices on protocol unregister

 drivers/ata/pata_parport/pata_parport.c | 28 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

