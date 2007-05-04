From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/7] Asynchronous Notification for ATAPI devices (v2) -
 resend
Date: Fri, 4 May 2007 11:12:22 -0700
Message-ID: <20070504111222.c2e373cf.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11277 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031488AbXEDSOx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 May 2007 14:14:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com, akpm@linux-foundation.org

This patch series implements Asynchronous Notification (AN) for SATA
ATAPI devices as defined in SATA 2.5 and AHCI 1.1 and higher.  Drives
which support this feature will send a notification when new media is
inserted and removed, preventing the need for user space to poll for
new media.  This support is exposed to user space via a flag that will
be set in /sys/block/sr*/capability_flags.  If the flag is set, user
space can disable polling for the new media, and the genhd driver will
send a KOBJ_CHANGE event with the envp set to MEDIA_CHANGE_EVENT=1.

Note that this patch only implements support for directly attached
drives - AN with drives attached to a port multiplier requires 
additional changes.

Thanks!
Kristen

-- 
-- 
