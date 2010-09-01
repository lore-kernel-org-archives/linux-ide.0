From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: [PATCH] SSD quirking revisited
Date: Wed,  1 Sep 2010 15:54:55 -0400
Message-ID: <1283370896-3780-1-git-send-email-peter.petrakis@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40790 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab0IATzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2010 15:55:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>

The following patch was inspired by this thread:
http://marc.info/?l=linux-ide&m=126677421807814&w=2

The particular device that is causing me grief is
from Apacer. Ureadahead's runtime is significantly
affected, and hence the boot speed, depending on
whether a device is determined to be SSD.

Peter M. Petrakis (1):
  libata: SSD horkage introduction

 drivers/ata/libata-core.c |    5 +++++
 drivers/ata/libata-scsi.c |    9 +++++++--
 include/linux/libata.h    |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

