Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7991DEFFE
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247488; cv=none; b=VG6GNHolhICTA5oLJgcXCYBqn+io971/3XOvBmRYLjoQHpPb0j4i+Qw5kmOsdhHPXVg7bWyAtoy9fnuuasOVIBNZYePCvOcDgfxqPxG8/PUNwYOGoFwd9U64zQIIUfOK5ROzd02d3nmKc03KwEg3fuU7Y8XfU9ess4+4Jhw6EzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247488; c=relaxed/simple;
	bh=Jxb/h7nhP1+KJ84XkT+HT2CkPuA+m9GQntIcCt0qPTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJkGB1WeBENTQd3B0I7P2qg9xasa6Yq8Xo7oL5+SIyrg6P/y2NSF1IQDoDS93Q9gbl3xAhIyspReTLRiZF5Jjq87LmNRgcxsmo2a/rn8LvOYrEmhSDwECyeN7gKvHk58D0Uf1zkQcQWmA88yMVxFbSk95qdXwOyXBXSPzWIo52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=CnBfb4zm; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="CnBfb4zm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L3/pi9poONbhNYFsAZvpbp/jWzMuoJfy05ug+8OQXrg=; b=CnBfb4zmG4Mstcvjj9XegCRDHx
	SlAEMUc30bd47UmvGZWSXIQ4d1nTmnlnIz6Zd5TQTrp4YLPrmoH/Mb/CGeFrARSVk+ql0mWulaNUP
	iY9MjCMtapdl0iUVsd4h7uC5ailco3W51bVPv9kagq+ItozdYs6ldduTO0Sg0X4uXeb5B79likNO0
	XB9Z53N89h8aVQxCAFhGfN730RmwtR1GhVn3EkxI7FbOazTOKNueL1EEXXJxmJj3VC05X56tvckAk
	HG0P9ac61B2IoM8tEsISDrNrwSXUGUbGdoIh+6oYCN5xOKKIYPQo0h8J+L3WHqPy2ROpaYOUS0emI
	iaY/fV6L4kGBCpS8DdsaBr7j87UHvir6nO+4rCJeLZXXoFo8QmUKvGjNxjKv/YzcskvntYFt3dTyR
	RWsGmmPdFclec5xq+8eyh+VmI1dm4NrIp8NiBu51/5Z/qAbBGzB5DcWlK/A1/4eAG1SKROjOH7urF
	3CZN0IBQkt07gS5ATqVp0SmklG83l0mxbQKXj53GHv9AHvHMlOLKg/84EV+Fp3QMD3xJks3d0vh51
	vzOgVQBDMlMc0t0F7nQj6I6uhrvWuYAPdkL5FjB986YtM2WQXFkoh2S41zE4Eog50dAy/7oC3iO1o
	ntWo8kTMSq3Lzrn8pFo2yRWljsx2myHFcQccehe7E=;
Received: from [2a02:587:6a09:4a00:e434:6f7a:8bc0:eab1] (helo=localhost.localdomain)
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uFGt3-0000000BMeA-1Qad;
	Wed, 14 May 2025 21:31:25 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tasos Sahanidis <tasos@tasossah.com>
Subject: [PATCH] ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
Date: Wed, 14 May 2025 21:31:06 +0300
Message-ID: <20250514183107.152785-1-tasos@tasossah.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller has a hardware bug that can hard hang the system when
doing ATAPI DMAs without any trace of what happened. Depending on the
device attached, it can also prevent the system from booting.

In this case, the system hangs when reading the ATIP from optical media
with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
running at UDMA/33.

The issue can be reproduced by running the same command with a cygwin
build of cdrecord on WinXP, although it requires more attempts to cause
it. The hang in that case is also resolved by forcing PIO. It doesn't
appear that VIA has produced any drivers for that OS, thus no known
workaround exists.

HDDs attached to the controller do not suffer from any DMA issues.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
---
 drivers/ata/pata_via.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 696b99720dcb..11dce43c6b7c 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -368,7 +368,7 @@ static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
 	}
 
 	if (dev->class == ATA_DEV_ATAPI &&
-	    dmi_check_system(no_atapi_dma_dmi_table)) {
+	    (dmi_check_system(no_atapi_dma_dmi_table) || config->id == PCI_DEVICE_ID_VIA_6415)) {
 		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
 		mask &= ATA_MASK_PIO;
 	}
-- 
2.43.0

