Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582E19D093
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625998; cv=none; b=qLILtFSuQgs5AmO+F+a4yWZS8URmMOET+WFWM/RyuZenJ6yJU66MBdiHbDLzmduLgSCpAh++VIuvo5ypplxPW0wfwBGaAKR4UDAPONyIyRK1J0b+tWZotZsTZC6pi5uMor8MyIXjDwEcdOTJSdYLUu+4jLFpNIMtyhp9RZuTT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625998; c=relaxed/simple;
	bh=G2F+/Ve8xUTXmmLK7aKpwTHYcbzhDfBocaFMpf0JC+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P61xF+p1NNUYkxKnqpBNh5lxP0yBiYJJ6kG4W441juvv1Ik/9L521VwKiacYDZ6EkQukHddoG/SpaYaXP3fBlLaiS3mlKIWoEmv00WEE2FREjOYS5CcR8HuD91qsA3H60Gb/lPtLuufaTSJnSrJSLkPq3MiJrLbNbbpdW5K3mWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK+slLoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK+slLoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B3C116C6;
	Fri, 20 Feb 2026 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771625998;
	bh=G2F+/Ve8xUTXmmLK7aKpwTHYcbzhDfBocaFMpf0JC+g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AK+slLoaxghTHQ6UtI1TZ33ZOXMG0JeA8WsIZF+qjGyYEyaexZ+XIddrOfh7grMSh
	 GllzIpGP70OEVwpXntBCSDu43xIK12ZVlkBePSVqi55eobdIZAVDhdcTuF6v6WhBYp
	 j+5olESwfc34ZoscTULK/zYESmePI3UscOBU9ItU602YyicNybXna59JpehIQDHDpG
	 XeXiDTLhgGbn8gfbVSW7TUr7xBElEGX/BHml9RrxGg8V02iYK51cGgcKmMnbjTI8JM
	 8dmTYCRbRh9GRMwCmCHisVMUCPIvWygVmsJrsdy+Axj/MeG1ud/j2hWlJlgCSromZ3
	 8nw96JHyfKLwg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/2] ata: libata-core: fix cancellation of a port deferred qc work
Date: Sat, 21 Feb 2026 07:14:39 +0900
Message-ID: <20260220221439.533771-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220221439.533771-1-dlemoal@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel_work_sync() is a sleeping function so it cannot be called with
the spin lock of a port being held. Move the call to this function in
ata_port_detach() after EH completes, with the port lock released,
together with other work cancellation calls.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beb6984b379a..d470b7bc92c7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6269,10 +6269,6 @@ static void ata_port_detach(struct ata_port *ap)
 		}
 	}
 
-	/* Make sure the deferred qc work finished. */
-	cancel_work_sync(&ap->deferred_qc_work);
-	WARN_ON(ap->deferred_qc);
-
 	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
@@ -6283,9 +6279,11 @@ static void ata_port_detach(struct ata_port *ap)
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
 
-	/* it better be dead now */
+	/* It better be dead now and not have any remaining deferred qc. */
 	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
+	WARN_ON(ap->deferred_qc);
 
+	cancel_work_sync(&ap->deferred_qc_work);
 	cancel_delayed_work_sync(&ap->hotplug_task);
 	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
-- 
2.53.0

