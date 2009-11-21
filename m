From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Thin provisioning fixes
Date: Fri, 20 Nov 2009 21:45:20 -0500
Message-ID: <1258771524-26673-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: jens.axboe@oracle.com, james.bottomley@hansenpartnership.com, hch@infradead.org, willy@wil.cx, jgarzik@pobox.com, sandeen@redhat.com, rwheeler@redhat.com, linux-ide@vger.kernel.orgl
List-Id: linux-ide@vger.kernel.org

A few updates to the thin provisioning bits aimed at 2.6.33:

 - Block layer support for reporting whether reading previously
   discarded blocks returns zeroes or not.  Jens, this applies on
   top of the patch that you have already queued.

 - Updated SCSI disk thin provisioning support:

   - Reports TPRZ via the new block layer flag

   - Moved some of the discard detection to read_capacity_16 to
     accommodate TP devices that don't support Unmap and the
     block limits VPD

   James, this replaces my existing post-merge sd patch.

 - libata:

   - Translate DRAT and ZRAT to TPRZ (zeroed blocks after trim)

   - Report the maximum discard sectors in the block limits VPD

   - Fix a couple of problems in ata_set_lba_range_entries() that
     caused us to issue garbled trims


Interested parties can grab the tp branch from:

git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux-2.6-mkp.git

--
Martin K. Petersen      Oracle Linux Engineering





