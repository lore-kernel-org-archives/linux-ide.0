From: Jeff Garzik <jgarzik@pobox.com>
Subject: libata: clustering on or off?
Date: Sun, 28 Aug 2005 05:42:18 -0400
Message-ID: <20050828094218.GA29145@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: axboe@suse.de
List-Id: linux-ide@vger.kernel.org


The constant ATA_SHT_USE_CLUSTERING in include/linux/libata.h controls
the use of SCSI layer's use_clustering feature, for a great many libata
drivers.

The current setup has clustering disabled, which in theory causes the
block layer to do less work, at the expense of a greater number of
scatter/gather table entries used.

Any opinions WRT turning on clustering for libata?

	Jeff



