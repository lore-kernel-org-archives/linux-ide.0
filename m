From: Christoph Hellwig <hch@lst.de>
Subject: ZAC fixes
Date: Thu, 14 Jul 2016 09:05:41 +0900
Message-ID: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55679 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAF7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:05:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

Hi Tejun,

this series fixes ZAC support in libata.  The first half of it is
originally from Hannes, but I fixed up your small review comments
from the last run so that we can get it into 4.8.  That includes the
new patch 1 from me.  The last three patches are for Damien
and fix the SCSI to ATA for the REPORT ZONES command, they got some
minor cleanups from me as well.

