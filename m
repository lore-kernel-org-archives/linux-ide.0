Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE9374722
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659808; cv=none; b=IhAog8Xcqtzl4tCmHQX6bZpzGdeSsHONzmXDKoeO1NJ4vs0ErvM22Yr0TDJOoQJNir1SACMEc0trHU/SO5eTNNjr99X2tAFLhh7tvq6n6D9xQ3GwHwtg31gu/HSUA/23lXHV8wVZEyeMi1XbjUOdmROn6XHa5J43dAHxssf1PNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659808; c=relaxed/simple;
	bh=2s1R6O7UtM3CD047Ee9g1XF2f39+jW8r3Vb5hcT6lBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqQE3n4LpUztDjxGoSJ1TQ2jHcO48vNg50OFJQ6aTkcdFpCUeIqWB1l7Fsdeaxk+MKG2zv6JuOBz1IURUQwcms/Y9fJJVsCVdjmJBwGHM0FtCH+Rd+wAdW4AmDpE44ASjQ1aEYcVDjBPjYorbTm85eXDukjzezRsfQ6WzvrRpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbqg6vlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbqg6vlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D74C2BCB7;
	Wed, 13 May 2026 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778659807;
	bh=2s1R6O7UtM3CD047Ee9g1XF2f39+jW8r3Vb5hcT6lBc=;
	h=From:To:Cc:Subject:Date:From;
	b=Lbqg6vlS3ZR7jWu6Olt5imbbj9zgMYvKpZqBGvDeVRtoeJ4wFrNM89yDROEf53ltS
	 kJ2ZkfAyaZxScK6kZbenLiOK8+v83j5k1jrJWRRrcwH3CDRHOziSt0F+15xLlTnV2F
	 f32EccoAVxa0hx73PpXK9t+YlzMVUN1CFMFPK9f5e/oKfA5wQLPC7EtIci0ajIuIxU
	 blT2wopWapGzzi01MusZeRSms/+HBc4mPY8NHT6O9J2nj4iooWeRdwbZy7gjBK/tia
	 LBwf+ZBSpY1/T0D2S/o9/mRwE3Kimo+VqgTYSiTz2BVFMGoj4c+QZFjL7ByemC5qAz
	 kuJPzOZwduoPw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-eh: queue hotplug work on the system_dfl_long_wq workqueue
Date: Wed, 13 May 2026 10:10:01 +0200
Message-ID: <20260513081001.714630-2-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=cassel@kernel.org; h=from:subject; bh=2s1R6O7UtM3CD047Ee9g1XF2f39+jW8r3Vb5hcT6lBc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYDG8+zgvU/fzqicKivuqwdd9y5C+tKpe+8qmr4ewfO z3HzTqiHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI2SxGho/uEq+fX1A2OBgS IqS6v+/Padf+t5Xxz2dsZlhT2iPlfoGR4VKMXdM/nuj3dS9uVDCt8L0WWLZev8X/9enJGXk7tW+ p8AIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_port_error_handler() uses schedule_delayed_work() to queue
the ap->hotplug_task work.

schedule_delayed_work() always uses the system_percpu_wq per-cpu
workqueue.

ata_scsi_scan_host() queues the ap->hotplug_task work on the unbound
system_dfl_long_wq workqueue.

It seems counter-intuitive to queue the same work on two different
workqueues. Thus, change ata_scsi_port_error_handler() to also queue
the ap->hotplug_task work on the system_dfl_long_wq workqueue, such
that the work is always queued on the same workqueue.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9a4b67b90b17..6cb79a09423d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -819,7 +819,7 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
 	else if ((ap->pflags & ATA_PFLAG_SCSI_HOTPLUG) &&
 		!(ap->flags & ATA_FLAG_SAS_HOST))
-		schedule_delayed_work(&ap->hotplug_task, 0);
+		queue_delayed_work(system_dfl_long_wq, &ap->hotplug_task, 0);
 
 	if (ap->pflags & ATA_PFLAG_RECOVERED)
 		ata_port_info(ap, "EH complete\n");
-- 
2.54.0

