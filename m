From: Douglas Gilbert <dougg@torque.net>
Subject: [PATCH 0/3] libata: scsi error handling, encore
Date: Sun, 09 Oct 2005 22:23:36 +1000
Message-ID: <43490BC8.9060504@torque.net>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com, russb@emc.com
List-Id: linux-ide@vger.kernel.org

This is a series of patches that are equivalent to
one sent on 2005/09/19:
"[PATCH] libata: scsi error handling, lk 2.6.14-rc1"
http://marc.theaimsgroup.com/?l=linux-scsi&m=112711945709949&w=2

The aim is to build more general sense buffers for SCSI
errors detected in the SCSI ATA translation layer in libata.
These patches are against Jeff's libata-dev git repository,
upstream branch.
Patch 1:  adds ata_scsi_set_sense() extern declaration and
          definition
Patch 2:  switch error processing in libata-scsi.c to use
          ata_scsi_set_sense()
Patch 3:  remove static inline definitions in libata.h that
          are no longer used after patch 2

Signed-off-by: Douglas Gilbert <dougg@torque.net>

Doug Gilbert

