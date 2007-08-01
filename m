From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] Updated ALPM patches
Date: Wed, 1 Aug 2007 14:28:37 -0700
Message-ID: <20070801142837.2dabed87.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: jeff@garzik.org
Cc: james.bottomley@steeleye.com, linux-scsi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, arjan@linux.intel.com
List-Id: linux-ide@vger.kernel.org

Hi,
This is an updated series of ALPM patches.  I moved all link power management
stuff out of scsi sysfs and just use the shost_addr pointer in the host
template to create the sysfs files.  This provides the same interface
as before, without requiring any scsi changes.  I also fixed a bug in
the handling of the interrupts for some devices (mostly ATAPI it seems)
which will need some bits out of Serror cleared on power state changes,
and I also modified the code slightly based on feedback from tejun.

please review,
Thanks,
Kristen

-- 
