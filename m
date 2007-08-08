From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/4] Updated AN patches, now without gendisk
Date: Wed, 8 Aug 2007 12:07:39 -0700
Message-ID: <20070808120739.c3097d19.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38426 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764111AbXHHTKb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 15:10:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: James.Bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hello,
Here is an updated set of patches that implement Asynchronous Notification
support for ATAPI devices.  In this version I no longer export the AN
capability through genhd, and the uevent is sent by the scsi_device 
instead of gendisk.  I added a generic SCSI device event mechanism so
that it can be expanded in the future with other types of events.  Please
let me know what you think.

Kristen
-- 
