From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] Asynchronous Notification for SATA ATAPI devices
Date: Wed, 28 Mar 2007 16:44:28 -0700
Message-ID: <20070328164428.716b4eae.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1696 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932853AbXC1Xq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 19:46:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

This patch series implements Asynchronous Notification (AN) for SATA ATAPI
devices as defined in SATA 2.5 and AHCI 1.1.  Drives which support this
feature will send a notification when new media is inserted into the
drive, preventing the need for user space to poll for new media.  This
support is exposed to user space via a file in sysfs (/sys/block/sr*)
called "media_change_events".  If the drive supports AN, this file will
read 1, otherwise 0.  User space can disable polling for new media if this
file reads 1.  When new media is inserted into the ATAPI drive, the ahci
driver will send a KOBJ_CHANGE event.

I would really like feedback on the user interface - both the location
of the sysfs file which indicates AN support, as well as the type of
uevent etc.  I have not yet tested AN on eject (I assume it doesn't require
anything special) as my test drive which supports AN is a bit "quirky" in 
this respect.  Please take a look and let me know what you think.

Thanks,
Kristen

-- 
