Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05648383B;
	Wed,  2 Sep 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349878; cv=none; b=BODB1SD0546fvFDUrDzH7TR+EDbzdn19FYTMSjxSg74cprkhIe5d4X5LMYnc0yVQxAWbBDBAtNkKnl5/eSEHkKc6Pm5bViaau2reAmiGYobl6LutTlAAGT2jeMAyIWs/SOVcXYsDuvGFqKyOENDFvrJc3q5VGzgbJkkgxGp6M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349878; c=relaxed/simple;
	bh=pLYPKX29S9uqGmY6Sx9clSzTyWjn0MTP5dY9v95Ffz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZG909KKuxzt+sXUOh9StJoKnNHB5aehn8d7O7Vm/lnjEBuz5INOdvCVImN64PucS1hxHyhIQX7c1HRT7GzL79F3hkJEsWOjZ2plFtpCJoBZRNSJ/i0jGmAhSqZemaJhFw/aMbIpADiGNQy5/ta/7pDRNHauHLFHFwI2PRprsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8be8749aa6c411f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c8f2ea3f-cbd9-4480-ba2f-946524ebd00b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:28769ebc6fa078d7cd1051acf3c0229e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8be8749aa6c411f19a56ed5b684f684d-20260902
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 975071036; Wed, 02 Sep 2026 19:50:51 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shuangpeng.kernel@gmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 0/2] ata: pata_parport: fix UAF on protocol module unload
Date: Wed,  2 Sep 2026 19:50:25 +0800
Message-Id: <cover.1788349317.git.xiaopei01@kylinos.cn>
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

 drivers/ata/pata_parport/pata_parport.c | 27 +++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.25.1

