From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 0/3] ahci controller runtime PM support
Date: Tue, 27 Dec 2011 13:42:31 +0800
Message-ID: <1324964554-9719-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14992 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab1L0Fmu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Dec 2011 00:42:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

Hi all,

Here is the v2 patches to add ahci controller runtime PM support.
Applied on top of linux-next tree.

Thanks for any comments.

v2:
- add ahci hibernate callbacks

v1:
https://lkml.org/lkml/2011/12/15/198

Lin Ming (3):
      ahci: port legacy pm interface to struct dev_pm_ops
      ahci: add runtime PM callbacks
      ata: runtime suspend port if no device attached

 drivers/ata/ahci.c        |   71 +++++++++++++++++++++++++++++++++++++++-----
 drivers/ata/libata-core.c |   21 ++++++++++++-
 2 files changed, 83 insertions(+), 9 deletions(-)

