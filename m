From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 0/5 v2] pata_sis fixes and driver cleanup
Date: Wed,  7 Sep 2011 11:23:17 -0500
Message-ID: <1315412602-6560-1-git-send-email-dpmcgee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

This started as just two patches to use the correct UDMA 100 timings on
chipsets not supporting UDMA 133 but has grown a bit. This resubmit fixes the
following issues, much of them pointed out by Sergei Shtylyov:

* Ensure 0xC0 is used to mask, not 0xE0
* Move all 'static const' changes to separate patch
* Formatting cleanups- don't introduce new formatting issues, and add a patch
  to fix existing ones
* Comment referred to bit 14, but it is bit 30 as we grab a word, not two bytes
* Use dev_info(), not printk() directly
* Adjust commit message to include old commit summary

The first two patches are the critical ones that fix a regression between the
old IDE stack and the new (P)ATA one.

Dan McGee (5):
  pata_sis: extract a sis_port_base() method
  pata_sis: add mode_filter method for certain sis5513 chipsets
  pata_sis: enable MWDMA for UDMA 133 chipset
  pata_sis: mark most const data static as well
  pata_sis: code style cleanups for consistency

 drivers/ata/pata_sis.c |  154 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 99 insertions(+), 55 deletions(-)

$ python2 scripts/bloat-o-meter pata_sis.ko.old drivers/ata/pata_sis.ko
add/remove: 8/0 grow/shrink: 5/6 up/down: 313/-251 (62)
function                                     old     new   delta
static.sis_port_base                           -      83     +83
sis_133_mode_filter                            -      82     +82
static.udma_bits                               7      31     +24
sis_init_one                                 695     719     +24
static.timing133                               -      20     +20
static.timing100                               -      20     +20
static.timing_u133                            28      40     +12
static.timing_u100                            28      40     +12
static.mwdma_bits                              -      12     +12
sis_133_set_dmamode                          195     204      +9
static.recovery                                -       5      +5
static.actrec                                  -       5      +5
static.active                                  -       5      +5
sis_100_set_piomode                          129     111     -18
sis_old_set_dmamode                          192     171     -21
sis_100_set_dmamode                          156     134     -22
sis_old_set_piomode                          229     193     -36
sis_66_set_dmamode                           216     171     -45
sis_133_set_piomode                          265     156    -109

$ size pata_sis.ko.old drivers/ata/pata_sis.ko
   text    data     bss     dec     hex filename
   4524    2724       4    7252    1c54 pata_sis.ko.old
   4649    2724       4    7377    1cd1 drivers/ata/pata_sis.ko

-- 
1.7.6.1
