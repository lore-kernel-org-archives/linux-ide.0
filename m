From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream] libata-sff: remainder of separate-out-SFF-and-BMDMA-take2
Date: Wed, 19 May 2010 22:10:18 +0200
Message-ID: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45397 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab0ESUKf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:10:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Hello, Jeff.

The followings are the refreshed left over patches from
separate-out-SFF-and-BMDMA-take2.

 0001-sata_mv-drop-unncessary-EH-callback-resetting.patch
 0002-libata-sff-ata_sff_irq_clear-is-BMDMA-specific.patch
 0003-libata-sff-separate-out-BMDMA-irq-handler.patch
 0004-libata-sff-separate-out-BMDMA-init.patch
 0005-libata-sff-kill-dummy-BMDMA-ops-from-sata_qstor-and-.patch
 0006-libata-sff-make-BMDMA-optional.patch

0001 is the sata_mv part lost during merge.  0002-0006 are 0019-0023
refreshed against the current #upstream.

Thanks.

--
tejun
