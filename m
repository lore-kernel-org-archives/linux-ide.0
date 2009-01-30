From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 00/07] sata_mv: ATAPI patchset
Date: Fri, 30 Jan 2009 18:45:11 -0500
Message-ID: <49839107.2040603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:48386 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbZA3XpN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:45:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

The following patchset adds ATAPI capability to sata_mv.
These patches are all for #upstream.

01_sata_mv_cleanup_flags.patch
02_sata_mv_edma_cfg.patch
03_sata_mv_qc_issue.patch
04_sata_mv_get_active_qc.patch
05_sata_mv_fill_sg.patch
06_sata_mv_atapi_dma.patch
07_sata_mv_optimize_edma_cfg_use.patch

Cheers
