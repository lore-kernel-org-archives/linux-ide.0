From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE updates part #3
Date: Fri, 1 Feb 2008 23:49:22 +0100
Message-ID: <200802012349.23211.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:18348 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327AbYBAWhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 17:37:19 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1351438wra.23
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 14:37:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


IDE updates continued...

* ide-cd rewrite (fix few bugs, unify IRQ handlers, re-organize handlin=
g
  of quirky devices, move verbose error logging / cdrom.c IOCTLs suppor=
t
  to separate files, remove duplicated/dead code and other improvements=
)

* switch IDE to use generic DMA-mapping API

* IDE probing code revamp

* trm290 host driver fixes

* amd74xx host driver cleanup

* misc stuff

[ + this update shrinks code under drivers/ide/ by almost 1400 LOC :) ]


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 Documentation/ide/ChangeLog.ide-cd.1994-2004     |  268 +++
 Documentation/ide/ChangeLog.ide-floppy.1996-2002 |   63 +
 drivers/cdrom/cdrom.c                            |    6 -
 drivers/ide/Kconfig                              |   55 +-
 drivers/ide/Makefile                             |    4 +-
 drivers/ide/arm/bast-ide.c                       |    3 +-
 drivers/ide/arm/icside.c                         |   50 +-
 drivers/ide/arm/rapide.c                         |    6 +-
 drivers/ide/cris/ide-cris.c                      |    3 +-
 drivers/ide/h8300/ide-h8300.c                    |    1 -
 drivers/ide/ide-acpi.c                           |    1 -
 drivers/ide/ide-cd.c                             | 2333 +++++---------=
--------
 drivers/ide/ide-cd.h                             |  706 +------
 drivers/ide/ide-cd_ioctl.c                       |  475 +++++
 drivers/ide/ide-cd_verbose.c                     |  359 ++++
 drivers/ide/ide-disk.c                           |   11 +-
 drivers/ide/ide-dma.c                            |  110 +-
 drivers/ide/ide-floppy.c                         |  122 +--
 drivers/ide/ide-io.c                             |    2 +-
 drivers/ide/ide-iops.c                           |    4 +-
 drivers/ide/ide-lib.c                            |    6 +-
 drivers/ide/ide-pnp.c                            |    2 -
 drivers/ide/ide-probe.c                          |  190 +-
 drivers/ide/ide-proc.c                           |    2 -
 drivers/ide/ide-scan-pci.c                       |    9 +-
 drivers/ide/ide-tape.c                           |   80 +-
 drivers/ide/ide-taskfile.c                       |   12 +-
 drivers/ide/ide-timing.h                         |    2 -
 drivers/ide/ide.c                                |  116 +-
 drivers/ide/legacy/ali14xx.c                     |    2 -
 drivers/ide/legacy/buddha.c                      |    2 +-
 drivers/ide/legacy/dtc2278.c                     |    2 -
 drivers/ide/legacy/falconide.c                   |    3 +-
 drivers/ide/legacy/gayle.c                       |    2 +-
 drivers/ide/legacy/ht6560b.c                     |    2 -
 drivers/ide/legacy/ide-cs.c                      |    2 -
 drivers/ide/legacy/ide_platform.c                |   34 +-
 drivers/ide/legacy/macide.c                      |    2 +-
 drivers/ide/legacy/q40ide.c                      |    2 +-
 drivers/ide/legacy/qd65xx.c                      |    2 -
 drivers/ide/legacy/qd65xx.h                      |    2 -
 drivers/ide/legacy/umc8672.c                     |    2 -
 drivers/ide/mips/au1xxx-ide.c                    |   43 +-
 drivers/ide/pci/aec62xx.c                        |   11 +-
 drivers/ide/pci/alim15x3.c                       |   20 +-
 drivers/ide/pci/amd74xx.c                        |  281 ++--
 drivers/ide/pci/atiixp.c                         |   11 +-
 drivers/ide/pci/cmd640.c                         |    2 -
 drivers/ide/pci/cmd64x.c                         |   20 +-
 drivers/ide/pci/cs5520.c                         |    2 +-
 drivers/ide/pci/cs5530.c                         |    2 -
 drivers/ide/pci/cs5535.c                         |    6 +-
 drivers/ide/pci/cy82c693.c                       |    7 +-
 drivers/ide/pci/delkin_cb.c                      |    4 +-
 drivers/ide/pci/generic.c                        |    5 +-
 drivers/ide/pci/hpt34x.c                         |    6 +-
 drivers/ide/pci/hpt366.c                         |   33 +-
 drivers/ide/pci/it8213.c                         |    7 +-
 drivers/ide/pci/it821x.c                         |   50 +-
 drivers/ide/pci/jmicron.c                        |    2 +-
 drivers/ide/pci/ns87415.c                        |   20 +-
 drivers/ide/pci/opti621.c                        |    2 -
 drivers/ide/pci/pdc202xx_new.c                   |    6 +-
 drivers/ide/pci/pdc202xx_old.c                   |   17 +-
 drivers/ide/pci/piix.c                           |   55 +-
 drivers/ide/pci/rz1000.c                         |    4 +-
 drivers/ide/pci/sc1200.c                         |   14 +-
 drivers/ide/pci/scc_pata.c                       |   13 +-
 drivers/ide/pci/serverworks.c                    |   24 +-
 drivers/ide/pci/sgiioc4.c                        |   19 +-
 drivers/ide/pci/siimage.c                        |   53 +-
 drivers/ide/pci/sis5513.c                        |   24 +-
 drivers/ide/pci/sl82c105.c                       |   19 +-
 drivers/ide/pci/slc90e66.c                       |    9 +-
 drivers/ide/pci/tc86c001.c                       |    5 +-
 drivers/ide/pci/triflex.c                        |    4 +-
 drivers/ide/pci/trm290.c                         |   65 +-
 drivers/ide/pci/via82cxxx.c                      |   15 +-
 drivers/ide/ppc/mpc8xx.c                         |    2 -
 drivers/ide/ppc/pmac.c                           |   39 +-
 drivers/ide/setup-pci.c                          |   94 +-
 drivers/scsi/ide-scsi.c                          |    5 +-
 include/asm-mips/mach-au1x00/au1xxx_ide.h        |    1 -
 include/linux/cdrom.h                            |   14 +
 include/linux/hdsmart.h                          |    2 +
 include/linux/ide.h                              |   40 +-
 86 files changed, 2549 insertions(+), 3588 deletions(-)
 create mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
 create mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
 create mode 100644 drivers/ide/ide-cd_ioctl.c
 create mode 100644 drivers/ide/ide-cd_verbose.c


Adrian Bunk (4):
      ide: unexport ide_dma_on
      ide: small ide-scan-pci.c cleanup
      ide: make wait_drive_not_busy() static again
      ide/ppc/pmac.c section fixes

Bartlomiej Zolnierkiewicz (90):
      ide-cd: use xfer_func_t in cdrom_pc_intr()
      ide-cd: add ide_cd_pad_transfer() helper
      ide-cd: fix "missing data" handling in cdrom_pc_intr()
      ide-cd: fix DMA error handling in cdrom_newpc_intr()
      ide-cd: fix trailing whitespaces in changelog
      ide-cd: move historical changelog to Documentation/ide/ChangeLog.=
ide-cd.1994-2004
      ide-cd: remove stale cdrom_transfer_packet_command() comment
      ide-cd: remove unused defines from ide-cd.h
      ide-cd: remove dead code from cdrom_pc_intr()
      ide-cd: remove unused struct atapi_cdrom_subchnl
      ide-cd: remove needless zeroing of 'info' fields from ide_cdrom_s=
etup()
      ide-cd: remove unused and write-only struct ide_cd_config_flags f=
ields
      ide-cd: remove struct atapi_{mechstat_header,changer_info,slot}
      ide-cd: cleanup ide_cdrom_update_speed()
      ide-cd: add IDE_CD_CAPABILITIES define
      ide-cd: remove redundant config flags
      ide-cd: kill CDROM_CONFIG_FLAGS() macro
      ide-cd: kill CDROM_STATE_FLAGS() macro
      ide-cd: remove struct atapi_capabilities_page (take 2)
      ide-cd: remove struct ide_cd_{config,state}_flags
      ide-cd: remove NO_DOOR_LOCKING define
      ide-cd: remove STANDARD_ATAPI define
      ide-cd: use BCD2BIN()/BIN2BCD() macros from <linux/bcd.h>
      ide-cd: re-organize handling of quirky devices
      ide-cd: remove duplicate sense keys definitions from ide-cd.h
      ide-cd: coding style fixes for VERBOSE_IDE_CD_ERRORS code
      ide-cd: move VERBOSE_IDE_CD_ERRORS code to ide-cd_verbose.c
      ide-cd: factor out ioctl handlers from ide_cdrom_audio_ioctl()
      ide-cd: merge cdrom_play_audio() into ide_cd_fake_play_trkind()
      ide-cd: merge cdrom_read_subchannel() into ide_cdrom_get_mcn()
      ide-cd: merge cdrom_select_speed() into ide_cdrom_select_speed()
      ide-cd: move lba_to_msf() and msf_to_lba() to <linux/cdrom.h>
      ide-cd: coding style fixes for cdrom_get_toc_entry()
      ide-cd: rename cdrom_* functions to ide_cd_*
      ide-cd: move code handling cdrom.c IOCTLs to ide-cd_ioctl.c
      ide-cd: remove BUG_ON() from cdrom_newpc_intr()
      ide-cd: call blk_dump_rq_flags() on "missing data" in cdrom_newpc=
_intr()
      ide-cd: factor out request sense fixup from cdrom_pc_intr()
      ide-cd: unify request end exit path in cdrom_pc_intr()
      ide-cd: merge cdrom_pc_intr() and cdrom_newpc_intr()
      ide-cd: remove cdrom_do_pc_continuation()
      ide-cd: merge cdrom_do_packet_command() and cdrom_do_block_pc()
      ide-cd: add ide_cd_drain_data() helper
      ide-cd: factor out transfer size checking from cdrom_read_intr()
      ide-cd: merge cdrom_read_intr() and cdrom_write_intr()
      ide-cd: merge cdrom_start_read_continuation() and cdrom_start_rw_=
cont()
      ide-cd: merge cdrom_start_read() and cdrom_start_write()
      ide-cd: unify moving to the next buffer in cdrom_rw_intr()
      ide-cd: prepare cdrom_rw_intr() and cdrom_newpc_intr() to be merg=
ed
      ide-cd: call blk_dump_rq_flags() on "missing data" in cdrom_rw_in=
tr()
      ide-cd: merge cdrom_rw_intr() and cdrom_newpc_intr()
      ide-cd: merge cdrom_write_check_ireason() and cdrom_read_check_ir=
eason()
      ide-cd: unify request end exit path in cdrom_decode_status()
      ide-cd: update driver version, comments and copyrights
      ide: add ide_dump_identify() debug helper
      ide-{floppy,tape}: remove debug code for dumping identify data
      amd74xx: remove amd_ide_chips table
      ide: add IDE_HFLAG_CLEAR_SIMPLEX host flag
      ide: add IDE_HFLAG_NO_DSC host flag
      piix: remove stale comments
      ide: fix ide_intr() for non-PCI devices and CONFIG_BLK_DEV_IDEPCI=
=3Dy
      ide: remove BUG_ON() from ide_build_sglist()
      ide: use ide_destroy_dmatable() instead of pci_unmap_sg() (take 2=
)
      ide: keep pointer to struct device instead of struct pci_dev in i=
de_hwif_t
      au1xxx-ide: use hwif->dev
      icside: use hwif->dev
      ide: switch to DMA-mapping API
      ide: use ide_build_sglist() and ide_destroy_dmatable() in non-PCI=
 host drivers
      au1xxx-ide: device tree bugfix
      ide-pmac: macio resource freeing bugfix
      au1xxx-ide/rapide: use hwif->index for ide_unregister()
      ide: delete filenames/versions from comments
      ide: update/add my Copyrights
      ide: don't include <linux/hdsmart.h>
      <linux/hdsmart.h> is not used by kernel code
      ide: fix handling of busy I/O resources in probe_hwif()
      ide: move wait_hwif_ready() documentation in the right place
      ide: remove hwif->present manipulations from hwif_init()
      ide_platform: remove struct hwif_prop
      ide: remove unused ide_hwgroup_t fields
      ide: remove needless zeroing of hwgroup fields from init_irq()
      ide: cleanup ide_system_bus_speed()
      ide: I/O resources are released too early in ide_unregister()
      ide: factor out code removing port from hwgroup from ide_unregist=
er()
      ide: prepare init_irq() for using ide_remove_port_from_hwgroup()
      ide: use ide_remove_port_from_hwgroup in init_irq()
      ide: make probe_hwif() return an error value
      ide: move handling of I/O resources out of ide_probe_port()
      ide: factor out code for tuning devices from ide_probe_port()
      ide: move hwif_register() call out of ide_probe_port()

Borislav Petkov (2):
      ide-cd: move the remaining cdrom.c ioctl handling code to ide-cd_=
ioctl.c
      ide-floppy: cleanup header

=46rans Pop (1):
      ide/Kconfig: use 'on-board' instead of 'built-in' in config optio=
ns

Geert Uytterhoeven (1):
      Atari Falcon IDE: Add missing hwif variable

Sergei Shtylyov (2):
      trm290: cannot call ide_setup_dma()
      ide: ide_setup_dma() assumes 8 ports


diff --git a/Documentation/ide/ChangeLog.ide-cd.1994-2004 b/Documentati=
on/ide/ChangeLog.ide-cd.1994-2004
new file mode 100644
index 0000000..190d17b
--- /dev/null
+++ b/Documentation/ide/ChangeLog.ide-cd.1994-2004
@@ -0,0 +1,268 @@
+/*
+ * 1.00  Oct 31, 1994 -- Initial version.
+ * 1.01  Nov  2, 1994 -- Fixed problem with starting request in
+ *                       cdrom_check_status.
+ * 1.03  Nov 25, 1994 -- leaving unmask_intr[] as a user-setting (as f=
or disks)
+ * (from mlord)       -- minor changes to cdrom_setup()
+ *                    -- renamed ide_dev_s to ide_drive_t, enable irq =
on command
+ * 2.00  Nov 27, 1994 -- Generalize packet command interface;
+ *                       add audio ioctls.
+ * 2.01  Dec  3, 1994 -- Rework packet command interface to handle dev=
ices
+ *                       which send an interrupt when ready for a comm=
and.
+ * 2.02  Dec 11, 1994 -- Cache the TOC in the driver.
+ *                       Don't use SCMD_PLAYAUDIO_TI; it's not include=
d
+ *                       in the current version of ATAPI.
+ *                       Try to use LBA instead of track or MSF addres=
sing
+ *                       when possible.
+ *                       Don't wait for READY_STAT.
+ * 2.03  Jan 10, 1995 -- Rewrite block read routines to handle block s=
izes
+ *                       other than 2k and to move multiple sectors in=
 a
+ *                       single transaction.
+ * 2.04  Apr 21, 1995 -- Add work-around for Creative Labs CD220E driv=
es.
+ *                       Thanks to Nick Saw <cwsaw@pts7.pts.mot.com> f=
or
+ *                       help in figuring this out.  Ditto for Acer an=
d
+ *                       Aztech drives, which seem to have the same pr=
oblem.
+ * 2.04b May 30, 1995 -- Fix to match changes in ide.c version 3.16 -m=
l
+ * 2.05  Jun  8, 1995 -- Don't attempt to retry after an illegal reque=
st
+ *                        or data protect error.
+ *                       Use HWIF and DEV_HWIF macros as in ide.c.
+ *                       Always try to do a request_sense after
+ *                        a failed command.
+ *                       Include an option to give textual description=
s
+ *                        of ATAPI errors.
+ *                       Fix a bug in handling the sector cache which
+ *                        showed up if the drive returned data in 512 =
byte
+ *                        blocks (like Pioneer drives).  Thanks to
+ *                        Richard Hirst <srh@gpt.co.uk> for diagnosing=
 this.
+ *                       Properly supply the page number field in the
+ *                        MODE_SELECT command.
+ *                       PLAYAUDIO12 is broken on the Aztech; work aro=
und it.
+ * 2.05x Aug 11, 1995 -- lots of data structure renaming/restructuring=
 in ide.c
+ *                       (my apologies to Scott, but now ide-cd.c is i=
ndependent)
+ * 3.00  Aug 22, 1995 -- Implement CDROMMULTISESSION ioctl.
+ *                       Implement CDROMREADAUDIO ioctl (UNTESTED).
+ *                       Use input_ide_data() and output_ide_data().
+ *                       Add door locking.
+ *                       Fix usage count leak in cdrom_open, which hap=
pened
+ *                        when a read-write mount was attempted.
+ *                       Try to load the disk on open.
+ *                       Implement CDROMEJECT_SW ioctl (off by default=
).
+ *                       Read total cdrom capacity during open.
+ *                       Rearrange logic in cdrom_decode_status.  Issu=
e
+ *                        request sense commands for failed packet com=
mands
+ *                        from here instead of from cdrom_queue_packet=
_command.
+ *                        Fix a race condition in retrieving error inf=
ormation.
+ *                       Suppress printing normal unit attention error=
s and
+ *                        some drive not ready errors.
+ *                       Implement CDROMVOLREAD ioctl.
+ *                       Implement CDROMREADMODE1/2 ioctls.
+ *                       Fix race condition in setting up interrupt ha=
ndlers
+ *                        when the `serialize' option is used.
+ * 3.01  Sep  2, 1995 -- Fix ordering of reenabling interrupts in
+ *                        cdrom_queue_request.
+ *                       Another try at using ide_[input,output]_data.
+ * 3.02  Sep 16, 1995 -- Stick total disk capacity in partition table =
as well.
+ *                       Make VERBOSE_IDE_CD_ERRORS dump failed comman=
d again.
+ *                       Dump out more information for ILLEGAL REQUEST=
 errs.
+ *                       Fix handling of errors occurring before the
+ *                        packet command is transferred.
+ *                       Fix transfers with odd bytelengths.
+ * 3.03  Oct 27, 1995 -- Some Creative drives have an id of just `CD'.
+ *                       `DCI-2S10' drives are broken too.
+ * 3.04  Nov 20, 1995 -- So are Vertos drives.
+ * 3.05  Dec  1, 1995 -- Changes to go with overhaul of ide.c and ide-=
tape.c
+ * 3.06  Dec 16, 1995 -- Add support needed for partitions.
+ *                       More workarounds for Vertos bugs (based on pa=
tches
+ *                        from Holger Dietze <dietze@aix520.informatik=
=2Euni-leipzig.de>).
+ *                       Try to eliminate byteorder assumptions.
+ *                       Use atapi_cdrom_subchnl struct definition.
+ *                       Add STANDARD_ATAPI compilation option.
+ * 3.07  Jan 29, 1996 -- More twiddling for broken drives: Sony 55D,
+ *                        Vertos 300.
+ *                       Add NO_DOOR_LOCKING configuration option.
+ *                       Handle drive_cmd requests w/NULL args (for hd=
parm -t).
+ *                       Work around sporadic Sony55e audio play probl=
em.
+ * 3.07a Feb 11, 1996 -- check drive->id for NULL before dereferencing=
, to fix
+ *                        problem with "hde=3Dcdrom" with no drive pre=
sent.  -ml
+ * 3.08  Mar  6, 1996 -- More Vertos workarounds.
+ * 3.09  Apr  5, 1996 -- Add CDROMCLOSETRAY ioctl.
+ *                       Switch to using MSF addressing for audio comm=
ands.
+ *                       Reformat to match kernel tabbing style.
+ *                       Add CDROM_GET_UPC ioctl.
+ * 3.10  Apr 10, 1996 -- Fix compilation error with STANDARD_ATAPI.
+ * 3.11  Apr 29, 1996 -- Patch from Heiko Ei=DFfeldt <heiko@colossus.e=
scape.de>
+ *                       to remove redundant verify_area calls.
+ * 3.12  May  7, 1996 -- Rudimentary changer support.  Based on patche=
s
+ *                        from Gerhard Zuber <zuber@berlin.snafu.de>.
+ *                       Let open succeed even if there's no loaded di=
sc.
+ * 3.13  May 19, 1996 -- Fixes for changer code.
+ * 3.14  May 29, 1996 -- Add work-around for Vertos 600.
+ *                        (From Hennus Bergman <hennus@sky.ow.nl>.)
+ * 3.15  July 2, 1996 -- Added support for Sanyo 3 CD changers
+ *                        from Ben Galliart <bgallia@luc.edu> with
+ *                        special help from Jeff Lightfoot
+ *                        <jeffml@pobox.com>
+ * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
+ * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage fo=
r ioctl.
+ * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
+ *                       Start changing CDROMLOADFROMSLOT to CDROM_SEL=
ECT_DISC.
+ * 3.18  Oct 31, 1996 -- Added module and DMA support.
+ *
+ * 4.00  Nov 5, 1996   -- New ide-cd maintainer,
+ *                                 Erik B. Andersen <andersee@debian.o=
rg>
+ *                     -- Newer Creative drives don't always set the e=
rror
+ *                          register correctly.  Make sure we see medi=
a changes
+ *                          regardless.
+ *                     -- Integrate with generic cdrom driver.
+ *                     -- CDROMGETSPINDOWN and CDROMSETSPINDOWN ioctls=
, based on
+ *                          a patch from Ciro Cattuto <>.
+ *                     -- Call set_device_ro.
+ *                     -- Implement CDROMMECHANISMSTATUS and CDROMSLOT=
TABLE
+ *                          ioctls, based on patch by Erik Andersen
+ *                     -- Add some probes of drive capability during s=
etup.
+ *
+ * 4.01  Nov 11, 1996  -- Split into ide-cd.c and ide-cd.h
+ *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTA=
BLE
+ *                          ioctls in favor of a generalized approach
+ *                          using the generic cdrom driver.
+ *                     -- Fully integrated with the 2.1.X kernel.
+ *                     -- Other stuff that I forgot (lots of changes)
+ *
+ * 4.02  Dec 01, 1996  -- Applied patch from Gadi Oxman <gadio@netvisi=
on.net.il>
+ *                          to fix the drive door locking problems.
+ *
+ * 4.03  Dec 04, 1996  -- Added DSC overlap support.
+ * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch
+ *                          by Ales Makarov (xmakarov@sun.felk.cvut.cz=
)
+ *
+ * 4.05  Nov 20, 1997  -- Modified to print more drive info on init
+ *                        Minor other changes
+ *                        Fix errors on CDROMSTOP (If you have a "Dolp=
hin",
+ *                          you must define IHAVEADOLPHIN)
+ *                        Added identifier so new Sanyo CD-changer wor=
ks
+ *                        Better detection if door locking isn't suppo=
rted
+ *
+ * 4.06  Dec 17, 1997  -- fixed endless "tray open" messages  -ml
+ * 4.07  Dec 17, 1997  -- fallback to set pc->stat on "tray open"
+ * 4.08  Dec 18, 1997  -- spew less noise when tray is empty
+ *                     -- fix speed display for ACER 24X, 18X
+ * 4.09  Jan 04, 1998  -- fix handling of the last block so we return
+ *                         an end of file instead of an I/O error (Gad=
i)
+ * 4.10  Jan 24, 1998  -- fixed a bug so now changers can change to a =
new
+ *                         slot when there is no disc in the current s=
lot.
+ *                     -- Fixed a memory leak where info->changer_info=
 was
+ *                         malloc'ed but never free'd when closing the=
 device.
+ *                     -- Cleaned up the global namespace a bit by mak=
ing more
+ *                         functions static that should already have b=
een.
+ * 4.11  Mar 12, 1998  -- Added support for the CDROM_SELECT_SPEED ioc=
tl
+ *                         based on a patch for 2.0.33 by Jelle Foks
+ *                         <jelle@scintilla.utwente.nl>, a patch for 2=
=2E0.33
+ *                         by Toni Giorgino <toni@pcape2.pi.infn.it>, =
the SCSI
+ *                         version, and my own efforts.  -erik
+ *                     -- Fixed a stupid bug which egcs was kind enoug=
h to
+ *                         inform me of where "Illegal mode for this t=
rack"
+ *                         was never returned due to a comparison on d=
ata
+ *                         types of limited range.
+ * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write spe=
ed is
+ *                         now set ionly for CD-R and CD-RW drives.  I=
 had
+ *                         removed this support because it produced er=
rors.
+ *                         It produced errors _only_ for non-writers. =
duh.
+ * 4.13  May 05, 1998  -- Suppress useless "in progress of becoming re=
ady"
+ *                         messages, since this is not an error.
+ *                     -- Change error messages to be const
+ *                     -- Remove a "\t" which looks ugly in the syslog=
s
+ * 4.14  July 17, 1998 -- Change to pointing to .ps version of ATAPI s=
pec
+ *                         since the .pdf version doesn't seem to work=
=2E..
+ *                     -- Updated the TODO list to something more curr=
ent.
+ *
+ * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianes=
s,
+ *                         patch thanks to "Eddie C. Dost" <ecd@skynet=
=2Ebe>
+ *
+ * 4.50  Oct 19, 1998  -- New maintainers!
+ *                         Jens Axboe <axboe@image.dk>
+ *                         Chris Zwilling <chris@cloudnet.com>
+ *
+ * 4.51  Dec 23, 1998  -- Jens Axboe <axboe@image.dk>
+ *                      - ide_cdrom_reset enabled since the ide subsys=
tem
+ *                         handles resets fine now. <axboe@image.dk>
+ *                      - Transfer size fix for Samsung CD-ROMs, thank=
s to
+ *                        "Ville Hallik" <ville.hallik@mail.ee>.
+ *                      - other minor stuff.
+ *
+ * 4.52  Jan 19, 1999  -- Jens Axboe <axboe@image.dk>
+ *                      - Detect DVD-ROM/RAM drives
+ *
+ * 4.53  Feb 22, 1999   - Include other model Samsung and one Goldstar
+ *                         drive in transfer size limit.
+ *                      - Fix the I/O error when doing eject without a=
 medium
+ *                         loaded on some drives.
+ *                      - CDROMREADMODE2 is now implemented through
+ *                         CDROMREADRAW, since many drives don't suppo=
rt
+ *                         MODE2 (even though ATAPI 2.6 says they must=
).
+ *                      - Added ignore parameter to ide-cd (as a modul=
e), eg
+ *                         	insmod ide-cd ignore=3D'hda hdb'
+ *                         Useful when using ide-cd in conjunction wit=
h
+ *                         ide-scsi. TODO: non-modular way of doing th=
e
+ *                         same.
+ *
+ * 4.54  Aug 5, 1999	- Support for MMC2 class commands through the gen=
eric
+ *			  packet interface to cdrom.c.
+ *			- Unified audio ioctl support, most of it.
+ *			- cleaned up various deprecated verify_area().
+ *			- Added ide_cdrom_packet() as the interface for
+ *			  the Uniform generic_packet().
+ *			- bunch of other stuff, will fill in logs later.
+ *			- report 1 slot for non-changers, like the other
+ *			  cd-rom drivers. don't report select disc for
+ *			  non-changers as well.
+ *			- mask out audio playing, if the device can't do it.
+ *
+ * 4.55  Sep 1, 1999	- Eliminated the rest of the audio ioctls, except
+ *			  for CDROMREADTOC[ENTRY|HEADER]. Some of the drivers
+ *			  use this independently of the actual audio handling.
+ *			  They will disappear later when I get the time to
+ *			  do it cleanly.
+ *			- Minimize the TOC reading - only do it when we
+ *			  know a media change has occurred.
+ *			- Moved all the CDROMREADx ioctls to the Uniform layer.
+ *			- Heiko Ei=DFfeldt <heiko@colossus.escape.de> supplied
+ *			  some fixes for CDI.
+ *			- CD-ROM leaving door locked fix from Andries
+ *			  Brouwer <Andries.Brouwer@cwi.nl>
+ *			- Erik Andersen <andersen@xmission.com> unified
+ *			  commands across the various drivers and how
+ *			  sense errors are handled.
+ *
+ * 4.56  Sep 12, 1999	- Removed changer support - it is now in the
+ *			  Uniform layer.
+ *			- Added partition based multisession handling.
+ *			- Mode sense and mode select moved to the
+ *			  Uniform layer.
+ *			- Fixed a problem with WPI CDS-32X drive - it
+ *			  failed the capabilities
+ *
+ * 4.57  Apr 7, 2000	- Fixed sense reporting.
+ *			- Fixed possible oops in ide_cdrom_get_last_session()
+ *			- Fix locking mania and make ide_cdrom_reset relock
+ *			- Stop spewing errors to log when magicdev polls with
+ *			  TEST_UNIT_READY on some drives.
+ *			- Various fixes from Tobias Ringstrom:
+ *			  tray if it was locked prior to the reset.
+ *			  - cdrom_read_capacity returns one frame too little.
+ *			  - Fix real capacity reporting.
+ *
+ * 4.58  May 1, 2000	- Clean up ACER50 stuff.
+ *			- Fix small problem with ide_cdrom_capacity
+ *
+ * 4.59  Aug 11, 2000	- Fix changer problem in cdrom_read_toc, we were=
n't
+ *			  correctly sensing a disc change.
+ *			- Rearranged some code
+ *			- Use extended sense on drives that support it for
+ *			  correctly reporting tray status -- from
+ *			  Michael D Johnson <johnsom@orst.edu>
+ * 4.60  Dec 17, 2003	- Add mt rainier support
+ *			- Bump timeout for packet commands, matches sr
+ *			- Odd stuff
+ * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
+ *			  Pascal Schmidt <der.eremit@email.de>
+ */
diff --git a/Documentation/ide/ChangeLog.ide-floppy.1996-2002 b/Documen=
tation/ide/ChangeLog.ide-floppy.1996-2002
new file mode 100644
index 0000000..46c19ef
--- /dev/null
+++ b/Documentation/ide/ChangeLog.ide-floppy.1996-2002
@@ -0,0 +1,63 @@
+/*
+ * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so =
many
+ * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy dri=
ve.
+ *
+ * Ver 0.1   Oct 17 96   Initial test version, mostly based on ide-tap=
e.c.
+ * Ver 0.2   Oct 31 96   Minor changes.
+ * Ver 0.3   Dec  2 96   Fixed error recovery bug.
+ * Ver 0.4   Jan 26 97   Add support for the HDIO_GETGEO ioctl.
+ * Ver 0.5   Feb 21 97   Add partitions support.
+ *                       Use the minimum of the LBA and CHS capacities=
=2E
+ *                       Avoid hwgroup->rq =3D=3D NULL on the last irq=
=2E
+ *                       Fix potential null dereferencing with DEBUG_L=
OG.
+ * Ver 0.8   Dec  7 97   Increase irq timeout from 10 to 50 seconds.
+ *                       Add media write-protect detection.
+ *                       Issue START command only if TEST UNIT READY f=
ails.
+ *                       Add work-around for IOMEGA ZIP revision 21.D.
+ *                       Remove idefloppy_get_capabilities().
+ * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number =
of
+ *                        bytes requested on each interrupt to be zero=
=2E
+ *                        Thanks to <shanos@es.co.nz> for pointing thi=
s out.
+ * Ver 0.9.sv Jan 6 01   Sam Varshavchik <mrsam@courier-mta.com>
+ *                       Implement low level formatting.  Reimplemente=
d
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, since we need th=
e srfp
+ *                       bit.  My LS-120 drive barfs on
+ *                       IDEFLOPPY_CAPABILITIES_PAGE, but maybe it's j=
ust me.
+ *                       Compromise by not reporting a failure to get =
this
+ *                       mode page.  Implemented four IOCTLs in order =
to
+ *                       implement formatting.  IOCTls begin with 0x46=
00,
+ *                       0x46 is 'F' as in Format.
+ *            Jan 9 01   Userland option to select format verify.
+ *                       Added PC_SUPPRESS_ERROR flag - some idefloppy=
 drives
+ *                       do not implement IDEFLOPPY_CAPABILITIES_PAGE,=
 and
+ *                       return a sense error.  Suppress error reporti=
ng in
+ *                       this particular case in order to avoid spurio=
us
+ *                       errors in syslog.  The culprit is
+ *                       idefloppy_get_capability_page(), so move it t=
o
+ *                       idefloppy_begin_format() so that it's not use=
d
+ *                       unless absolutely necessary.
+ *                       If drive does not support format progress ind=
ication
+ *                       monitor the dsc bit in the status register.
+ *                       Also, O_NDELAY on open will allow the device =
to be
+ *                       opened without a disk available.  This can be=
 used to
+ *                       open an unformatted disk, or get the device c=
apacity.
+ * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by
+ *     		   <paul@paulbristow.net>
+ * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for t=
his
+ *           		   driver.  Included Powerbook internal zip kludge.
+ * Ver 0.93  Oct 24 00   Fixed bugs for Clik! drive
+ *                        no disk on insert and disk change now works
+ * Ver 0.94  Oct 27 00   Tidied up to remove strstr(Clik) everywhere
+ * Ver 0.95  Nov  7 00   Brought across to kernel 2.4
+ * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.=
0
+ *                       including set_bit patch from Rusty Russell
+ * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
+ * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
+ * Ver 0.98  Oct 26 01   Split idefloppy_transfer_pc into two pieces t=
o
+ *                        fix a lost interrupt problem. It appears the=
 busy
+ *                        bit was being deasserted by my IOMEGA ATAPI =
ZIP 100
+ *                        drive before the drive was actually ready.
+ * Ver 0.98a Oct 29 01   Expose delay value so we can play.
+ * Ver 0.99  Feb 24 02   Remove duplicate code, modify clik! detection=
 code
+ *                        to support new PocketZip drives
+ */
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index af05610..47e5b40 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2787,12 +2787,6 @@ int cdrom_ioctl(struct file * file, struct cdrom=
_device_info *cdi,
 	return -ENOSYS;
 }
=20
-static inline
-int msf_to_lba(char m, char s, char f)
-{
-	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
-}
-
 /*
  * Required when we need to use READ_10 to issue other than 2048 block
  * reads
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 64df55e..e42a465 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -206,6 +206,15 @@ config BLK_DEV_IDECD
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide-cd.
=20
+config BLK_DEV_IDECD_VERBOSE_ERRORS
+	bool "Verbose error logging for IDE/ATAPI CDROM driver" if EMBEDDED
+	depends on BLK_DEV_IDECD
+	default y
+	help
+	  Turn this on to have the driver print out the meanings of the
+	  ATAPI error codes.  This will use up additional 8kB of kernel-space
+	  memory, though.
+
 config BLK_DEV_IDETAPE
 	tristate "Include IDE/ATAPI TAPE support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
@@ -617,8 +626,8 @@ config BLK_DEV_SC1200
 	tristate "National SCx200 chipset support"
 	select BLK_DEV_IDEDMA_PCI
 	help
-	  This driver adds support for the built in IDE on the National
-	  SCx200 series of embedded x86 "Geode" systems
+	  This driver adds support for the on-board IDE controller on the
+	  National SCx200 series of embedded x86 "Geode" systems.
=20
 config BLK_DEV_PIIX
 	tristate "Intel PIIXn chipsets support"
@@ -793,22 +802,22 @@ config BLK_DEV_CELLEB
 	depends on PPC_CELLEB
 	select BLK_DEV_IDEDMA_PCI
 	help
-	  This driver provides support for the built-in IDE controller on
+	  This driver provides support for the on-board IDE controller on
 	  Toshiba Cell Reference Board.
 	  If unsure, say Y.
=20
 endif
=20
 config BLK_DEV_IDE_PMAC
-	tristate "Builtin PowerMac IDE support"
+	tristate "PowerMac on-board IDE support"
 	depends on PPC_PMAC && IDE=3Dy && BLK_DEV_IDE=3Dy
 	help
-	  This driver provides support for the built-in IDE controller on
+	  This driver provides support for the on-board IDE controller on
 	  most of the recent Apple Power Macintoshes and PowerBooks.
 	  If unsure, say Y.
=20
 config BLK_DEV_IDE_PMAC_ATA100FIRST
-	bool "Probe internal ATA/100 (Kauai) first"
+	bool "Probe on-board ATA/100 (Kauai) first"
 	depends on BLK_DEV_IDE_PMAC
 	help
 	  This option will cause the ATA/100 controller found in UniNorth2
@@ -823,7 +832,7 @@ config BLK_DEV_IDEDMA_PMAC
 	depends on BLK_DEV_IDE_PMAC
 	select BLK_DEV_IDEDMA_PCI
 	help
-	  This option allows the driver for the built-in IDE controller on
+	  This option allows the driver for the on-board IDE controller on
 	  Power Macintoshes and PowerBooks to use DMA (direct memory access)
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
@@ -934,7 +943,7 @@ config BLK_DEV_GAYLE
 	help
 	  This is the IDE driver for the Amiga Gayle IDE interface. It suppor=
ts
 	  both the `A1200 style' and `A4000 style' of the Gayle IDE interface=
,
-	  This includes builtin IDE interfaces on some Amiga models (A600,
+	  This includes on-board IDE interfaces on some Amiga models (A600,
 	  A1200, A4000, and A4000T), and IDE interfaces on the Zorro expansio=
n
 	  bus (M-Tech E-Matrix 530 expansion card).
 	  Say Y if you have an Amiga with a Gayle IDE interface and want to u=
se
@@ -948,10 +957,10 @@ config BLK_DEV_IDEDOUBLER
 	depends on BLK_DEV_GAYLE && EXPERIMENTAL
 	---help---
 	  This driver provides support for the so-called `IDE doublers' (made
-	  by various manufacturers, e.g. Eyetech) that can be connected to th=
e
-	  builtin IDE interface of some Amiga models. Using such an IDE
-	  doubler, you can connect up to four instead of two IDE devices on
-	  the Amiga's builtin IDE interface.
+	  by various manufacturers, e.g. Eyetech) that can be connected to
+	  the on-board IDE interface of some Amiga models. Using such an IDE
+	  doubler, you can connect up to four instead of two IDE devices to
+	  the Amiga's on-board IDE interface.
=20
 	  Note that the normal Amiga Gayle IDE driver may not work correctly
 	  if you have an IDE doubler and don't enable this driver!
@@ -963,9 +972,9 @@ config BLK_DEV_BUDDHA
 	tristate "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL=
)"
 	depends on ZORRO && EXPERIMENTAL
 	help
-	  This is the IDE driver for the IDE interfaces on the Buddha,=20
-	  Catweasel and X-Surf expansion boards.  It supports up to two inter=
faces=20
-	  on the Buddha, three on the Catweasel and two on the X-Surf.
+	  This is the IDE driver for the IDE interfaces on the Buddha, Catwea=
sel
+	  and X-Surf expansion boards.  It supports up to two interfaces on t=
he
+	  Buddha, three on the Catweasel and two on the X-Surf.
=20
 	  Say Y if you have a Buddha or Catweasel expansion board and want to
 	  use IDE devices (hard disks, CD-ROM drives, etc.) that are connecte=
d
@@ -975,23 +984,23 @@ config BLK_DEV_FALCON_IDE
 	tristate "Falcon IDE interface support"
 	depends on ATARI
 	help
-	  This is the IDE driver for the builtin IDE interface on the Atari
+	  This is the IDE driver for the on-board IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (har=
d
-	  disks, CD-ROM drives, etc.) that are connected to the builtin IDE
+	  disks, CD-ROM drives, etc.) that are connected to the on-board IDE
 	  interface.
=20
 config BLK_DEV_MAC_IDE
 	tristate "Macintosh Quadra/Powerbook IDE interface support"
 	depends on MAC
 	help
-	  This is the IDE driver for the builtin IDE interface on some m68k
+	  This is the IDE driver for the on-board IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
 	  Quadra/ Centris 630 and Performa 588 models) and `Powerbook style'
 	  (used in the Powerbook 150 and 190 models) IDE interface.
=20
 	  Say Y if you have such an Macintosh model and want to use IDE
 	  devices (hard disks, CD-ROM drives, etc.) that are connected to the
-	  builtin IDE interface.
+	  on-board IDE interface.
=20
 config BLK_DEV_Q40IDE
 	tristate "Q40/Q60 IDE interface support"
@@ -1062,8 +1071,8 @@ config BLK_DEV_ALI14XX
 	  boot parameter.  It enables support for the secondary IDE interface
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
 	  I/O speeds to be set as well.  See the files
-	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/ali14xx.c=
> for
-	  more info.
+	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/ali14xx.c=
>
+	  for more info.
=20
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
@@ -1088,8 +1097,8 @@ config BLK_DEV_QD65XX
 	help
 	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
-	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/qd65xx.c>=
 for
-	  more info.
+	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/qd65xx.c>
+	  for more info.
=20
 config BLK_DEV_UMC8672
 	tristate "UMC-8672 support"
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 0d2da89..a4a4323 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -40,8 +40,10 @@ obj-$(CONFIG_BLK_DEV_IDEPNP)		+=3D ide-pnp.o
 obj-$(CONFIG_IDE_H8300)			+=3D h8300/
 obj-$(CONFIG_IDE_GENERIC)		+=3D ide-generic.o
=20
+ide-cd_mod-y +=3D ide-cd.o ide-cd_ioctl.o ide-cd_verbose.o
+
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+=3D ide-disk.o
-obj-$(CONFIG_BLK_DEV_IDECD)		+=3D ide-cd.o
+obj-$(CONFIG_BLK_DEV_IDECD)		+=3D ide-cd_mod.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+=3D ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+=3D ide-floppy.o
=20
diff --git a/drivers/ide/arm/bast-ide.c b/drivers/ide/arm/bast-ide.c
index 45bf9c8..037300f 100644
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -1,5 +1,4 @@
-/* linux/drivers/ide/arm/bast-ide.c
- *
+/*
  * Copyright (c) 2003-2004 Simtec Electronics
  *  Ben Dooks <ben@simtec.co.uk>
  *
diff --git a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
index 8a5c720..8d2cc47 100644
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/arm/icside.c
- *
  * Copyright (c) 1996-2004 Russell King.
  *
  * Please note that this platform does not support 32-bit IDE IO.
@@ -71,8 +69,6 @@ struct icside_state {
 	void __iomem *irq_port;
 	void __iomem *ioc_base;
 	unsigned int type;
-	/* parent device... until the IDE core gets one of its own */
-	struct device *dev;
 	ide_hwif_t *hwif[2];
 };
=20
@@ -206,23 +202,6 @@ static void icside_maskproc(ide_drive_t *drive, in=
t mask)
  * interfaces use the same IRQ, which should guarantee this.
  */
=20
-static void icside_build_sglist(ide_drive_t *drive, struct request *rq=
)
-{
-	ide_hwif_t *hwif =3D drive->hwif;
-	struct icside_state *state =3D hwif->hwif_data;
-	struct scatterlist *sg =3D hwif->sg_table;
-
-	ide_map_sg(drive, rq);
-
-	if (rq_data_dir(rq) =3D=3D READ)
-		hwif->sg_dma_direction =3D DMA_FROM_DEVICE;
-	else
-		hwif->sg_dma_direction =3D DMA_TO_DEVICE;
-
-	hwif->sg_nents =3D dma_map_sg(state->dev, sg, hwif->sg_nents,
-				    hwif->sg_dma_direction);
-}
-
 /*
  * Configure the IOMD to give the appropriate timings for the transfer
  * mode being requested.  We take the advice of the ATA standards, and
@@ -294,33 +273,32 @@ static void icside_dma_host_set(ide_drive_t *driv=
e, int on)
 static int icside_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct icside_state *state =3D hwif->hwif_data;
+	struct expansion_card *ec =3D ECARD_DEV(hwif->dev);
=20
 	drive->waiting_for_dma =3D 0;
=20
-	disable_dma(ECARD_DEV(state->dev)->dma);
+	disable_dma(ec->dma);
=20
 	/* Teardown mappings after DMA has completed. */
-	dma_unmap_sg(state->dev, hwif->sg_table, hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
=20
-	return get_dma_residue(ECARD_DEV(state->dev)->dma) !=3D 0;
+	return get_dma_residue(ec->dma) !=3D 0;
 }
=20
 static void icside_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct icside_state *state =3D hwif->hwif_data;
+	struct expansion_card *ec =3D ECARD_DEV(hwif->dev);
=20
 	/* We can not enable DMA on both channels simultaneously. */
-	BUG_ON(dma_channel_active(ECARD_DEV(state->dev)->dma));
-	enable_dma(ECARD_DEV(state->dev)->dma);
+	BUG_ON(dma_channel_active(ec->dma));
+	enable_dma(ec->dma);
 }
=20
 static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct icside_state *state =3D hwif->hwif_data;
+	struct expansion_card *ec =3D ECARD_DEV(hwif->dev);
 	struct request *rq =3D hwif->hwgroup->rq;
 	unsigned int dma_mode;
=20
@@ -332,9 +310,9 @@ static int icside_dma_setup(ide_drive_t *drive)
 	/*
 	 * We can not enable DMA on both channels.
 	 */
-	BUG_ON(dma_channel_active(ECARD_DEV(state->dev)->dma));
+	BUG_ON(dma_channel_active(ec->dma));
=20
-	icside_build_sglist(drive, rq);
+	hwif->sg_nents =3D ide_build_sglist(drive, rq);
=20
 	/*
 	 * Ensure that we have the right interrupt routed.
@@ -349,14 +327,14 @@ static int icside_dma_setup(ide_drive_t *drive)
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(ECARD_DEV(state->dev)->dma, drive->drive_data);
+	set_dma_speed(ec->dma, drive->drive_data);
=20
 	/*
 	 * Tell the DMA engine about the SG table and
 	 * data direction.
 	 */
-	set_dma_sg(ECARD_DEV(state->dev)->dma, hwif->sg_table, hwif->sg_nents=
);
-	set_dma_mode(ECARD_DEV(state->dev)->dma, dma_mode);
+	set_dma_sg(ec->dma, hwif->sg_table, hwif->sg_nents);
+	set_dma_mode(ec->dma, dma_mode);
=20
 	drive->waiting_for_dma =3D 1;
=20
@@ -444,6 +422,7 @@ icside_setup(void __iomem *base, struct cardinfo *i=
nfo, struct expansion_card *e
 		hwif->noprobe =3D 0;
 		hwif->chipset =3D ide_acorn;
 		hwif->gendev.parent =3D &ec->dev;
+		hwif->dev =3D &ec->dev;
 	}
=20
 	return hwif;
@@ -591,7 +570,6 @@ icside_probe(struct expansion_card *ec, const struc=
t ecard_id *id)
 	}
=20
 	state->type	=3D ICS_TYPE_NOTYPE;
-	state->dev	=3D &ec->dev;
=20
 	idmem =3D ecardm_iomap(ec, ECARD_RES_IOCFAST, 0, 0);
 	if (idmem) {
diff --git a/drivers/ide/arm/rapide.c b/drivers/ide/arm/rapide.c
index e6b56d1..c8b6581 100644
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/arm/rapide.c
- *
  * Copyright (c) 1996-2002 Russell King.
  */
=20
@@ -78,8 +76,8 @@ static void __devexit rapide_remove(struct expansion_=
card *ec)
=20
 	ecard_set_drvdata(ec, NULL);
=20
-	/* there must be a better way */
-	ide_unregister(hwif - ide_hwifs);
+	ide_unregister(hwif->index);
+
 	ecard_release_resources(ec);
 }
=20
diff --git a/drivers/ide/cris/ide-cris.c b/drivers/ide/cris/ide-cris.c
index 8c3294c..0640a38 100644
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1,5 +1,4 @@
-/* $Id: cris-ide-driver.patch,v 1.1 2005/06/29 21:39:07 akpm Exp $
- *
+/*
  * Etrax specific IDE functions, like init and PIO-mode setting etc.
  * Almost the entire ide.c is used for the rest of the Etrax ATA drive=
r.
  * Copyright (c) 2000-2005 Axis Communications AB
diff --git a/drivers/ide/h8300/ide-h8300.c b/drivers/ide/h8300/ide-h830=
0.c
index 4f6d019..0243295 100644
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -1,5 +1,4 @@
 /*
- * drivers/ide/h8300/ide-h8300.c
  * H8/300 generic IDE interface
  */
=20
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index e888fc3..68bc618 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -1,5 +1,4 @@
 /*
- * ide-acpi.c
  * Provides ACPI support for IDE drives.
  *
  * Copyright (C) 2005 Intel Corp.
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index bee05a3..23074e8 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1,14 +1,14 @@
 /*
- * linux/drivers/ide/ide-cd.c
+ * ATAPI CD-ROM driver.
  *
- * Copyright (C) 1994, 1995, 1996  scott snyder  <snyder@fnald0.fnal.g=
ov>
- * Copyright (C) 1996-1998  Erik Andersen <andersee@debian.org>
- * Copyright (C) 1998-2000  Jens Axboe <axboe@suse.de>
+ * Copyright (C) 1994-1996   Scott Snyder <snyder@fnald0.fnal.gov>
+ * Copyright (C) 1996-1998   Erik Andersen <andersee@debian.org>
+ * Copyright (C) 1998-2000   Jens Axboe <axboe@suse.de>
+ * Copyright (C) 2005, 2007  Bartlomiej Zolnierkiewicz
  *
  * May be copied or modified under the terms of the GNU General Public
  * License.  See linux/COPYING for more information.
  *
- * ATAPI CD-ROM driver.  To be used with ide.c.
  * See Documentation/cdrom/ide-cd for usage information.
  *
  * Suggestions are welcome. Patches that work are more welcome though.=
 ;-)
@@ -19,287 +19,11 @@
  * ftp://fission.dt.wdc.com/pub/standards/SFF_atapi/spec/SFF8020-r2.6/=
PS/8020r26.ps
  * ftp://ftp.avc-pioneer.com/Mtfuji4/Spec/Fuji4r10.pdf
  *
- * Drives that deviate from these standards will be accommodated as mu=
ch
- * as possible via compile time or command-line options.  Since I only=
 have
- * a few drives, you generally need to send me patches...
- *
- * ----------------------------------
- * TO DO LIST:
- * -Make it so that Pioneer CD DR-A24X and friends don't get screwed u=
p on
- *   boot
- *
- * ----------------------------------
- * 1.00  Oct 31, 1994 -- Initial version.
- * 1.01  Nov  2, 1994 -- Fixed problem with starting request in
- *                       cdrom_check_status.
- * 1.03  Nov 25, 1994 -- leaving unmask_intr[] as a user-setting (as f=
or disks)
- * (from mlord)       -- minor changes to cdrom_setup()
- *                    -- renamed ide_dev_s to ide_drive_t, enable irq =
on command
- * 2.00  Nov 27, 1994 -- Generalize packet command interface;
- *                       add audio ioctls.
- * 2.01  Dec  3, 1994 -- Rework packet command interface to handle dev=
ices
- *                       which send an interrupt when ready for a comm=
and.
- * 2.02  Dec 11, 1994 -- Cache the TOC in the driver.
- *                       Don't use SCMD_PLAYAUDIO_TI; it's not include=
d
- *                       in the current version of ATAPI.
- *                       Try to use LBA instead of track or MSF addres=
sing
- *                       when possible.
- *                       Don't wait for READY_STAT.
- * 2.03  Jan 10, 1995 -- Rewrite block read routines to handle block s=
izes
- *                       other than 2k and to move multiple sectors in=
 a
- *                       single transaction.
- * 2.04  Apr 21, 1995 -- Add work-around for Creative Labs CD220E driv=
es.
- *                       Thanks to Nick Saw <cwsaw@pts7.pts.mot.com> f=
or
- *                       help in figuring this out.  Ditto for Acer an=
d
- *                       Aztech drives, which seem to have the same pr=
oblem.
- * 2.04b May 30, 1995 -- Fix to match changes in ide.c version 3.16 -m=
l
- * 2.05  Jun  8, 1995 -- Don't attempt to retry after an illegal reque=
st
- *                        or data protect error.
- *                       Use HWIF and DEV_HWIF macros as in ide.c.
- *                       Always try to do a request_sense after
- *                        a failed command.
- *                       Include an option to give textual description=
s
- *                        of ATAPI errors.
- *                       Fix a bug in handling the sector cache which
- *                        showed up if the drive returned data in 512 =
byte
- *                        blocks (like Pioneer drives).  Thanks to
- *                        Richard Hirst <srh@gpt.co.uk> for diagnosing=
 this.
- *                       Properly supply the page number field in the
- *                        MODE_SELECT command.
- *                       PLAYAUDIO12 is broken on the Aztech; work aro=
und it.
- * 2.05x Aug 11, 1995 -- lots of data structure renaming/restructuring=
 in ide.c
- *                       (my apologies to Scott, but now ide-cd.c is i=
ndependent)
- * 3.00  Aug 22, 1995 -- Implement CDROMMULTISESSION ioctl.
- *                       Implement CDROMREADAUDIO ioctl (UNTESTED).
- *                       Use input_ide_data() and output_ide_data().
- *                       Add door locking.
- *                       Fix usage count leak in cdrom_open, which hap=
pened
- *                        when a read-write mount was attempted.
- *                       Try to load the disk on open.
- *                       Implement CDROMEJECT_SW ioctl (off by default=
).
- *                       Read total cdrom capacity during open.
- *                       Rearrange logic in cdrom_decode_status.  Issu=
e
- *                        request sense commands for failed packet com=
mands
- *                        from here instead of from cdrom_queue_packet=
_command.
- *                        Fix a race condition in retrieving error inf=
ormation.
- *                       Suppress printing normal unit attention error=
s and
- *                        some drive not ready errors.
- *                       Implement CDROMVOLREAD ioctl.
- *                       Implement CDROMREADMODE1/2 ioctls.
- *                       Fix race condition in setting up interrupt ha=
ndlers
- *                        when the `serialize' option is used.
- * 3.01  Sep  2, 1995 -- Fix ordering of reenabling interrupts in
- *                        cdrom_queue_request.
- *                       Another try at using ide_[input,output]_data.
- * 3.02  Sep 16, 1995 -- Stick total disk capacity in partition table =
as well.
- *                       Make VERBOSE_IDE_CD_ERRORS dump failed comman=
d again.
- *                       Dump out more information for ILLEGAL REQUEST=
 errs.
- *                       Fix handling of errors occurring before the
- *                        packet command is transferred.
- *                       Fix transfers with odd bytelengths.
- * 3.03  Oct 27, 1995 -- Some Creative drives have an id of just `CD'.
- *                       `DCI-2S10' drives are broken too.
- * 3.04  Nov 20, 1995 -- So are Vertos drives.
- * 3.05  Dec  1, 1995 -- Changes to go with overhaul of ide.c and ide-=
tape.c
- * 3.06  Dec 16, 1995 -- Add support needed for partitions.
- *                       More workarounds for Vertos bugs (based on pa=
tches
- *                        from Holger Dietze <dietze@aix520.informatik=
=2Euni-leipzig.de>).
- *                       Try to eliminate byteorder assumptions.
- *                       Use atapi_cdrom_subchnl struct definition.
- *                       Add STANDARD_ATAPI compilation option.
- * 3.07  Jan 29, 1996 -- More twiddling for broken drives: Sony 55D,
- *                        Vertos 300.
- *                       Add NO_DOOR_LOCKING configuration option.
- *                       Handle drive_cmd requests w/NULL args (for hd=
parm -t).
- *                       Work around sporadic Sony55e audio play probl=
em.
- * 3.07a Feb 11, 1996 -- check drive->id for NULL before dereferencing=
, to fix
- *                        problem with "hde=3Dcdrom" with no drive pre=
sent.  -ml
- * 3.08  Mar  6, 1996 -- More Vertos workarounds.
- * 3.09  Apr  5, 1996 -- Add CDROMCLOSETRAY ioctl.
- *                       Switch to using MSF addressing for audio comm=
ands.
- *                       Reformat to match kernel tabbing style.
- *                       Add CDROM_GET_UPC ioctl.
- * 3.10  Apr 10, 1996 -- Fix compilation error with STANDARD_ATAPI.
- * 3.11  Apr 29, 1996 -- Patch from Heiko Ei=DFfeldt <heiko@colossus.e=
scape.de>
- *                       to remove redundant verify_area calls.
- * 3.12  May  7, 1996 -- Rudimentary changer support.  Based on patche=
s
- *                        from Gerhard Zuber <zuber@berlin.snafu.de>.
- *                       Let open succeed even if there's no loaded di=
sc.
- * 3.13  May 19, 1996 -- Fixes for changer code.
- * 3.14  May 29, 1996 -- Add work-around for Vertos 600.
- *                        (From Hennus Bergman <hennus@sky.ow.nl>.)
- * 3.15  July 2, 1996 -- Added support for Sanyo 3 CD changers
- *                        from Ben Galliart <bgallia@luc.edu> with=20
- *                        special help from Jeff Lightfoot=20
- *                        <jeffml@pobox.com>
- * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
- * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage fo=
r ioctl.
- * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
- *                       Start changing CDROMLOADFROMSLOT to CDROM_SEL=
ECT_DISC.
- * 3.18  Oct 31, 1996 -- Added module and DMA support.
- *                      =20
- *                      =20
- * 4.00  Nov 5, 1996   -- New ide-cd maintainer,
- *                                 Erik B. Andersen <andersee@debian.o=
rg>
- *                     -- Newer Creative drives don't always set the e=
rror
- *                          register correctly.  Make sure we see medi=
a changes
- *                          regardless.
- *                     -- Integrate with generic cdrom driver.
- *                     -- CDROMGETSPINDOWN and CDROMSETSPINDOWN ioctls=
, based on
- *                          a patch from Ciro Cattuto <>.
- *                     -- Call set_device_ro.
- *                     -- Implement CDROMMECHANISMSTATUS and CDROMSLOT=
TABLE
- *                          ioctls, based on patch by Erik Andersen
- *                     -- Add some probes of drive capability during s=
etup.
- *
- * 4.01  Nov 11, 1996  -- Split into ide-cd.c and ide-cd.h
- *                     -- Removed CDROMMECHANISMSTATUS and CDROMSLOTTA=
BLE=20
- *                          ioctls in favor of a generalized approach=20
- *                          using the generic cdrom driver.
- *                     -- Fully integrated with the 2.1.X kernel.
- *                     -- Other stuff that I forgot (lots of changes)
- *
- * 4.02  Dec 01, 1996  -- Applied patch from Gadi Oxman <gadio@netvisi=
on.net.il>
- *                          to fix the drive door locking problems.
- *
- * 4.03  Dec 04, 1996  -- Added DSC overlap support.
- * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch=20
- *                          by Ales Makarov (xmakarov@sun.felk.cvut.cz=
)
- *
- * 4.05  Nov 20, 1997  -- Modified to print more drive info on init
- *                        Minor other changes
- *                        Fix errors on CDROMSTOP (If you have a "Dolp=
hin",
- *                          you must define IHAVEADOLPHIN)
- *                        Added identifier so new Sanyo CD-changer wor=
ks
- *                        Better detection if door locking isn't suppo=
rted
- *
- * 4.06  Dec 17, 1997  -- fixed endless "tray open" messages  -ml
- * 4.07  Dec 17, 1997  -- fallback to set pc->stat on "tray open"
- * 4.08  Dec 18, 1997  -- spew less noise when tray is empty
- *                     -- fix speed display for ACER 24X, 18X
- * 4.09  Jan 04, 1998  -- fix handling of the last block so we return
- *                         an end of file instead of an I/O error (Gad=
i)
- * 4.10  Jan 24, 1998  -- fixed a bug so now changers can change to a =
new
- *                         slot when there is no disc in the current s=
lot.
- *                     -- Fixed a memory leak where info->changer_info=
 was
- *                         malloc'ed but never free'd when closing the=
 device.
- *                     -- Cleaned up the global namespace a bit by mak=
ing more
- *                         functions static that should already have b=
een.
- * 4.11  Mar 12, 1998  -- Added support for the CDROM_SELECT_SPEED ioc=
tl
- *                         based on a patch for 2.0.33 by Jelle Foks=20
- *                         <jelle@scintilla.utwente.nl>, a patch for 2=
=2E0.33
- *                         by Toni Giorgino <toni@pcape2.pi.infn.it>, =
the SCSI
- *                         version, and my own efforts.  -erik
- *                     -- Fixed a stupid bug which egcs was kind enoug=
h to
- *                         inform me of where "Illegal mode for this t=
rack"
- *                         was never returned due to a comparison on d=
ata
- *                         types of limited range.
- * 4.12  Mar 29, 1998  -- Fixed bug in CDROM_SELECT_SPEED so write spe=
ed is=20
- *                         now set ionly for CD-R and CD-RW drives.  I=
 had=20
- *                         removed this support because it produced er=
rors.
- *                         It produced errors _only_ for non-writers. =
duh.
- * 4.13  May 05, 1998  -- Suppress useless "in progress of becoming re=
ady"
- *                         messages, since this is not an error.
- *                     -- Change error messages to be const
- *                     -- Remove a "\t" which looks ugly in the syslog=
s
- * 4.14  July 17, 1998 -- Change to pointing to .ps version of ATAPI s=
pec
- *                         since the .pdf version doesn't seem to work=
=2E..
- *                     -- Updated the TODO list to something more curr=
ent.
- *
- * 4.15  Aug 25, 1998  -- Updated ide-cd.h to respect mechine endianes=
s,=20
- *                         patch thanks to "Eddie C. Dost" <ecd@skynet=
=2Ebe>
- *
- * 4.50  Oct 19, 1998  -- New maintainers!
- *                         Jens Axboe <axboe@image.dk>
- *                         Chris Zwilling <chris@cloudnet.com>
- *
- * 4.51  Dec 23, 1998  -- Jens Axboe <axboe@image.dk>
- *                      - ide_cdrom_reset enabled since the ide subsys=
tem
- *                         handles resets fine now. <axboe@image.dk>
- *                      - Transfer size fix for Samsung CD-ROMs, thank=
s to
- *                        "Ville Hallik" <ville.hallik@mail.ee>.
- *                      - other minor stuff.
- *
- * 4.52  Jan 19, 1999  -- Jens Axboe <axboe@image.dk>
- *                      - Detect DVD-ROM/RAM drives
- *
- * 4.53  Feb 22, 1999   - Include other model Samsung and one Goldstar
- *                         drive in transfer size limit.
- *                      - Fix the I/O error when doing eject without a=
 medium
- *                         loaded on some drives.
- *                      - CDROMREADMODE2 is now implemented through
- *                         CDROMREADRAW, since many drives don't suppo=
rt
- *                         MODE2 (even though ATAPI 2.6 says they must=
).
- *                      - Added ignore parameter to ide-cd (as a modul=
e), eg
- *                         	insmod ide-cd ignore=3D'hda hdb'
- *                         Useful when using ide-cd in conjunction wit=
h
- *                         ide-scsi. TODO: non-modular way of doing th=
e
- *                         same.
- *
- * 4.54  Aug 5, 1999	- Support for MMC2 class commands through the gen=
eric
- *			  packet interface to cdrom.c.
- *			- Unified audio ioctl support, most of it.
- *			- cleaned up various deprecated verify_area().
- *			- Added ide_cdrom_packet() as the interface for
- *			  the Uniform generic_packet().
- *			- bunch of other stuff, will fill in logs later.
- *			- report 1 slot for non-changers, like the other
- *			  cd-rom drivers. don't report select disc for
- *			  non-changers as well.
- *			- mask out audio playing, if the device can't do it.
- *
- * 4.55  Sep 1, 1999	- Eliminated the rest of the audio ioctls, except
- *			  for CDROMREADTOC[ENTRY|HEADER]. Some of the drivers
- *			  use this independently of the actual audio handling.
- *			  They will disappear later when I get the time to
- *			  do it cleanly.
- *			- Minimize the TOC reading - only do it when we
- *			  know a media change has occurred.
- *			- Moved all the CDROMREADx ioctls to the Uniform layer.
- *			- Heiko Ei=DFfeldt <heiko@colossus.escape.de> supplied
- *			  some fixes for CDI.
- *			- CD-ROM leaving door locked fix from Andries
- *			  Brouwer <Andries.Brouwer@cwi.nl>
- *			- Erik Andersen <andersen@xmission.com> unified
- *			  commands across the various drivers and how
- *			  sense errors are handled.
- *
- * 4.56  Sep 12, 1999	- Removed changer support - it is now in the
- *			  Uniform layer.
- *			- Added partition based multisession handling.
- *			- Mode sense and mode select moved to the
- *			  Uniform layer.
- *			- Fixed a problem with WPI CDS-32X drive - it
- *			  failed the capabilities=20
- *
- * 4.57  Apr 7, 2000	- Fixed sense reporting.
- *			- Fixed possible oops in ide_cdrom_get_last_session()
- *			- Fix locking mania and make ide_cdrom_reset relock
- *			- Stop spewing errors to log when magicdev polls with
- *			  TEST_UNIT_READY on some drives.
- *			- Various fixes from Tobias Ringstrom:
- *			  tray if it was locked prior to the reset.
- *			  - cdrom_read_capacity returns one frame too little.
- *			  - Fix real capacity reporting.
- *
- * 4.58  May 1, 2000	- Clean up ACER50 stuff.
- *			- Fix small problem with ide_cdrom_capacity
- *
- * 4.59  Aug 11, 2000	- Fix changer problem in cdrom_read_toc, we were=
n't
- *			  correctly sensing a disc change.
- *			- Rearranged some code
- *			- Use extended sense on drives that support it for
- *			  correctly reporting tray status -- from
- *			  Michael D Johnson <johnsom@orst.edu>
- * 4.60  Dec 17, 2003	- Add mt rainier support
- *			- Bump timeout for packet commands, matches sr
- *			- Odd stuff
- * 4.61  Jan 22, 2004	- support hardware sector sizes other than 2kB,
- *			  Pascal Schmidt <der.eremit@email.de>
- *
- *********************************************************************=
****/
-=20
-#define IDECD_VERSION "4.61"
+ * For historical changelog please see:
+ *	Documentation/ide/ChangeLog.ide-cd.1994-2004
+ */
+
+#define IDECD_VERSION "5.00"
=20
 #include <linux/module.h>
 #include <linux/types.h>
@@ -313,6 +37,7 @@
 #include <linux/ide.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/bcd.h>
=20
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
=20
@@ -360,11 +85,11 @@ static void ide_cd_put(struct cdrom_info *cd)
    buffers. */
 static void cdrom_saw_media_change (ide_drive_t *drive)
 {
-	struct cdrom_info *info =3D drive->driver_data;
-=09
-	CDROM_STATE_FLAGS (drive)->media_changed =3D 1;
-	CDROM_STATE_FLAGS (drive)->toc_valid =3D 0;
-	info->nsectors_buffered =3D 0;
+	struct cdrom_info *cd =3D drive->driver_data;
+
+	cd->cd_flags |=3D IDE_CD_FLAG_MEDIA_CHANGED;
+	cd->cd_flags &=3D ~IDE_CD_FLAG_TOC_VALID;
+	cd->nsectors_buffered =3D 0;
 }
=20
 static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
@@ -465,134 +190,14 @@ void cdrom_analyze_sense_data(ide_drive_t *drive=
,
 			}
  		}
  	}
-#if VERBOSE_IDE_CD_ERRORS
-	{
-		int i;
-		const char *s =3D "bad sense key!";
-		char buf[80];
-
-		printk ("ATAPI device %s:\n", drive->name);
-		if (sense->error_code=3D=3D0x70)
-			printk("  Error: ");
-		else if (sense->error_code=3D=3D0x71)
-			printk("  Deferred Error: ");
-		else if (sense->error_code =3D=3D 0x7f)
-			printk("  Vendor-specific Error: ");
-		else
-			printk("  Unknown Error Type: ");
-
-		if (sense->sense_key < ARRAY_SIZE(sense_key_texts))
-			s =3D sense_key_texts[sense->sense_key];
-
-		printk("%s -- (Sense key=3D0x%02x)\n", s, sense->sense_key);
-
-		if (sense->asc =3D=3D 0x40) {
-			sprintf(buf, "Diagnostic failure on component 0x%02x",
-				 sense->ascq);
-			s =3D buf;
-		} else {
-			int lo =3D 0, mid, hi =3D ARRAY_SIZE(sense_data_texts);
-			unsigned long key =3D (sense->sense_key << 16);
-			key |=3D (sense->asc << 8);
-			if (!(sense->ascq >=3D 0x80 && sense->ascq <=3D 0xdd))
-				key |=3D sense->ascq;
-			s =3D NULL;
-
-			while (hi > lo) {
-				mid =3D (lo + hi) / 2;
-				if (sense_data_texts[mid].asc_ascq =3D=3D key ||
-				    sense_data_texts[mid].asc_ascq =3D=3D (0xff0000|key)) {
-					s =3D sense_data_texts[mid].text;
-					break;
-				}
-				else if (sense_data_texts[mid].asc_ascq > key)
-					hi =3D mid;
-				else
-					lo =3D mid+1;
-			}
-		}
-
-		if (s =3D=3D NULL) {
-			if (sense->asc > 0x80)
-				s =3D "(vendor-specific error)";
-			else
-				s =3D "(reserved error code)";
-		}
-
-		printk(KERN_ERR "  %s -- (asc=3D0x%02x, ascq=3D0x%02x)\n",
-			s, sense->asc, sense->ascq);
-
-		if (failed_command !=3D NULL) {
-
-			int lo=3D0, mid, hi=3D ARRAY_SIZE(packet_command_texts);
-			s =3D NULL;
-
-			while (hi > lo) {
-				mid =3D (lo + hi) / 2;
-				if (packet_command_texts[mid].packet_command =3D=3D
-				    failed_command->cmd[0]) {
-					s =3D packet_command_texts[mid].text;
-					break;
-				}
-				if (packet_command_texts[mid].packet_command >
-				    failed_command->cmd[0])
-					hi =3D mid;
-				else
-					lo =3D mid+1;
-			}
-
-			printk (KERN_ERR "  The failed \"%s\" packet command was: \n  \"", =
s);
-			for (i=3D0; i<sizeof (failed_command->cmd); i++)
-				printk ("%02x ", failed_command->cmd[i]);
-			printk ("\"\n");
-		}
-
-		/* The SKSV bit specifies validity of the sense_key_specific
-		 * in the next two commands. It is bit 7 of the first byte.
-		 * In the case of NOT_READY, if SKSV is set the drive can
-		 * give us nice ETA readings.
-		 */
-		if (sense->sense_key =3D=3D NOT_READY && (sense->sks[0] & 0x80)) {
-			int progress =3D (sense->sks[1] << 8 | sense->sks[2]) * 100;
-			printk(KERN_ERR "  Command is %02d%% complete\n", progress / 0xffff=
);
-
-		}
-
-		if (sense->sense_key =3D=3D ILLEGAL_REQUEST &&
-		    (sense->sks[0] & 0x80) !=3D 0) {
-			printk(KERN_ERR "  Error in %s byte %d",
-				(sense->sks[0] & 0x40) !=3D 0 ?
-				"command packet" : "command data",
-				(sense->sks[1] << 8) + sense->sks[2]);
-
-			if ((sense->sks[0] & 0x40) !=3D 0)
-				printk (" bit %d", sense->sks[0] & 0x07);
=20
-			printk ("\n");
-		}
-	}
-
-#else /* not VERBOSE_IDE_CD_ERRORS */
-
-	/* Suppress printing unit attention and `in progress of becoming read=
y'
-	   errors when we're not being verbose. */
-
-	if (sense->sense_key =3D=3D UNIT_ATTENTION ||
-	    (sense->sense_key =3D=3D NOT_READY && (sense->asc =3D=3D 4 ||
-						sense->asc =3D=3D 0x3a)))
-		return;
-
-	printk(KERN_ERR "%s: error code: 0x%02x  sense_key: 0x%02x  asc: 0x%0=
2x  ascq: 0x%02x\n",
-		drive->name,
-		sense->error_code, sense->sense_key,
-		sense->asc, sense->ascq);
-#endif /* not VERBOSE_IDE_CD_ERRORS */
+	ide_cd_log_error(drive->name, failed_command, sense);
 }
=20
 /*
  * Initialize a ide-cd packet command request
  */
-static void cdrom_prepare_request(ide_drive_t *drive, struct request *=
rq)
+void ide_cd_init_rq(ide_drive_t *drive, struct request *rq)
 {
 	struct cdrom_info *cd =3D drive->driver_data;
=20
@@ -611,7 +216,7 @@ static void cdrom_queue_request_sense(ide_drive_t *=
drive, void *sense,
 		sense =3D &info->sense_data;
=20
 	/* stuff the sense request in front of our current request */
-	cdrom_prepare_request(drive, rq);
+	ide_cd_init_rq(drive, rq);
=20
 	rq->data =3D sense;
 	rq->cmd[0] =3D GPCMD_REQUEST_SENSE;
@@ -718,7 +323,6 @@ static int cdrom_decode_status(ide_drive_t *drive, =
int good_stat, int *stat_ret)
=20
 	} else if (blk_pc_request(rq) || rq->cmd_type =3D=3D REQ_TYPE_ATA_PC)=
 {
 		/* All other functions, except for READ. */
-		unsigned long flags;
=20
 		/*
 		 * if we have an error, pass back CHECK_CONDITION as the
@@ -756,15 +360,7 @@ static int cdrom_decode_status(ide_drive_t *drive,=
 int good_stat, int *stat_ret)
 		 * remove failed request completely and end it when the
 		 * request sense has completed
 		 */
-		if (stat & ERR_STAT) {
-			spin_lock_irqsave(&ide_lock, flags);
-			blkdev_dequeue_request(rq);
-			HWGROUP(drive)->rq =3D NULL;
-			spin_unlock_irqrestore(&ide_lock, flags);
-
-			cdrom_queue_request_sense(drive, rq->sense, rq);
-		} else
-			cdrom_end_request(drive, 0);
+		goto end_request;
=20
 	} else if (blk_fs_request(rq)) {
 		int do_end_request =3D 0;
@@ -844,23 +440,15 @@ static int cdrom_decode_status(ide_drive_t *drive=
, int good_stat, int *stat_ret)
 		   sense data. We need this in order to perform end of media
 		   processing */
=20
-		if (do_end_request) {
-			if (stat & ERR_STAT) {
-				unsigned long flags;
-				spin_lock_irqsave(&ide_lock, flags);
-				blkdev_dequeue_request(rq);
-				HWGROUP(drive)->rq =3D NULL;
-				spin_unlock_irqrestore(&ide_lock, flags);
+		if (do_end_request)
+			goto end_request;
=20
-				cdrom_queue_request_sense(drive, rq->sense, rq);
-			} else
-				cdrom_end_request(drive, 0);
-		} else {
-			/* If we got a CHECK_CONDITION status,
-			   queue a request sense command. */
-			if (stat & ERR_STAT)
-				cdrom_queue_request_sense(drive, NULL, NULL);
-		}
+		/*
+		 * If we got a CHECK_CONDITION status,
+		 * queue a request sense command.
+		 */
+		if (stat & ERR_STAT)
+			cdrom_queue_request_sense(drive, NULL, NULL);
 	} else {
 		blk_dump_rq_flags(rq, "ide-cd: bad rq");
 		cdrom_end_request(drive, 0);
@@ -868,6 +456,21 @@ static int cdrom_decode_status(ide_drive_t *drive,=
 int good_stat, int *stat_ret)
=20
 	/* Retry, or handle the next request. */
 	return 1;
+
+end_request:
+	if (stat & ERR_STAT) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ide_lock, flags);
+		blkdev_dequeue_request(rq);
+		HWGROUP(drive)->rq =3D NULL;
+		spin_unlock_irqrestore(&ide_lock, flags);
+
+		cdrom_queue_request_sense(drive, rq->sense, rq);
+	} else
+		cdrom_end_request(drive, 0);
+
+	return 1;
 }
=20
 static int cdrom_timer_expiry(ide_drive_t *drive)
@@ -924,8 +527,8 @@ static ide_startstop_t cdrom_start_packet_command(i=
de_drive_t *drive,
 	/* Set up the controller registers. */
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL |
 			   IDE_TFLAG_NO_SELECT_MASK, xferlen, info->dma);
-=20
-	if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
+
+	if (info->cd_flags & IDE_CD_FLAG_DRQ_INTERRUPT) {
 		/* waiting for CDB interrupt, not DMA yet. */
 		if (info->dma)
 			drive->waiting_for_dma =3D 0;
@@ -951,10 +554,6 @@ static ide_startstop_t cdrom_start_packet_command(=
ide_drive_t *drive,
    by cdrom_start_packet_command.
    HANDLER is the interrupt handler to call when the command completes
    or there's data ready. */
-/*
- * changed 5 parameters to 3 for dvd-ram
- * struct packet_command *pc; now packet_command_t *pc;
- */
 #define ATAPI_MIN_CDB_BYTES 12
 static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *dri=
ve,
 					  struct request *rq,
@@ -965,7 +564,7 @@ static ide_startstop_t cdrom_transfer_packet_comman=
d (ide_drive_t *drive,
 	struct cdrom_info *info =3D drive->driver_data;
 	ide_startstop_t startstop;
=20
-	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
+	if (info->cd_flags & IDE_CD_FLAG_DRQ_INTERRUPT) {
 		/* Here we should have been called after receiving an interrupt
 		   from the device.  DRQ should how be set. */
=20
@@ -1005,6 +604,27 @@ static ide_startstop_t cdrom_transfer_packet_comm=
and (ide_drive_t *drive,
  * Block read functions.
  */
=20
+typedef void (xfer_func_t)(ide_drive_t *, void *, u32);
+
+static void ide_cd_pad_transfer(ide_drive_t *drive, xfer_func_t *xf, i=
nt len)
+{
+	while (len > 0) {
+		int dum =3D 0;
+		xf(drive, &dum, sizeof(dum));
+		len -=3D sizeof(dum);
+	}
+}
+
+static void ide_cd_drain_data(ide_drive_t *drive, int nsects)
+{
+	while (nsects > 0) {
+		static char dum[SECTOR_SIZE];
+
+		drive->hwif->atapi_input_bytes(drive, dum, sizeof(dum));
+		nsects--;
+	}
+}
+
 /*
  * Buffer up to SECTORS_TO_TRANSFER sectors from the drive in our sect=
or
  * buffer.  Once the first sector is added, any subsequent sectors are
@@ -1043,11 +663,7 @@ static void cdrom_buffer_sectors (ide_drive_t *dr=
ive, unsigned long sector,
 	}
=20
 	/* Throw away any remaining data. */
-	while (sectors_to_transfer > 0) {
-		static char dum[SECTOR_SIZE];
-		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
-		--sectors_to_transfer;
-	}
+	ide_cd_drain_data(drive, sectors_to_transfer);
 }
=20
 /*
@@ -1056,23 +672,25 @@ static void cdrom_buffer_sectors (ide_drive_t *d=
rive, unsigned long sector,
  * ok; nonzero if the request has been terminated.
  */
 static
-int cdrom_read_check_ireason (ide_drive_t *drive, int len, int ireason=
)
+int ide_cd_check_ireason(ide_drive_t *drive, int len, int ireason, int=
 rw)
 {
-	if (ireason =3D=3D 2)
+	/*
+	 * ireason =3D=3D 0: the drive wants to receive data from us
+	 * ireason =3D=3D 2: the drive is expecting to transfer data to us
+	 */
+	if (ireason =3D=3D (!rw << 1))
 		return 0;
-	else if (ireason =3D=3D 0) {
-		/* Whoops... The drive is expecting to receive data from us! */
+	else if (ireason =3D=3D (rw << 1)) {
+		ide_hwif_t *hwif =3D drive->hwif;
+		xfer_func_t *xf;
+
+		/* Whoops... */
 		printk(KERN_ERR "%s: %s: wrong transfer direction!\n",
 				drive->name, __FUNCTION__);
=20
-		/* Throw some data at the drive so it doesn't hang
-		   and quit this request. */
-		while (len > 0) {
-			int dum =3D 0;
-			HWIF(drive)->atapi_output_bytes(drive, &dum, sizeof (dum));
-			len -=3D sizeof (dum);
-		}
-	} else  if (ireason =3D=3D 1) {
+		xf =3D rw ? hwif->atapi_output_bytes : hwif->atapi_input_bytes;
+		ide_cd_pad_transfer(drive, xf, len);
+	} else  if (rw =3D=3D 0 && ireason =3D=3D 1) {
 		/* Some drives (ASUS) seem to tell us that status
 		 * info is available. just get it and ignore.
 		 */
@@ -1089,137 +707,28 @@ int cdrom_read_check_ireason (ide_drive_t *driv=
e, int len, int ireason)
 }
=20
 /*
- * Interrupt routine.  Called when a read request has completed.
+ * Assume that the drive will always provide data in multiples of at l=
east
+ * SECTOR_SIZE, as it gets hairy to keep track of the transfers otherw=
ise.
  */
-static ide_startstop_t cdrom_read_intr (ide_drive_t *drive)
+static int ide_cd_check_transfer_size(ide_drive_t *drive, int len)
 {
-	int stat;
-	int ireason, len, sectors_to_transfer, nskip;
-	struct cdrom_info *info =3D drive->driver_data;
-	u8 lowcyl =3D 0, highcyl =3D 0;
-	int dma =3D info->dma, dma_error =3D 0;
-
-	struct request *rq =3D HWGROUP(drive)->rq;
-
-	/*
-	 * handle dma case
-	 */
-	if (dma) {
-		info->dma =3D 0;
-		dma_error =3D HWIF(drive)->ide_dma_end(drive);
-		if (dma_error) {
-			printk(KERN_ERR "%s: DMA read error\n", drive->name);
-			ide_dma_off(drive);
-		}
-	}
-
-	if (cdrom_decode_status(drive, 0, &stat))
-		return ide_stopped;
-
-	if (dma) {
-		if (!dma_error) {
-			ide_end_request(drive, 1, rq->nr_sectors);
-			return ide_stopped;
-		} else
-			return ide_error(drive, "dma error", stat);
-	}
-
-	/* Read the interrupt reason and the transfer length. */
-	ireason =3D HWIF(drive)->INB(IDE_IREASON_REG) & 0x3;
-	lowcyl  =3D HWIF(drive)->INB(IDE_BCOUNTL_REG);
-	highcyl =3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
-
-	len =3D lowcyl + (256 * highcyl);
-
-	/* If DRQ is clear, the command has completed. */
-	if ((stat & DRQ_STAT) =3D=3D 0) {
-		/* If we're not done filling the current buffer, complain.
-		   Otherwise, complete the command normally. */
-		if (rq->current_nr_sectors > 0) {
-			printk (KERN_ERR "%s: cdrom_read_intr: data underrun (%d blocks)\n"=
,
-				drive->name, rq->current_nr_sectors);
-			rq->cmd_flags |=3D REQ_FAILED;
-			cdrom_end_request(drive, 0);
-		} else
-			cdrom_end_request(drive, 1);
-		return ide_stopped;
-	}
-
-	/* Check that the drive is expecting to do the same thing we are. */
-	if (cdrom_read_check_ireason (drive, len, ireason))
-		return ide_stopped;
-
-	/* Assume that the drive will always provide data in multiples
-	   of at least SECTOR_SIZE, as it gets hairy to keep track
-	   of the transfers otherwise. */
-	if ((len % SECTOR_SIZE) !=3D 0) {
-		printk (KERN_ERR "%s: cdrom_read_intr: Bad transfer size %d\n",
-			drive->name, len);
-		if (CDROM_CONFIG_FLAGS(drive)->limit_nframes)
-			printk (KERN_ERR "  This drive is not supported by this version of =
the driver\n");
-		else {
-			printk (KERN_ERR "  Trying to limit transfer sizes\n");
-			CDROM_CONFIG_FLAGS(drive)->limit_nframes =3D 1;
-		}
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	/* The number of sectors we need to read from the drive. */
-	sectors_to_transfer =3D len / SECTOR_SIZE;
-
-	/* First, figure out if we need to bit-bucket
-	   any of the leading sectors. */
-	nskip =3D min_t(int, rq->current_nr_sectors - bio_cur_sectors(rq->bio=
), sectors_to_transfer);
-
-	while (nskip > 0) {
-		/* We need to throw away a sector. */
-		static char dum[SECTOR_SIZE];
-		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
-
-		--rq->current_nr_sectors;
-		--nskip;
-		--sectors_to_transfer;
-	}
+	struct cdrom_info *cd =3D drive->driver_data;
=20
-	/* Now loop while we still have data to read from the drive. */
-	while (sectors_to_transfer > 0) {
-		int this_transfer;
+	if ((len % SECTOR_SIZE) =3D=3D 0)
+		return 0;
=20
-		/* If we've filled the present buffer but there's another
-		   chained buffer after it, move on. */
-		if (rq->current_nr_sectors =3D=3D 0 && rq->nr_sectors)
-			cdrom_end_request(drive, 1);
+	printk(KERN_ERR "%s: %s: Bad transfer size %d\n",
+			drive->name, __FUNCTION__, len);
=20
-		/* If the buffers are full, cache the rest of the data in our
-		   internal buffer. */
-		if (rq->current_nr_sectors =3D=3D 0) {
-			cdrom_buffer_sectors(drive, rq->sector, sectors_to_transfer);
-			sectors_to_transfer =3D 0;
-		} else {
-			/* Transfer data to the buffers.
-			   Figure out how many sectors we can transfer
-			   to the current buffer. */
-			this_transfer =3D min_t(int, sectors_to_transfer,
-					     rq->current_nr_sectors);
-
-			/* Read this_transfer sectors
-			   into the current buffer. */
-			while (this_transfer > 0) {
-				HWIF(drive)->atapi_input_bytes(drive, rq->buffer, SECTOR_SIZE);
-				rq->buffer +=3D SECTOR_SIZE;
-				--rq->nr_sectors;
-				--rq->current_nr_sectors;
-				++rq->sector;
-				--this_transfer;
-				--sectors_to_transfer;
-			}
-		}
+	if (cd->cd_flags & IDE_CD_FLAG_LIMIT_NFRAMES)
+		printk(KERN_ERR "  This drive is not supported by "
+				"this version of the driver\n");
+	else {
+		printk(KERN_ERR "  Trying to limit transfer sizes\n");
+		cd->cd_flags |=3D IDE_CD_FLAG_LIMIT_NFRAMES;
 	}
=20
-	/* Done moving data!  Wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_read_intr, ATAPI_WAIT_PC, NULL);
-	return ide_started;
+	return 1;
 }
=20
 /*
@@ -1281,48 +790,58 @@ static int cdrom_read_from_buffer (ide_drive_t *=
drive)
 	return 0;
 }
=20
+static ide_startstop_t cdrom_newpc_intr(ide_drive_t *);
+
 /*
- * Routine to send a read packet command to the drive.
- * This is usually called directly from cdrom_start_read.
+ * Routine to send a read/write packet command to the drive.
+ * This is usually called directly from cdrom_start_{read,write}().
  * However, for drq_interrupt devices, it is called from an interrupt
  * when the drive is ready to accept the command.
  */
-static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *dri=
ve)
+static ide_startstop_t cdrom_start_rw_cont(ide_drive_t *drive)
 {
 	struct request *rq =3D HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-	int nskip;
=20
-	sectors_per_frame =3D queue_hardsect_size(drive->queue) >> SECTOR_BIT=
S;
+	if (rq_data_dir(rq) =3D=3D READ) {
+		unsigned short sectors_per_frame =3D
+			queue_hardsect_size(drive->queue) >> SECTOR_BITS;
+		int nskip =3D rq->sector & (sectors_per_frame - 1);
=20
-	/* If the requested sector doesn't start on a cdrom block boundary,
-	   we must adjust the start of the transfer so that it does,
-	   and remember to skip the first few sectors.
-	   If the CURRENT_NR_SECTORS field is larger than the size
-	   of the buffer, it will mean that we're to skip a number
-	   of sectors equal to the amount by which CURRENT_NR_SECTORS
-	   is larger than the buffer size. */
-	nskip =3D rq->sector & (sectors_per_frame - 1);
-	if (nskip > 0) {
-		/* Sanity check... */
-		if (rq->current_nr_sectors !=3D bio_cur_sectors(rq->bio) &&
-			(rq->sector & (sectors_per_frame - 1))) {
-			printk(KERN_ERR "%s: cdrom_start_read_continuation: buffer botch (%=
u)\n",
-				drive->name, rq->current_nr_sectors);
-			cdrom_end_request(drive, 0);
-			return ide_stopped;
+		/*
+		 * If the requested sector doesn't start on a frame boundary,
+		 * we must adjust the start of the transfer so that it does,
+		 * and remember to skip the first few sectors.
+		 *
+		 * If the rq->current_nr_sectors field is larger than the size
+		 * of the buffer, it will mean that we're to skip a number of
+		 * sectors equal to the amount by which rq->current_nr_sectors
+		 * is larger than the buffer size.
+		 */
+		if (nskip > 0) {
+			/* Sanity check... */
+			if (rq->current_nr_sectors !=3D
+			    bio_cur_sectors(rq->bio)) {
+				printk(KERN_ERR "%s: %s: buffer botch (%u)\n",
+						drive->name, __FUNCTION__,
+						rq->current_nr_sectors);
+				cdrom_end_request(drive, 0);
+				return ide_stopped;
+			}
+			rq->current_nr_sectors +=3D nskip;
 		}
-		rq->current_nr_sectors +=3D nskip;
 	}
-
+#if 0
+	else
+		/* the immediate bit */
+		rq->cmd[1] =3D 1 << 3;
+#endif
 	/* Set up the command */
 	rq->timeout =3D ATAPI_WAIT_PC;
=20
 	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command(drive, rq, &cdrom_read_intr);
+	return cdrom_transfer_packet_command(drive, rq, cdrom_newpc_intr);
 }
=20
-
 #define IDECD_SEEK_THRESHOLD	(1000)			/* 1000 blocks */
 #define IDECD_SEEK_TIMER	(5 * WAIT_MIN_SLEEP)	/* 100 ms */
 #define IDECD_SEEK_TIMEOUT	(2 * WAIT_CMD)		/* 20 sec */
@@ -1335,7 +854,8 @@ static ide_startstop_t cdrom_seek_intr (ide_drive_=
t *drive)
=20
 	if (cdrom_decode_status(drive, 0, &stat))
 		return ide_stopped;
-	CDROM_CONFIG_FLAGS(drive)->seeking =3D 1;
+
+	info->cd_flags |=3D IDE_CD_FLAG_SEEKING;
=20
 	if (retry && time_after(jiffies, info->start_seek + IDECD_SEEK_TIMER)=
) {
 		if (--retry =3D=3D 0) {
@@ -1391,184 +911,25 @@ static void restore_request (struct request *rq=
)
 	rq->q->prep_rq_fn(rq->q, rq);
 }
=20
-/*
- * Start a read request from the CD-ROM.
- */
-static ide_startstop_t cdrom_start_read (ide_drive_t *drive, unsigned =
int block)
-{
-	struct cdrom_info *info =3D drive->driver_data;
-	struct request *rq =3D HWGROUP(drive)->rq;
-	unsigned short sectors_per_frame;
-
-	sectors_per_frame =3D queue_hardsect_size(drive->queue) >> SECTOR_BIT=
S;
-
-	/* We may be retrying this request after an error.  Fix up
-	   any weirdness which might be present in the request packet. */
-	restore_request(rq);
-
-	/* Satisfy whatever we can of this request from our cached sector. */
-	if (cdrom_read_from_buffer(drive))
-		return ide_stopped;
-
-	/* Clear the local sector buffer. */
-	info->nsectors_buffered =3D 0;
-
-	/* use dma, if possible. */
-	info->dma =3D drive->using_dma;
-	if ((rq->sector & (sectors_per_frame - 1)) ||
-	    (rq->nr_sectors & (sectors_per_frame - 1)))
-		info->dma =3D 0;
-
-	/* Start sending the read request to the drive. */
-	return cdrom_start_packet_command(drive, 32768, cdrom_start_read_cont=
inuation);
-}
-
 /*********************************************************************=
*******
  * Execute all other packet commands.
  */
=20
-/* Interrupt routine for packet command completion. */
-static ide_startstop_t cdrom_pc_intr (ide_drive_t *drive)
+static void ide_cd_request_sense_fixup(struct request *rq)
 {
-	int ireason, len, thislen;
-	struct request *rq =3D HWGROUP(drive)->rq;
-	u8 lowcyl =3D 0, highcyl =3D 0;
-	int stat;
-
-	/* Check for errors. */
-	if (cdrom_decode_status(drive, 0, &stat))
-		return ide_stopped;
-
-	/* Read the interrupt reason and the transfer length. */
-	ireason =3D HWIF(drive)->INB(IDE_IREASON_REG) & 0x3;
-	lowcyl  =3D HWIF(drive)->INB(IDE_BCOUNTL_REG);
-	highcyl =3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
-
-	len =3D lowcyl + (256 * highcyl);
-
-	/* If DRQ is clear, the command has completed.
-	   Complain if we still have data left to transfer. */
-	if ((stat & DRQ_STAT) =3D=3D 0) {
-		/* Some of the trailing request sense fields are optional, and
-		   some drives don't send them.  Sigh. */
-		if (rq->cmd[0] =3D=3D GPCMD_REQUEST_SENSE &&
-		    rq->data_len > 0 &&
-		    rq->data_len <=3D 5) {
-			while (rq->data_len > 0) {
-				*(unsigned char *)rq->data++ =3D 0;
-				--rq->data_len;
-			}
-		}
-
-		if (rq->data_len =3D=3D 0)
-			cdrom_end_request(drive, 1);
-		else {
-			/* Comment this out, because this always happens=20
-			   right after a reset occurs, and it is annoying to=20
-			   always print expected stuff.  */
-			/*
-			printk ("%s: cdrom_pc_intr: data underrun %d\n",
-				drive->name, pc->buflen);
-			*/
-			rq->cmd_flags |=3D REQ_FAILED;
-			cdrom_end_request(drive, 0);
-		}
-		return ide_stopped;
-	}
-
-	/* Figure out how much data to transfer. */
-	thislen =3D rq->data_len;
-	if (thislen > len) thislen =3D len;
-
-	/* The drive wants to be written to. */
-	if (ireason =3D=3D 0) {
-		if (!rq->data) {
-			blk_dump_rq_flags(rq, "cdrom_pc_intr, write");
-			goto confused;
-		}
-		/* Transfer the data. */
-		HWIF(drive)->atapi_output_bytes(drive, rq->data, thislen);
-
-		/* If we haven't moved enough data to satisfy the drive,
-		   add some padding. */
-		while (len > thislen) {
-			int dum =3D 0;
-			HWIF(drive)->atapi_output_bytes(drive, &dum, sizeof(dum));
-			len -=3D sizeof(dum);
-		}
-
-		/* Keep count of how much data we've moved. */
-		rq->data +=3D thislen;
-		rq->data_len -=3D thislen;
-	}
-
-	/* Same drill for reading. */
-	else if (ireason =3D=3D 2) {
-		if (!rq->data) {
-			blk_dump_rq_flags(rq, "cdrom_pc_intr, read");
-			goto confused;
-		}
-		/* Transfer the data. */
-		HWIF(drive)->atapi_input_bytes(drive, rq->data, thislen);
-
-		/* If we haven't moved enough data to satisfy the drive,
-		   add some padding. */
-		while (len > thislen) {
-			int dum =3D 0;
-			HWIF(drive)->atapi_input_bytes(drive, &dum, sizeof(dum));
-			len -=3D sizeof(dum);
+	/*
+	 * Some of the trailing request sense fields are optional,
+	 * and some drives don't send them.  Sigh.
+	 */
+	if (rq->cmd[0] =3D=3D GPCMD_REQUEST_SENSE &&
+	    rq->data_len > 0 && rq->data_len <=3D 5)
+		while (rq->data_len > 0) {
+			*(u8 *)rq->data++ =3D 0;
+			--rq->data_len;
 		}
-
-		/* Keep count of how much data we've moved. */
-		rq->data +=3D thislen;
-		rq->data_len -=3D thislen;
-
-		if (blk_sense_request(rq))
-			rq->sense_len +=3D thislen;
-	} else {
-confused:
-		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
-			"appears confused (ireason =3D 0x%02x). "
-			"Trying to recover by ending request.\n",
-			drive->name, ireason);
-		rq->cmd_flags |=3D REQ_FAILED;
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	/* Now we wait for another interrupt. */
-	ide_set_handler(drive, &cdrom_pc_intr, ATAPI_WAIT_PC, cdrom_timer_exp=
iry);
-	return ide_started;
 }
=20
-static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
-{
-	struct request *rq =3D HWGROUP(drive)->rq;
-
-	if (!rq->timeout)
-		rq->timeout =3D ATAPI_WAIT_PC;
-
-	/* Send the command to the drive and return. */
-	return cdrom_transfer_packet_command(drive, rq, &cdrom_pc_intr);
-}
-
-
-static ide_startstop_t cdrom_do_packet_command (ide_drive_t *drive)
-{
-	int len;
-	struct request *rq =3D HWGROUP(drive)->rq;
-	struct cdrom_info *info =3D drive->driver_data;
-
-	info->dma =3D 0;
-	rq->cmd_flags &=3D ~REQ_FAILED;
-	len =3D rq->data_len;
-
-	/* Start sending the command to the drive. */
-	return cdrom_start_packet_command(drive, len, cdrom_do_pc_continuatio=
n);
-}
-
-
-static int cdrom_queue_packet_command(ide_drive_t *drive, struct reque=
st *rq)
+int ide_cd_queue_pc(ide_drive_t *drive, struct request *rq)
 {
 	struct request_sense sense;
 	int retries =3D 10;
@@ -1617,37 +978,6 @@ static int cdrom_queue_packet_command(ide_drive_t=
 *drive, struct request *rq)
 }
=20
 /*
- * Write handling
- */
-static int cdrom_write_check_ireason(ide_drive_t *drive, int len, int =
ireason)
-{
-	/* Two notes about IDE interrupt reason here - 0 means that
-	 * the drive wants to receive data from us, 2 means that
-	 * the drive is expecting to transfer data to us.
-	 */
-	if (ireason =3D=3D 0)
-		return 0;
-	else if (ireason =3D=3D 2) {
-		/* Whoops... The drive wants to send data. */
-		printk(KERN_ERR "%s: %s: wrong transfer direction!\n",
-				drive->name, __FUNCTION__);
-
-		while (len > 0) {
-			int dum =3D 0;
-			HWIF(drive)->atapi_input_bytes(drive, &dum, sizeof(dum));
-			len -=3D sizeof(dum);
-		}
-	} else {
-		/* Drive wants a command packet, or invalid ireason... */
-		printk(KERN_ERR "%s: %s: bad interrupt reason 0x%02x\n",
-				drive->name, __FUNCTION__, ireason);
-	}
-
-	cdrom_end_request(drive, 0);
-	return 1;
-}
-
-/*
  * Called from blk_end_request_callback() after the data of the reques=
t
  * is completed and before the request is completed.
  * By returning value '1', blk_end_request_callback() returns immediat=
ely
@@ -1658,29 +988,27 @@ static int cdrom_newpc_intr_dummy_cb(struct requ=
est *rq)
 	return 1;
 }
=20
-typedef void (xfer_func_t)(ide_drive_t *, void *, u32);
-
-/*
- * best way to deal with dma that is not sector aligned right now... n=
ote
- * that in this path we are not using ->data or ->buffer at all. this =
irs
- * can replace cdrom_pc_intr, cdrom_read_intr, and cdrom_write_intr in=
 the
- * future.
- */
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 {
 	struct cdrom_info *info =3D drive->driver_data;
 	struct request *rq =3D HWGROUP(drive)->rq;
-	int dma_error, dma, stat, ireason, len, thislen;
-	u8 lowcyl, highcyl;
 	xfer_func_t *xferfunc;
-	unsigned long flags;
+	ide_expiry_t *expiry =3D NULL;
+	int dma_error =3D 0, dma, stat, ireason, len, thislen, uptodate =3D 0=
;
+	int write =3D (rq_data_dir(rq) =3D=3D WRITE) ? 1 : 0;
+	unsigned int timeout;
+	u8 lowcyl, highcyl;
=20
 	/* Check for errors. */
-	dma_error =3D 0;
 	dma =3D info->dma;
 	if (dma) {
 		info->dma =3D 0;
 		dma_error =3D HWIF(drive)->ide_dma_end(drive);
+		if (dma_error) {
+			printk(KERN_ERR "%s: DMA %s error\n", drive->name,
+					write ? "write" : "read");
+			ide_dma_off(drive);
+		}
 	}
=20
 	if (cdrom_decode_status(drive, 0, &stat))
@@ -1690,19 +1018,13 @@ static ide_startstop_t cdrom_newpc_intr(ide_dri=
ve_t *drive)
 	 * using dma, transfer is complete now
 	 */
 	if (dma) {
-		if (dma_error) {
-			printk(KERN_ERR "ide-cd: dma error\n");
-			ide_dma_off(drive);
+		if (dma_error)
 			return ide_error(drive, "dma error", stat);
+		if (blk_fs_request(rq)) {
+			ide_end_request(drive, 1, rq->nr_sectors);
+			return ide_stopped;
 		}
-
-		spin_lock_irqsave(&ide_lock, flags);
-		if (__blk_end_request(rq, 0, rq->data_len))
-			BUG();
-		HWGROUP(drive)->rq =3D NULL;
-		spin_unlock_irqrestore(&ide_lock, flags);
-
-		return ide_stopped;
+		goto end_request;
 	}
=20
 	/*
@@ -1713,7 +1035,8 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive=
_t *drive)
 	highcyl =3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
=20
 	len =3D lowcyl + (256 * highcyl);
-	thislen =3D rq->data_len;
+
+	thislen =3D blk_fs_request(rq) ? len : rq->data_len;
 	if (thislen > len)
 		thislen =3D len;
=20
@@ -1721,53 +1044,111 @@ static ide_startstop_t cdrom_newpc_intr(ide_dr=
ive_t *drive)
 	 * If DRQ is clear, the command has completed.
 	 */
 	if ((stat & DRQ_STAT) =3D=3D 0) {
-		spin_lock_irqsave(&ide_lock, flags);
-		if (__blk_end_request(rq, 0, rq->data_len))
-			BUG();
-		HWGROUP(drive)->rq =3D NULL;
-		spin_unlock_irqrestore(&ide_lock, flags);
-
-		return ide_stopped;
+		if (blk_fs_request(rq)) {
+			/*
+			 * If we're not done reading/writing, complain.
+			 * Otherwise, complete the command normally.
+			 */
+			uptodate =3D 1;
+			if (rq->current_nr_sectors > 0) {
+				printk(KERN_ERR "%s: %s: data underrun "
+						"(%d blocks)\n",
+						drive->name, __FUNCTION__,
+						rq->current_nr_sectors);
+				if (!write)
+					rq->cmd_flags |=3D REQ_FAILED;
+				uptodate =3D 0;
+			}
+			cdrom_end_request(drive, uptodate);
+			return ide_stopped;
+		} else if (!blk_pc_request(rq)) {
+			ide_cd_request_sense_fixup(rq);
+			/* Complain if we still have data left to transfer. */
+			uptodate =3D rq->data_len ? 0 : 1;
+		}
+		goto end_request;
 	}
=20
 	/*
 	 * check which way to transfer data
 	 */
-	if (rq_data_dir(rq) =3D=3D WRITE) {
-		/*
-		 * write to drive
-		 */
-		if (cdrom_write_check_ireason(drive, len, ireason))
+	if (blk_fs_request(rq) || blk_pc_request(rq)) {
+		if (ide_cd_check_ireason(drive, len, ireason, write))
 			return ide_stopped;
=20
-		xferfunc =3D HWIF(drive)->atapi_output_bytes;
-	} else  {
-		/*
-		 * read from drive
-		 */
-		if (cdrom_read_check_ireason(drive, len, ireason))
-			return ide_stopped;
+		if (blk_fs_request(rq) && write =3D=3D 0) {
+			int nskip;
=20
+			if (ide_cd_check_transfer_size(drive, len)) {
+				cdrom_end_request(drive, 0);
+				return ide_stopped;
+			}
+
+			/*
+			 * First, figure out if we need to bit-bucket
+			 * any of the leading sectors.
+			 */
+			nskip =3D min_t(int, rq->current_nr_sectors
+					   - bio_cur_sectors(rq->bio),
+					   thislen >> 9);
+			if (nskip > 0) {
+				ide_cd_drain_data(drive, nskip);
+				rq->current_nr_sectors -=3D nskip;
+				thislen -=3D (nskip << 9);
+			}
+		}
+	}
+
+	if (ireason =3D=3D 0) {
+		write =3D 1;
+		xferfunc =3D HWIF(drive)->atapi_output_bytes;
+	} else if (ireason =3D=3D 2 || (ireason =3D=3D 1 &&
+		   (blk_fs_request(rq) || blk_pc_request(rq)))) {
+		write =3D 0;
 		xferfunc =3D HWIF(drive)->atapi_input_bytes;
+	} else {
+		printk(KERN_ERR "%s: %s: The drive "
+				"appears confused (ireason =3D 0x%02x). "
+				"Trying to recover by ending request.\n",
+				drive->name, __FUNCTION__, ireason);
+		goto end_request;
 	}
=20
 	/*
 	 * transfer data
 	 */
 	while (thislen > 0) {
-		int blen =3D blen =3D rq->data_len;
-		char *ptr =3D rq->data;
+		u8 *ptr =3D blk_fs_request(rq) ? NULL : rq->data;
+		int blen =3D rq->data_len;
=20
 		/*
 		 * bio backed?
 		 */
 		if (rq->bio) {
-			ptr =3D bio_data(rq->bio);
-			blen =3D bio_iovec(rq->bio)->bv_len;
+			if (blk_fs_request(rq)) {
+				ptr =3D rq->buffer;
+				blen =3D rq->current_nr_sectors << 9;
+			} else {
+				ptr =3D bio_data(rq->bio);
+				blen =3D bio_iovec(rq->bio)->bv_len;
+			}
 		}
=20
 		if (!ptr) {
-			printk(KERN_ERR "%s: confused, missing data\n", drive->name);
+			if (blk_fs_request(rq) && !write)
+				/*
+				 * If the buffers are full, cache the rest
+				 * of the data in our internal buffer.
+				 */
+				cdrom_buffer_sectors(drive, rq->sector,
+						     thislen >> 9);
+			else {
+				printk(KERN_ERR "%s: confused, missing data\n",
+						drive->name);
+				blk_dump_rq_flags(rq, rq_data_dir(rq)
+						  ? "cdrom_newpc_intr, write"
+						  : "cdrom_newpc_intr, read");
+			}
 			break;
 		}
=20
@@ -1778,185 +1159,117 @@ static ide_startstop_t cdrom_newpc_intr(ide_d=
rive_t *drive)
=20
 		thislen -=3D blen;
 		len -=3D blen;
-		rq->data_len -=3D blen;
=20
-		if (rq->bio)
+		if (blk_fs_request(rq)) {
+			rq->buffer +=3D blen;
+			rq->nr_sectors -=3D (blen >> 9);
+			rq->current_nr_sectors -=3D (blen >> 9);
+			rq->sector +=3D (blen >> 9);
+
+			if (rq->current_nr_sectors =3D=3D 0 && rq->nr_sectors)
+				cdrom_end_request(drive, 1);
+		} else {
+			rq->data_len -=3D blen;
+
 			/*
 			 * The request can't be completed until DRQ is cleared.
 			 * So complete the data, but don't complete the request
 			 * using the dummy function for the callback feature
 			 * of blk_end_request_callback().
 			 */
-			blk_end_request_callback(rq, 0, blen,
+			if (rq->bio)
+				blk_end_request_callback(rq, 0, blen,
 						 cdrom_newpc_intr_dummy_cb);
-		else
-			rq->data +=3D blen;
-	}
-
-	/*
-	 * pad, if necessary
-	 */
-	if (len > 0) {
-		while (len > 0) {
-			int pad =3D 0;
-
-			xferfunc(drive, &pad, sizeof(pad));
-			len -=3D sizeof(pad);
-		}
-	}
-
-	BUG_ON(HWGROUP(drive)->handler !=3D NULL);
-
-	ide_set_handler(drive, cdrom_newpc_intr, rq->timeout, NULL);
-	return ide_started;
-}
-
-static ide_startstop_t cdrom_write_intr(ide_drive_t *drive)
-{
-	int stat, ireason, len, sectors_to_transfer, uptodate;
-	struct cdrom_info *info =3D drive->driver_data;
-	int dma_error =3D 0, dma =3D info->dma;
-	u8 lowcyl =3D 0, highcyl =3D 0;
-
-	struct request *rq =3D HWGROUP(drive)->rq;
-
-	/* Check for errors. */
-	if (dma) {
-		info->dma =3D 0;
-		dma_error =3D HWIF(drive)->ide_dma_end(drive);
-		if (dma_error) {
-			printk(KERN_ERR "%s: DMA write error\n", drive->name);
-			ide_dma_off(drive);
+			else
+				rq->data +=3D blen;
 		}
 	}
=20
-	if (cdrom_decode_status(drive, 0, &stat))
-		return ide_stopped;
+	if (write && blk_sense_request(rq))
+		rq->sense_len +=3D thislen;
=20
 	/*
-	 * using dma, transfer is complete now
+	 * pad, if necessary
 	 */
-	if (dma) {
-		if (dma_error)
-			return ide_error(drive, "dma error", stat);
+	if (!blk_fs_request(rq) && len > 0)
+		ide_cd_pad_transfer(drive, xferfunc, len);
=20
-		ide_end_request(drive, 1, rq->nr_sectors);
-		return ide_stopped;
+	if (blk_pc_request(rq)) {
+		timeout =3D rq->timeout;
+	} else {
+		timeout =3D ATAPI_WAIT_PC;
+		if (!blk_fs_request(rq))
+			expiry =3D cdrom_timer_expiry;
 	}
=20
-	/* Read the interrupt reason and the transfer length. */
-	ireason =3D HWIF(drive)->INB(IDE_IREASON_REG) & 0x3;
-	lowcyl  =3D HWIF(drive)->INB(IDE_BCOUNTL_REG);
-	highcyl =3D HWIF(drive)->INB(IDE_BCOUNTH_REG);
+	ide_set_handler(drive, cdrom_newpc_intr, timeout, expiry);
+	return ide_started;
=20
-	len =3D lowcyl + (256 * highcyl);
+end_request:
+	if (blk_pc_request(rq)) {
+		unsigned long flags;
=20
-	/* If DRQ is clear, the command has completed. */
-	if ((stat & DRQ_STAT) =3D=3D 0) {
-		/* If we're not done writing, complain.
-		 * Otherwise, complete the command normally.
-		 */
-		uptodate =3D 1;
-		if (rq->current_nr_sectors > 0) {
-			printk(KERN_ERR "%s: %s: data underrun (%d blocks)\n",
-					drive->name, __FUNCTION__,
-					rq->current_nr_sectors);
-			uptodate =3D 0;
-		}
+		spin_lock_irqsave(&ide_lock, flags);
+		if (__blk_end_request(rq, 0, rq->data_len))
+			BUG();
+		HWGROUP(drive)->rq =3D NULL;
+		spin_unlock_irqrestore(&ide_lock, flags);
+	} else {
+		if (!uptodate)
+			rq->cmd_flags |=3D REQ_FAILED;
 		cdrom_end_request(drive, uptodate);
-		return ide_stopped;
 	}
+	return ide_stopped;
+}
=20
-	/* Check that the drive is expecting to do the same thing we are. */
-	if (cdrom_write_check_ireason(drive, len, ireason))
-		return ide_stopped;
-
-	sectors_to_transfer =3D len / SECTOR_SIZE;
-
-	/*
-	 * now loop and write out the data
-	 */
-	while (sectors_to_transfer > 0) {
-		int this_transfer;
-
-		if (!rq->current_nr_sectors) {
-			printk(KERN_ERR "%s: %s: confused, missing data\n",
-					drive->name, __FUNCTION__);
-			break;
-		}
+static ide_startstop_t cdrom_start_rw(ide_drive_t *drive, struct reque=
st *rq)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	int write =3D rq_data_dir(rq) =3D=3D WRITE;
+	unsigned short sectors_per_frame =3D
+		queue_hardsect_size(drive->queue) >> SECTOR_BITS;
=20
+	if (write) {
 		/*
-		 * Figure out how many sectors we can transfer
+		 * disk has become write protected
 		 */
-		this_transfer =3D min_t(int, sectors_to_transfer, rq->current_nr_sec=
tors);
-
-		while (this_transfer > 0) {
-			HWIF(drive)->atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
-			rq->buffer +=3D SECTOR_SIZE;
-			--rq->nr_sectors;
-			--rq->current_nr_sectors;
-			++rq->sector;
-			--this_transfer;
-			--sectors_to_transfer;
+		if (cd->disk->policy) {
+			cdrom_end_request(drive, 0);
+			return ide_stopped;
 		}
-
+	} else {
 		/*
-		 * current buffer complete, move on
+		 * We may be retrying this request after an error.  Fix up any
+		 * weirdness which might be present in the request packet.
 		 */
-		if (rq->current_nr_sectors =3D=3D 0 && rq->nr_sectors)
-			cdrom_end_request(drive, 1);
-	}
-
-	/* re-arm handler */
-	ide_set_handler(drive, &cdrom_write_intr, ATAPI_WAIT_PC, NULL);
-	return ide_started;
-}
-
-static ide_startstop_t cdrom_start_write_cont(ide_drive_t *drive)
-{
-	struct request *rq =3D HWGROUP(drive)->rq;
+		restore_request(rq);
=20
-#if 0	/* the immediate bit */
-	rq->cmd[1] =3D 1 << 3;
-#endif
-	rq->timeout =3D ATAPI_WAIT_PC;
-
-	return cdrom_transfer_packet_command(drive, rq, cdrom_write_intr);
-}
-
-static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct re=
quest *rq)
-{
-	struct cdrom_info *info =3D drive->driver_data;
-	struct gendisk *g =3D info->disk;
-	unsigned short sectors_per_frame =3D queue_hardsect_size(drive->queue=
) >> SECTOR_BITS;
+		/* Satisfy whatever we can of this request from our cache. */
+		if (cdrom_read_from_buffer(drive))
+			return ide_stopped;
+	}
=20
 	/*
-	 * writes *must* be hardware frame aligned
+	 * use DMA, if possible / writes *must* be hardware frame aligned
 	 */
 	if ((rq->nr_sectors & (sectors_per_frame - 1)) ||
 	    (rq->sector & (sectors_per_frame - 1))) {
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	/*
-	 * disk has become write protected
-	 */
-	if (g->policy) {
-		cdrom_end_request(drive, 0);
-		return ide_stopped;
-	}
-
-	info->nsectors_buffered =3D 0;
+		if (write) {
+			cdrom_end_request(drive, 0);
+			return ide_stopped;
+		}
+		cd->dma =3D 0;
+	} else
+		cd->dma =3D drive->using_dma;
=20
-	/* use dma, if possible. we don't need to check more, since we
-	 * know that the transfer is always (at least!) frame aligned */
-	info->dma =3D drive->using_dma ? 1 : 0;
+	/* Clear the local sector buffer. */
+	cd->nsectors_buffered =3D 0;
=20
-	info->devinfo.media_written =3D 1;
+	if (write)
+		cd->devinfo.media_written =3D 1;
=20
-	/* Start sending the write request to the drive. */
-	return cdrom_start_packet_command(drive, 32768, cdrom_start_write_con=
t);
+	/* Start sending the read/write request to the drive. */
+	return cdrom_start_packet_command(drive, 32768, cdrom_start_rw_cont);
 }
=20
 static ide_startstop_t cdrom_do_newpc_cont(ide_drive_t *drive)
@@ -1973,7 +1286,10 @@ static ide_startstop_t cdrom_do_block_pc(ide_dri=
ve_t *drive, struct request *rq)
 {
 	struct cdrom_info *info =3D drive->driver_data;
=20
-	rq->cmd_flags |=3D REQ_QUIET;
+	if (blk_pc_request(rq))
+		rq->cmd_flags |=3D REQ_QUIET;
+	else
+		rq->cmd_flags &=3D ~REQ_FAILED;
=20
 	info->dma =3D 0;
=20
@@ -2010,7 +1326,7 @@ ide_do_rw_cdrom (ide_drive_t *drive, struct reque=
st *rq, sector_t block)
 	struct cdrom_info *info =3D drive->driver_data;
=20
 	if (blk_fs_request(rq)) {
-		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
+		if (info->cd_flags & IDE_CD_FLAG_SEEKING) {
 			unsigned long elapsed =3D jiffies - info->start_seek;
 			int stat =3D HWIF(drive)->INB(IDE_STATUS_REG);
=20
@@ -2021,22 +1337,16 @@ ide_do_rw_cdrom (ide_drive_t *drive, struct req=
uest *rq, sector_t block)
 				}
 				printk (KERN_ERR "%s: DSC timeout\n", drive->name);
 			}
-			CDROM_CONFIG_FLAGS(drive)->seeking =3D 0;
+			info->cd_flags &=3D ~IDE_CD_FLAG_SEEKING;
 		}
 		if ((rq_data_dir(rq) =3D=3D READ) && IDE_LARGE_SEEK(info->last_block=
, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap) {
 			action =3D cdrom_start_seek(drive, block);
-		} else {
-			if (rq_data_dir(rq) =3D=3D READ)
-				action =3D cdrom_start_read(drive, block);
-			else
-				action =3D cdrom_start_write(drive, rq);
-		}
+		} else
+			action =3D cdrom_start_rw(drive, rq);
 		info->last_block =3D block;
 		return action;
-	} else if (rq->cmd_type =3D=3D REQ_TYPE_SENSE ||
+	} else if (blk_sense_request(rq) || blk_pc_request(rq) ||
 		   rq->cmd_type =3D=3D REQ_TYPE_ATA_PC) {
-		return cdrom_do_packet_command(drive);
-	} else if (blk_pc_request(rq)) {
 		return cdrom_do_block_pc(drive, rq);
 	} else if (blk_special_request(rq)) {
 		/*
@@ -2063,141 +1373,33 @@ ide_do_rw_cdrom (ide_drive_t *drive, struct re=
quest *rq, sector_t block)
  * can also be NULL, in which case no sense information is returned.
  */
=20
-#if ! STANDARD_ATAPI
-static inline
-int bin2bcd (int x)
-{
-	return (x%10) | ((x/10) << 4);
-}
-
-
-static inline
-int bcd2bin (int x)
-{
-	return (x >> 4) * 10 + (x & 0x0f);
-}
-
 static
 void msf_from_bcd (struct atapi_msf *msf)
 {
-	msf->minute =3D bcd2bin (msf->minute);
-	msf->second =3D bcd2bin (msf->second);
-	msf->frame  =3D bcd2bin (msf->frame);
-}
-
-#endif /* not STANDARD_ATAPI */
-
-
-static inline
-void lba_to_msf (int lba, byte *m, byte *s, byte *f)
-{
-	lba +=3D CD_MSF_OFFSET;
-	lba &=3D 0xffffff;  /* negative lbas use only 24 bits */
-	*m =3D lba / (CD_SECS * CD_FRAMES);
-	lba %=3D (CD_SECS * CD_FRAMES);
-	*s =3D lba / CD_FRAMES;
-	*f =3D lba % CD_FRAMES;
-}
-
-
-static inline
-int msf_to_lba (byte m, byte s, byte f)
-{
-	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
+	msf->minute =3D BCD2BIN(msf->minute);
+	msf->second =3D BCD2BIN(msf->second);
+	msf->frame  =3D BCD2BIN(msf->frame);
 }
=20
-static int cdrom_check_status(ide_drive_t *drive, struct request_sense=
 *sense)
+int cdrom_check_status(ide_drive_t *drive, struct request_sense *sense=
)
 {
 	struct request req;
 	struct cdrom_info *info =3D drive->driver_data;
 	struct cdrom_device_info *cdi =3D &info->devinfo;
=20
-	cdrom_prepare_request(drive, &req);
+	ide_cd_init_rq(drive, &req);
=20
 	req.sense =3D sense;
 	req.cmd[0] =3D GPCMD_TEST_UNIT_READY;
 	req.cmd_flags |=3D REQ_QUIET;
=20
-#if ! STANDARD_ATAPI
-        /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to=20
-           switch CDs instead of supporting the LOAD_UNLOAD opcode   *=
/
-
+	/*
+	 * Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
+	 * switch CDs instead of supporting the LOAD_UNLOAD opcode.
+	 */
 	req.cmd[7] =3D cdi->sanyo_slot % 3;
-#endif /* not STANDARD_ATAPI */
-
-	return cdrom_queue_packet_command(drive, &req);
-}
-
-
-/* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
-static int
-cdrom_lockdoor(ide_drive_t *drive, int lockflag, struct request_sense =
*sense)
-{
-	struct request_sense my_sense;
-	struct request req;
-	int stat;
-
-	if (sense =3D=3D NULL)
-		sense =3D &my_sense;
-
-	/* If the drive cannot lock the door, just pretend. */
-	if (CDROM_CONFIG_FLAGS(drive)->no_doorlock) {
-		stat =3D 0;
-	} else {
-		cdrom_prepare_request(drive, &req);
-		req.sense =3D sense;
-		req.cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
-		req.cmd[4] =3D lockflag ? 1 : 0;
-		stat =3D cdrom_queue_packet_command(drive, &req);
-	}
-
-	/* If we got an illegal field error, the drive
-	   probably cannot lock the door. */
-	if (stat !=3D 0 &&
-	    sense->sense_key =3D=3D ILLEGAL_REQUEST &&
-	    (sense->asc =3D=3D 0x24 || sense->asc =3D=3D 0x20)) {
-		printk (KERN_ERR "%s: door locking not supported\n",
-			drive->name);
-		CDROM_CONFIG_FLAGS(drive)->no_doorlock =3D 1;
-		stat =3D 0;
-	}
-=09
-	/* no medium, that's alright. */
-	if (stat !=3D 0 && sense->sense_key =3D=3D NOT_READY && sense->asc =3D=
=3D 0x3a)
-		stat =3D 0;
-
-	if (stat =3D=3D 0)
-		CDROM_STATE_FLAGS(drive)->door_locked =3D lockflag;
-
-	return stat;
-}
=20
-
-/* Eject the disk if EJECTFLAG is 0.
-   If EJECTFLAG is 1, try to reload the disk. */
-static int cdrom_eject(ide_drive_t *drive, int ejectflag,
-		       struct request_sense *sense)
-{
-	struct request req;
-	char loej =3D 0x02;
-
-	if (CDROM_CONFIG_FLAGS(drive)->no_eject && !ejectflag)
-		return -EDRIVE_CANT_DO_THIS;
-=09
-	/* reload fails on some drives, if the tray is locked */
-	if (CDROM_STATE_FLAGS(drive)->door_locked && ejectflag)
-		return 0;
-
-	cdrom_prepare_request(drive, &req);
-
-	/* only tell drive to close tray if open, if it can do that */
-	if (ejectflag && !CDROM_CONFIG_FLAGS(drive)->close_tray)
-		loej =3D 0;
-
-	req.sense =3D sense;
-	req.cmd[0] =3D GPCMD_START_STOP_UNIT;
-	req.cmd[4] =3D loej | (ejectflag !=3D 0);
-	return cdrom_queue_packet_command(drive, &req);
+	return ide_cd_queue_pc(drive, &req);
 }
=20
 static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capa=
city,
@@ -2212,7 +1414,7 @@ static int cdrom_read_capacity(ide_drive_t *drive=
, unsigned long *capacity,
 	int stat;
 	struct request req;
=20
-	cdrom_prepare_request(drive, &req);
+	ide_cd_init_rq(drive, &req);
=20
 	req.sense =3D sense;
 	req.cmd[0] =3D GPCMD_READ_CDVD_CAPACITY;
@@ -2220,7 +1422,7 @@ static int cdrom_read_capacity(ide_drive_t *drive=
, unsigned long *capacity,
 	req.data_len =3D sizeof(capbuf);
 	req.cmd_flags |=3D REQ_QUIET;
=20
-	stat =3D cdrom_queue_packet_command(drive, &req);
+	stat =3D ide_cd_queue_pc(drive, &req);
 	if (stat =3D=3D 0) {
 		*capacity =3D 1 + be32_to_cpu(capbuf.lba);
 		*sectors_per_frame =3D
@@ -2236,7 +1438,7 @@ static int cdrom_read_tocentry(ide_drive_t *drive=
, int trackno, int msf_flag,
 {
 	struct request req;
=20
-	cdrom_prepare_request(drive, &req);
+	ide_cd_init_rq(drive, &req);
=20
 	req.sense =3D sense;
 	req.data =3D  buf;
@@ -2251,12 +1453,11 @@ static int cdrom_read_tocentry(ide_drive_t *dri=
ve, int trackno, int msf_flag,
 	if (msf_flag)
 		req.cmd[1] =3D 2;
=20
-	return cdrom_queue_packet_command(drive, &req);
+	return ide_cd_queue_pc(drive, &req);
 }
=20
-
 /* Try to read the entire TOC for the disk into our internal buffer. *=
/
-static int cdrom_read_toc(ide_drive_t *drive, struct request_sense *se=
nse)
+int ide_cd_read_toc(ide_drive_t *drive, struct request_sense *sense)
 {
 	int stat, ntracks, i;
 	struct cdrom_info *info =3D drive->driver_data;
@@ -2283,7 +1484,7 @@ static int cdrom_read_toc(ide_drive_t *drive, str=
uct request_sense *sense)
 	   If it is, just return. */
 	(void) cdrom_check_status(drive, sense);
=20
-	if (CDROM_STATE_FLAGS(drive)->toc_valid)
+	if (info->cd_flags & IDE_CD_FLAG_TOC_VALID)
 		return 0;
=20
 	/* Try to get the total cdrom capacity and sector size. */
@@ -2305,12 +1506,10 @@ static int cdrom_read_toc(ide_drive_t *drive, s=
truct request_sense *sense)
 	if (stat)
 		return stat;
=20
-#if ! STANDARD_ATAPI
-	if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
-		toc->hdr.first_track =3D bcd2bin(toc->hdr.first_track);
-		toc->hdr.last_track  =3D bcd2bin(toc->hdr.last_track);
+	if (info->cd_flags & IDE_CD_FLAG_TOCTRACKS_AS_BCD) {
+		toc->hdr.first_track =3D BCD2BIN(toc->hdr.first_track);
+		toc->hdr.last_track  =3D BCD2BIN(toc->hdr.last_track);
 	}
-#endif  /* not STANDARD_ATAPI */
=20
 	ntracks =3D toc->hdr.last_track - toc->hdr.first_track + 1;
 	if (ntracks <=3D 0)
@@ -2342,16 +1541,13 @@ static int cdrom_read_toc(ide_drive_t *drive, s=
truct request_sense *sense)
 					   (ntracks + 1) *
 					   sizeof(struct atapi_toc_entry),
 					   sense);
-		if (stat) {
+		if (stat)
 			return stat;
-		}
-#if ! STANDARD_ATAPI
-		if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
-			toc->hdr.first_track =3D bin2bcd(CDROM_LEADOUT);
-			toc->hdr.last_track =3D bin2bcd(CDROM_LEADOUT);
-		} else
-#endif  /* not STANDARD_ATAPI */
-		{
+
+		if (info->cd_flags & IDE_CD_FLAG_TOCTRACKS_AS_BCD) {
+			toc->hdr.first_track =3D (u8)BIN2BCD(CDROM_LEADOUT);
+			toc->hdr.last_track =3D (u8)BIN2BCD(CDROM_LEADOUT);
+		} else {
 			toc->hdr.first_track =3D CDROM_LEADOUT;
 			toc->hdr.last_track =3D CDROM_LEADOUT;
 		}
@@ -2362,21 +1558,17 @@ static int cdrom_read_toc(ide_drive_t *drive, s=
truct request_sense *sense)
=20
 	toc->hdr.toc_length =3D ntohs (toc->hdr.toc_length);
=20
-#if ! STANDARD_ATAPI
-	if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
-		toc->hdr.first_track =3D bcd2bin(toc->hdr.first_track);
-		toc->hdr.last_track  =3D bcd2bin(toc->hdr.last_track);
+	if (info->cd_flags & IDE_CD_FLAG_TOCTRACKS_AS_BCD) {
+		toc->hdr.first_track =3D BCD2BIN(toc->hdr.first_track);
+		toc->hdr.last_track  =3D BCD2BIN(toc->hdr.last_track);
 	}
-#endif  /* not STANDARD_ATAPI */
=20
-	for (i=3D0; i<=3Dntracks; i++) {
-#if ! STANDARD_ATAPI
-		if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd) {
-			if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd)
-				toc->ent[i].track =3D bcd2bin(toc->ent[i].track);
+	for (i =3D 0; i <=3D ntracks; i++) {
+		if (info->cd_flags & IDE_CD_FLAG_TOCADDR_AS_BCD) {
+			if (info->cd_flags & IDE_CD_FLAG_TOCTRACKS_AS_BCD)
+				toc->ent[i].track =3D BCD2BIN(toc->ent[i].track);
 			msf_from_bcd(&toc->ent[i].addr.msf);
 		}
-#endif  /* not STANDARD_ATAPI */
 		toc->ent[i].addr.lba =3D msf_to_lba (toc->ent[i].addr.msf.minute,
 						   toc->ent[i].addr.msf.second,
 						   toc->ent[i].addr.msf.frame);
@@ -2396,8 +1588,7 @@ static int cdrom_read_toc(ide_drive_t *drive, str=
uct request_sense *sense)
 		toc->last_session_lba =3D msf_to_lba(0, 2, 0); /* 0m 2s 0f */
 	}
=20
-#if ! STANDARD_ATAPI
-	if (CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd) {
+	if (info->cd_flags & IDE_CD_FLAG_TOCADDR_AS_BCD) {
 		/* Re-read multisession information using MSF format */
 		stat =3D cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
@@ -2409,7 +1600,6 @@ static int cdrom_read_toc(ide_drive_t *drive, str=
uct request_sense *sense)
 					  	   ms_tmp.ent.addr.msf.second,
 						   ms_tmp.ent.addr.msf.frame);
 	}
-#endif  /* not STANDARD_ATAPI */
=20
 	toc->xa_flag =3D (ms_tmp.hdr.first_track !=3D ms_tmp.hdr.last_track);
=20
@@ -2422,278 +1612,22 @@ static int cdrom_read_toc(ide_drive_t *drive, =
struct request_sense *sense)
 	}
=20
 	/* Remember that we've read this stuff. */
-	CDROM_STATE_FLAGS(drive)->toc_valid =3D 1;
+	info->cd_flags |=3D IDE_CD_FLAG_TOC_VALID;
=20
 	return 0;
 }
=20
-
-static int cdrom_read_subchannel(ide_drive_t *drive, int format, char =
*buf,
-				 int buflen, struct request_sense *sense)
-{
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
-
-	req.sense =3D sense;
-	req.data =3D buf;
-	req.data_len =3D buflen;
-	req.cmd[0] =3D GPCMD_READ_SUBCHANNEL;
-	req.cmd[1] =3D 2;     /* MSF addressing */
-	req.cmd[2] =3D 0x40;  /* request subQ data */
-	req.cmd[3] =3D format;
-	req.cmd[7] =3D (buflen >> 8);
-	req.cmd[8] =3D (buflen & 0xff);
-	return cdrom_queue_packet_command(drive, &req);
-}
-
-/* ATAPI cdrom drives are free to select the speed you request or any =
slower
-   rate :-( Requesting too fast a speed will _not_ produce an error. *=
/
-static int cdrom_select_speed(ide_drive_t *drive, int speed,
-			      struct request_sense *sense)
-{
-	struct request req;
-	cdrom_prepare_request(drive, &req);
-
-	req.sense =3D sense;
-	if (speed =3D=3D 0)
-		speed =3D 0xffff; /* set to max */
-	else
-		speed *=3D 177;   /* Nx to kbytes/s */
-
-	req.cmd[0] =3D GPCMD_SET_SPEED;
-	/* Read Drive speed in kbytes/second MSB */
-	req.cmd[2] =3D (speed >> 8) & 0xff;=09
-	/* Read Drive speed in kbytes/second LSB */
-	req.cmd[3] =3D speed & 0xff;
-	if (CDROM_CONFIG_FLAGS(drive)->cd_r ||
-	    CDROM_CONFIG_FLAGS(drive)->cd_rw ||
-	    CDROM_CONFIG_FLAGS(drive)->dvd_r) {
-		/* Write Drive speed in kbytes/second MSB */
-		req.cmd[4] =3D (speed >> 8) & 0xff;
-		/* Write Drive speed in kbytes/second LSB */
-		req.cmd[5] =3D speed & 0xff;
-       }
-
-	return cdrom_queue_packet_command(drive, &req);
-}
-
-static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba=
_end)
-{
-	struct request_sense sense;
-	struct request req;
-
-	cdrom_prepare_request(drive, &req);
-
-	req.sense =3D &sense;
-	req.cmd[0] =3D GPCMD_PLAY_AUDIO_MSF;
-	lba_to_msf(lba_start, &req.cmd[3], &req.cmd[4], &req.cmd[5]);
-	lba_to_msf(lba_end-1, &req.cmd[6], &req.cmd[7], &req.cmd[8]);
-
-	return cdrom_queue_packet_command(drive, &req);
-}
-
-static int cdrom_get_toc_entry(ide_drive_t *drive, int track,
-				struct atapi_toc_entry **ent)
-{
-	struct cdrom_info *info =3D drive->driver_data;
-	struct atapi_toc *toc =3D info->toc;
-	int ntracks;
-
-	/*
-	 * don't serve cached data, if the toc isn't valid
-	 */
-	if (!CDROM_STATE_FLAGS(drive)->toc_valid)
-		return -EINVAL;
-
-	/* Check validity of requested track number. */
-	ntracks =3D toc->hdr.last_track - toc->hdr.first_track + 1;
-	if (toc->hdr.first_track =3D=3D CDROM_LEADOUT) ntracks =3D 0;
-	if (track =3D=3D CDROM_LEADOUT)
-		*ent =3D &toc->ent[ntracks];
-	else if (track < toc->hdr.first_track ||
-		 track > toc->hdr.last_track)
-		return -EINVAL;
-	else
-		*ent =3D &toc->ent[track - toc->hdr.first_track];
-
-	return 0;
-}
-
-/* the generic packet interface to cdrom.c */
-static int ide_cdrom_packet(struct cdrom_device_info *cdi,
-			    struct packet_command *cgc)
-{
-	struct request req;
-	ide_drive_t *drive =3D cdi->handle;
-
-	if (cgc->timeout <=3D 0)
-		cgc->timeout =3D ATAPI_WAIT_PC;
-
-	/* here we queue the commands from the uniform CD-ROM
-	   layer. the packet must be complete, as we do not
-	   touch it at all. */
-	cdrom_prepare_request(drive, &req);
-	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
-	if (cgc->sense)
-		memset(cgc->sense, 0, sizeof(struct request_sense));
-	req.data =3D cgc->buffer;
-	req.data_len =3D cgc->buflen;
-	req.timeout =3D cgc->timeout;
-
-	if (cgc->quiet)
-		req.cmd_flags |=3D REQ_QUIET;
-
-	req.sense =3D cgc->sense;
-	cgc->stat =3D cdrom_queue_packet_command(drive, &req);
-	if (!cgc->stat)
-		cgc->buflen -=3D req.data_len;
-	return cgc->stat;
-}
-
-static
-int ide_cdrom_audio_ioctl (struct cdrom_device_info *cdi,
-			   unsigned int cmd, void *arg)
-			  =20
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct cdrom_info *info =3D drive->driver_data;
-	int stat;
-
-	switch (cmd) {
-	/*
-	 * emulate PLAY_AUDIO_TI command with PLAY_AUDIO_10, since
-	 * atapi doesn't support it
-	 */
-	case CDROMPLAYTRKIND: {
-		unsigned long lba_start, lba_end;
-		struct cdrom_ti *ti =3D arg;
-		struct atapi_toc_entry *first_toc, *last_toc;
-
-		stat =3D cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
-		if (stat)
-			return stat;
-
-		stat =3D cdrom_get_toc_entry(drive, ti->cdti_trk1, &last_toc);
-		if (stat)
-			return stat;
-
-		if (ti->cdti_trk1 !=3D CDROM_LEADOUT)
-			++last_toc;
-		lba_start =3D first_toc->addr.lba;
-		lba_end   =3D last_toc->addr.lba;
-
-		if (lba_end <=3D lba_start)
-			return -EINVAL;
-
-		return cdrom_play_audio(drive, lba_start, lba_end);
-	}
-
-	case CDROMREADTOCHDR: {
-		struct cdrom_tochdr *tochdr =3D arg;
-		struct atapi_toc *toc;
-
-		/* Make sure our saved TOC is valid. */
-		stat =3D cdrom_read_toc(drive, NULL);
-		if (stat)
-			return stat;
-
-		toc =3D info->toc;
-		tochdr->cdth_trk0 =3D toc->hdr.first_track;
-		tochdr->cdth_trk1 =3D toc->hdr.last_track;
-
-		return 0;
-	}
-
-	case CDROMREADTOCENTRY: {
-		struct cdrom_tocentry *tocentry =3D arg;
-		struct atapi_toc_entry *toce;
-
-		stat =3D cdrom_get_toc_entry(drive, tocentry->cdte_track, &toce);
-		if (stat)
-			return stat;
-
-		tocentry->cdte_ctrl =3D toce->control;
-		tocentry->cdte_adr  =3D toce->adr;
-		if (tocentry->cdte_format =3D=3D CDROM_MSF) {
-			lba_to_msf (toce->addr.lba,
-				   &tocentry->cdte_addr.msf.minute,
-				   &tocentry->cdte_addr.msf.second,
-				   &tocentry->cdte_addr.msf.frame);
-		} else
-			tocentry->cdte_addr.lba =3D toce->addr.lba;
-
-		return 0;
-	}
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static
-int ide_cdrom_reset (struct cdrom_device_info *cdi)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct request_sense sense;
-	struct request req;
-	int ret;
-
-	cdrom_prepare_request(drive, &req);
-	req.cmd_type =3D REQ_TYPE_SPECIAL;
-	req.cmd_flags =3D REQ_QUIET;
-	ret =3D ide_do_drive_cmd(drive, &req, ide_wait);
-
-	/*
-	 * A reset will unlock the door. If it was previously locked,
-	 * lock it again.
-	 */
-	if (CDROM_STATE_FLAGS(drive)->door_locked)
-		(void) cdrom_lockdoor(drive, 1, &sense);
-
-	return ret;
-}
-
-
-static
-int ide_cdrom_tray_move (struct cdrom_device_info *cdi, int position)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct request_sense sense;
-
-	if (position) {
-		int stat =3D cdrom_lockdoor(drive, 0, &sense);
-		if (stat)
-			return stat;
-	}
-
-	return cdrom_eject(drive, !position, &sense);
-}
-
-static
-int ide_cdrom_lock_door (struct cdrom_device_info *cdi, int lock)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	return cdrom_lockdoor(drive, lock, NULL);
-}
-
-static
-int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabi=
lities_page *cap)
+int ide_cdrom_get_capabilities(ide_drive_t *drive, u8 *buf)
 {
 	struct cdrom_info *info =3D drive->driver_data;
 	struct cdrom_device_info *cdi =3D &info->devinfo;
 	struct packet_command cgc;
-	int stat, attempts =3D 3, size =3D sizeof(*cap);
+	int stat, attempts =3D 3, size =3D ATAPI_CAPABILITIES_PAGE_SIZE;
=20
-	/*
-	 * ACER50 (and others?) require the full spec length mode sense
-	 * page capabilities size, but older drives break.
-	 */
-	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
-	    !strcmp(drive->id->model, "WPI CDS-32X")))
-		size -=3D sizeof(cap->pad);
+	if ((info->cd_flags & IDE_CD_FLAG_FULL_CAPS_PAGE) =3D=3D 0)
+		size -=3D ATAPI_CAPABILITIES_PAGE_PAD_SIZE;
=20
-	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
+	init_cdrom_command(&cgc, buf, size, CGC_DATA_UNKNOWN);
 	do { /* we seem to get stat=3D0x01,err=3D0x00 the first time (??) */
 		stat =3D cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
 		if (!stat)
@@ -2702,177 +1636,33 @@ int ide_cdrom_get_capabilities(ide_drive_t *dr=
ive, struct atapi_capabilities_pag
 	return stat;
 }
=20
-static
-void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabili=
ties_page *cap)
-{
-	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
-	if (!drive->id->model[0] &&
-	    !strncmp(drive->id->fw_rev, "241N", 4)) {
-		CDROM_STATE_FLAGS(drive)->current_speed  =3D
-			(le16_to_cpu(cap->curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed =3D
-			(le16_to_cpu(cap->maxspeed) + (176/2)) / 176;
-	} else {
-		CDROM_STATE_FLAGS(drive)->current_speed  =3D
-			(be16_to_cpu(cap->curspeed) + (176/2)) / 176;
-		CDROM_CONFIG_FLAGS(drive)->max_speed =3D
-			(be16_to_cpu(cap->maxspeed) + (176/2)) / 176;
-	}
-}
-
-static
-int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct request_sense sense;
-	struct atapi_capabilities_page cap;
-	int stat;
-
-	if ((stat =3D cdrom_select_speed(drive, speed, &sense)) < 0)
-		return stat;
-
-	if (!ide_cdrom_get_capabilities(drive, &cap)) {
-		ide_cdrom_update_speed(drive, &cap);
-		cdi->speed =3D CDROM_STATE_FLAGS(drive)->current_speed;
-	}
-        return 0;
-}
-
-/*
- * add logic to try GET_EVENT command first to check for media and tra=
y
- * status. this should be supported by newer cd-r/w and all DVD etc
- * drives
- */
-static
-int ide_cdrom_drive_status (struct cdrom_device_info *cdi, int slot_nr=
)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	struct media_event_desc med;
-	struct request_sense sense;
-	int stat;
-
-	if (slot_nr !=3D CDSL_CURRENT)
-		return -EINVAL;
-
-	stat =3D cdrom_check_status(drive, &sense);
-	if (!stat || sense.sense_key =3D=3D UNIT_ATTENTION)
-		return CDS_DISC_OK;
-
-	if (!cdrom_get_media_event(cdi, &med)) {
-		if (med.media_present)
-			return CDS_DISC_OK;
-		else if (med.door_open)
-			return CDS_TRAY_OPEN;
-		else
-			return CDS_NO_DISC;
-	}
-
-	if (sense.sense_key =3D=3D NOT_READY && sense.asc =3D=3D 0x04 && sens=
e.ascq =3D=3D 0x04)
-		return CDS_DISC_OK;
-
-	/*
-	 * If not using Mt Fuji extended media tray reports,
-	 * just return TRAY_OPEN since ATAPI doesn't provide
-	 * any other way to detect this...
-	 */
-	if (sense.sense_key =3D=3D NOT_READY) {
-		if (sense.asc =3D=3D 0x3a && sense.ascq =3D=3D 1)
-			return CDS_NO_DISC;
-		else
-			return CDS_TRAY_OPEN;
-	}
-	return CDS_DRIVE_NOT_READY;
-}
-
-static
-int ide_cdrom_get_last_session (struct cdrom_device_info *cdi,
-				struct cdrom_multisession *ms_info)
+void ide_cdrom_update_speed(ide_drive_t *drive, u8 *buf)
 {
-	struct atapi_toc *toc;
-	ide_drive_t *drive =3D cdi->handle;
-	struct cdrom_info *info =3D drive->driver_data;
-	struct request_sense sense;
-	int ret;
-
-	if (!CDROM_STATE_FLAGS(drive)->toc_valid || info->toc =3D=3D NULL)
-		if ((ret =3D cdrom_read_toc(drive, &sense)))
-			return ret;
-
-	toc =3D info->toc;
-	ms_info->addr.lba =3D toc->last_session_lba;
-	ms_info->xa_flag =3D toc->xa_flag;
-
-	return 0;
-}
-
-static
-int ide_cdrom_get_mcn (struct cdrom_device_info *cdi,
-		       struct cdrom_mcn *mcn_info)
-{
-	int stat;
-	char mcnbuf[24];
-	ide_drive_t *drive =3D cdi->handle;
-
-/* get MCN */
-	if ((stat =3D cdrom_read_subchannel(drive, 2, mcnbuf, sizeof (mcnbuf)=
, NULL)))
-		return stat;
-
-	memcpy (mcn_info->medium_catalog_number, mcnbuf+9,
-		sizeof (mcn_info->medium_catalog_number)-1);
-	mcn_info->medium_catalog_number[sizeof (mcn_info->medium_catalog_numb=
er)-1]
-		=3D '\0';
-
-	return 0;
-}
-
-
+	struct cdrom_info *cd =3D drive->driver_data;
+	u16 curspeed, maxspeed;
=20
-/*********************************************************************=
*******
- * Other driver requests (open, close, check media change).
- */
+	curspeed =3D *(u16 *)&buf[8 + 14];
+	maxspeed =3D *(u16 *)&buf[8 +  8];
=20
-static
-int ide_cdrom_check_media_change_real (struct cdrom_device_info *cdi,
-				       int slot_nr)
-{
-	ide_drive_t *drive =3D cdi->handle;
-	int retval;
-=09
-	if (slot_nr =3D=3D CDSL_CURRENT) {
-		(void) cdrom_check_status(drive, NULL);
-		retval =3D CDROM_STATE_FLAGS(drive)->media_changed;
-		CDROM_STATE_FLAGS(drive)->media_changed =3D 0;
-		return retval;
+	if (cd->cd_flags & IDE_CD_FLAG_LE_SPEED_FIELDS) {
+		curspeed =3D le16_to_cpu(curspeed);
+		maxspeed =3D le16_to_cpu(maxspeed);
 	} else {
-		return -EINVAL;
+		curspeed =3D be16_to_cpu(curspeed);
+		maxspeed =3D be16_to_cpu(maxspeed);
 	}
-}
-
=20
-static
-int ide_cdrom_open_real (struct cdrom_device_info *cdi, int purpose)
-{
-	return 0;
+	cd->current_speed =3D (curspeed + (176/2)) / 176;
+	cd->max_speed =3D (maxspeed + (176/2)) / 176;
 }
=20
-/*
- * Close down the device.  Invalidate all cached blocks.
- */
-
-static
-void ide_cdrom_release_real (struct cdrom_device_info *cdi)
-{
-	ide_drive_t *drive =3D cdi->handle;
-
-	if (!cdi->use_count)
-		CDROM_STATE_FLAGS(drive)->toc_valid =3D 0;
-}
+#define IDE_CD_CAPABILITIES \
+	(CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK | CDC_SELECT_SPEED | \
+	 CDC_SELECT_DISC | CDC_MULTI_SESSION | CDC_MCN | CDC_MEDIA_CHANGED | =
\
+	 CDC_PLAY_AUDIO | CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R | \
+	 CDC_CD_RW | CDC_DVD | CDC_DVD_R | CDC_DVD_RAM | CDC_GENERIC_PACKET |=
 \
+	 CDC_MO_DRIVE | CDC_MRW | CDC_MRW_W | CDC_RAM)
=20
-
-
-/*********************************************************************=
*******
- * Device initialization.
- */
 static struct cdrom_device_ops ide_cdrom_dops =3D {
 	.open			=3D ide_cdrom_open_real,
 	.release		=3D ide_cdrom_release_real,
@@ -2885,14 +1675,7 @@ static struct cdrom_device_ops ide_cdrom_dops =3D=
 {
 	.get_mcn		=3D ide_cdrom_get_mcn,
 	.reset			=3D ide_cdrom_reset,
 	.audio_ioctl		=3D ide_cdrom_audio_ioctl,
-	.capability		=3D CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
-				CDC_SELECT_SPEED | CDC_SELECT_DISC |
-				CDC_MULTI_SESSION | CDC_MCN |
-				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
-				CDC_DRIVE_STATUS | CDC_CD_R |
-				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET | CDC_MO_DRIVE | CDC_MRW |
-				CDC_MRW_W | CDC_RAM,
+	.capability		=3D IDE_CD_CAPABILITIES,
 	.generic_packet		=3D ide_cdrom_packet,
 };
=20
@@ -2902,35 +1685,12 @@ static int ide_cdrom_register (ide_drive_t *dri=
ve, int nslots)
 	struct cdrom_device_info *devinfo =3D &info->devinfo;
=20
 	devinfo->ops =3D &ide_cdrom_dops;
-	devinfo->mask =3D 0;
-	devinfo->speed =3D CDROM_STATE_FLAGS(drive)->current_speed;
+	devinfo->speed =3D info->current_speed;
 	devinfo->capacity =3D nslots;
 	devinfo->handle =3D drive;
 	strcpy(devinfo->name, drive->name);
-=09
-	/* set capability mask to match the probe. */
-	if (!CDROM_CONFIG_FLAGS(drive)->cd_r)
-		devinfo->mask |=3D CDC_CD_R;
-	if (!CDROM_CONFIG_FLAGS(drive)->cd_rw)
-		devinfo->mask |=3D CDC_CD_RW;
-	if (!CDROM_CONFIG_FLAGS(drive)->dvd)
-		devinfo->mask |=3D CDC_DVD;
-	if (!CDROM_CONFIG_FLAGS(drive)->dvd_r)
-		devinfo->mask |=3D CDC_DVD_R;
-	if (!CDROM_CONFIG_FLAGS(drive)->dvd_ram)
-		devinfo->mask |=3D CDC_DVD_RAM;
-	if (!CDROM_CONFIG_FLAGS(drive)->is_changer)
-		devinfo->mask |=3D CDC_SELECT_DISC;
-	if (!CDROM_CONFIG_FLAGS(drive)->audio_play)
-		devinfo->mask |=3D CDC_PLAY_AUDIO;
-	if (!CDROM_CONFIG_FLAGS(drive)->close_tray)
-		devinfo->mask |=3D CDC_CLOSE_TRAY;
-	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
-		devinfo->mask |=3D CDC_MO_DRIVE;
-	if (!CDROM_CONFIG_FLAGS(drive)->ram)
-		devinfo->mask |=3D CDC_RAM;
-
-	if (CDROM_CONFIG_FLAGS(drive)->no_speed_select)
+
+	if (info->cd_flags & IDE_CD_FLAG_NO_SPEED_SELECT)
 		devinfo->mask |=3D CDC_SELECT_SPEED;
=20
 	devinfo->disk =3D info->disk;
@@ -2940,22 +1700,25 @@ static int ide_cdrom_register (ide_drive_t *dri=
ve, int nslots)
 static
 int ide_cdrom_probe_capabilities (ide_drive_t *drive)
 {
-	struct cdrom_info *info =3D drive->driver_data;
-	struct cdrom_device_info *cdi =3D &info->devinfo;
-	struct atapi_capabilities_page cap;
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct cdrom_device_info *cdi =3D &cd->devinfo;
+	u8 buf[ATAPI_CAPABILITIES_PAGE_SIZE];
+	mechtype_t mechtype;
 	int nslots =3D 1;
=20
+	cdi->mask =3D (CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R |
+		     CDC_DVD_RAM | CDC_SELECT_DISC | CDC_PLAY_AUDIO |
+		     CDC_MO_DRIVE | CDC_RAM);
+
 	if (drive->media =3D=3D ide_optical) {
-		CDROM_CONFIG_FLAGS(drive)->mo_drive =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->ram =3D 1;
+		cdi->mask &=3D ~(CDC_MO_DRIVE | CDC_RAM);
 		printk(KERN_ERR "%s: ATAPI magneto-optical drive\n", drive->name);
 		return nslots;
 	}
=20
-	if (CDROM_CONFIG_FLAGS(drive)->nec260 ||
-	    !strcmp(drive->id->model,"STINGRAY 8422 IDE 8X CD-ROM 7-27-95")) =
{
-		CDROM_CONFIG_FLAGS(drive)->no_eject =3D 0;
-		CDROM_CONFIG_FLAGS(drive)->audio_play =3D 1;
+	if (cd->cd_flags & IDE_CD_FLAG_PRE_ATAPI12) {
+		cd->cd_flags &=3D ~IDE_CD_FLAG_NO_EJECT;
+		cdi->mask &=3D ~CDC_PLAY_AUDIO;
 		return nslots;
 	}
=20
@@ -2969,83 +1732,66 @@ int ide_cdrom_probe_capabilities (ide_drive_t *=
drive)
 	cdi->handle =3D drive;
 	cdi->ops =3D &ide_cdrom_dops;
=20
-	if (ide_cdrom_get_capabilities(drive, &cap))
+	if (ide_cdrom_get_capabilities(drive, buf))
 		return 0;
=20
-	if (cap.lock =3D=3D 0)
-		CDROM_CONFIG_FLAGS(drive)->no_doorlock =3D 1;
-	if (cap.eject)
-		CDROM_CONFIG_FLAGS(drive)->no_eject =3D 0;
-	if (cap.cd_r_write)
-		CDROM_CONFIG_FLAGS(drive)->cd_r =3D 1;
-	if (cap.cd_rw_write) {
-		CDROM_CONFIG_FLAGS(drive)->cd_rw =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->ram =3D 1;
-	}
-	if (cap.test_write)
-		CDROM_CONFIG_FLAGS(drive)->test_write =3D 1;
-	if (cap.dvd_ram_read || cap.dvd_r_read || cap.dvd_rom)
-		CDROM_CONFIG_FLAGS(drive)->dvd =3D 1;
-	if (cap.dvd_ram_write) {
-		CDROM_CONFIG_FLAGS(drive)->dvd_ram =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->ram =3D 1;
-	}
-	if (cap.dvd_r_write)
-		CDROM_CONFIG_FLAGS(drive)->dvd_r =3D 1;
-	if (cap.audio_play)
-		CDROM_CONFIG_FLAGS(drive)->audio_play =3D 1;
-	if (cap.mechtype =3D=3D mechtype_caddy || cap.mechtype =3D=3D mechtyp=
e_popup)
-		CDROM_CONFIG_FLAGS(drive)->close_tray =3D 0;
-
-	/* Some drives used by Apple don't advertise audio play
-	 * but they do support reading TOC & audio datas
-	 */
-	if (strcmp(drive->id->model, "MATSHITADVD-ROM SR-8187") =3D=3D 0 ||
-	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8186") =3D=3D 0 ||
-	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8176") =3D=3D 0 ||
-	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") =3D=3D 0)
-		CDROM_CONFIG_FLAGS(drive)->audio_play =3D 1;
+	if ((buf[8 + 6] & 0x01) =3D=3D 0)
+		cd->cd_flags |=3D IDE_CD_FLAG_NO_DOORLOCK;
+	if (buf[8 + 6] & 0x08)
+		cd->cd_flags &=3D ~IDE_CD_FLAG_NO_EJECT;
+	if (buf[8 + 3] & 0x01)
+		cdi->mask &=3D ~CDC_CD_R;
+	if (buf[8 + 3] & 0x02)
+		cdi->mask &=3D ~(CDC_CD_RW | CDC_RAM);
+	if (buf[8 + 2] & 0x38)
+		cdi->mask &=3D ~CDC_DVD;
+	if (buf[8 + 3] & 0x20)
+		cdi->mask &=3D ~(CDC_DVD_RAM | CDC_RAM);
+	if (buf[8 + 3] & 0x10)
+		cdi->mask &=3D ~CDC_DVD_R;
+	if ((buf[8 + 4] & 0x01) || (cd->cd_flags & IDE_CD_FLAG_PLAY_AUDIO_OK)=
)
+		cdi->mask &=3D ~CDC_PLAY_AUDIO;
+
+	mechtype =3D buf[8 + 6] >> 5;
+	if (mechtype =3D=3D mechtype_caddy || mechtype =3D=3D mechtype_popup)
+		cdi->mask |=3D CDC_CLOSE_TRAY;
=20
-#if ! STANDARD_ATAPI
 	if (cdi->sanyo_slot > 0) {
-		CDROM_CONFIG_FLAGS(drive)->is_changer =3D 1;
+		cdi->mask &=3D ~CDC_SELECT_DISC;
 		nslots =3D 3;
+	} else if (mechtype =3D=3D mechtype_individual_changer ||
+		   mechtype =3D=3D mechtype_cartridge_changer) {
+		nslots =3D cdrom_number_of_slots(cdi);
+		if (nslots > 1)
+			cdi->mask &=3D ~CDC_SELECT_DISC;
 	}
=20
-	else
-#endif /* not STANDARD_ATAPI */
-	if (cap.mechtype =3D=3D mechtype_individual_changer ||
-	    cap.mechtype =3D=3D mechtype_cartridge_changer) {
-		if ((nslots =3D cdrom_number_of_slots(cdi)) > 1) {
-			CDROM_CONFIG_FLAGS(drive)->is_changer =3D 1;
-			CDROM_CONFIG_FLAGS(drive)->supp_disc_present =3D 1;
-		}
-	}
+	ide_cdrom_update_speed(drive, buf);
=20
-	ide_cdrom_update_speed(drive, &cap);
-	/* don't print speed if the drive reported 0.
-	 */
 	printk(KERN_INFO "%s: ATAPI", drive->name);
-	if (CDROM_CONFIG_FLAGS(drive)->max_speed)
-		printk(" %dX", CDROM_CONFIG_FLAGS(drive)->max_speed);
-	printk(" %s", CDROM_CONFIG_FLAGS(drive)->dvd ? "DVD-ROM" : "CD-ROM");
=20
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_r|CDROM_CONFIG_FLAGS(drive)->dvd_r=
am)
-        	printk(" DVD%s%s",=20
-        	(CDROM_CONFIG_FLAGS(drive)->dvd_r)? "-R" : "",=20
-        	(CDROM_CONFIG_FLAGS(drive)->dvd_ram)? "-RAM" : "");
+	/* don't print speed if the drive reported 0 */
+	if (cd->max_speed)
+		printk(KERN_CONT " %dX", cd->max_speed);
=20
-        if (CDROM_CONFIG_FLAGS(drive)->cd_r|CDROM_CONFIG_FLAGS(drive)-=
>cd_rw)=20
-        	printk(" CD%s%s",=20
-        	(CDROM_CONFIG_FLAGS(drive)->cd_r)? "-R" : "",=20
-        	(CDROM_CONFIG_FLAGS(drive)->cd_rw)? "/RW" : "");
+	printk(KERN_CONT " %s", (cdi->mask & CDC_DVD) ? "CD-ROM" : "DVD-ROM")=
;
=20
-        if (CDROM_CONFIG_FLAGS(drive)->is_changer)=20
-        	printk(" changer w/%d slots", nslots);
-        else =09
-        	printk(" drive");
+	if ((cdi->mask & CDC_DVD_R) =3D=3D 0 || (cdi->mask & CDC_DVD_RAM) =3D=
=3D 0)
+		printk(KERN_CONT " DVD%s%s",
+				 (cdi->mask & CDC_DVD_R) ? "" : "-R",
+				 (cdi->mask & CDC_DVD_RAM) ? "" : "-RAM");
=20
-	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpu(cap.buffer_size));
+	if ((cdi->mask & CDC_CD_R) =3D=3D 0 || (cdi->mask & CDC_CD_RW) =3D=3D=
 0)
+		printk(KERN_CONT " CD%s%s",
+				 (cdi->mask & CDC_CD_R) ? "" : "-R",
+				 (cdi->mask & CDC_CD_RW) ? "" : "/RW");
+
+	if ((cdi->mask & CDC_SELECT_DISC) =3D=3D 0)
+		printk(KERN_CONT " changer w/%d slots", nslots);
+	else
+		printk(KERN_CONT " drive");
+
+	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpu(*(u16 *)&buf[8 + 12]))=
;
=20
 	return nslots;
 }
@@ -3138,11 +1884,74 @@ static int ide_cdrom_prep_fn(struct request_que=
ue *q, struct request *rq)
 	return 0;
 }
=20
+struct cd_list_entry {
+	const char	*id_model;
+	const char	*id_firmware;
+	unsigned int	cd_flags;
+};
+
+static const struct cd_list_entry ide_cd_quirks_list[] =3D {
+	/* Limit transfer size per interrupt. */
+	{ "SAMSUNG CD-ROM SCR-2430", NULL,   IDE_CD_FLAG_LIMIT_NFRAMES	    },
+	{ "SAMSUNG CD-ROM SCR-2432", NULL,   IDE_CD_FLAG_LIMIT_NFRAMES	    },
+	/* SCR-3231 doesn't support the SET_CD_SPEED command. */
+	{ "SAMSUNG CD-ROM SCR-3231", NULL,   IDE_CD_FLAG_NO_SPEED_SELECT    }=
,
+	/* Old NEC260 (not R) was released before ATAPI 1.2 spec. */
+	{ "NEC CD-ROM DRIVE:260",    "1.01", IDE_CD_FLAG_TOCADDR_AS_BCD |
+					     IDE_CD_FLAG_PRE_ATAPI12,	    },
+	/* Vertos 300, some versions of this drive like to talk BCD. */
+	{ "V003S0DS",		     NULL,   IDE_CD_FLAG_VERTOS_300_SSD,    },
+	/* Vertos 600 ESD. */
+	{ "V006E0DS",		     NULL,   IDE_CD_FLAG_VERTOS_600_ESD,    },
+	/*
+	 * Sanyo 3 CD changer uses a non-standard command for CD changing
+	 * (by default standard ATAPI support for CD changers is used).
+	 */
+	{ "CD-ROM CDR-C3 G",	     NULL,   IDE_CD_FLAG_SANYO_3CD	    },
+	{ "CD-ROM CDR-C3G",	     NULL,   IDE_CD_FLAG_SANYO_3CD	    },
+	{ "CD-ROM CDR_C36",	     NULL,   IDE_CD_FLAG_SANYO_3CD	    },
+	/* Stingray 8X CD-ROM. */
+	{ "STINGRAY 8422 IDE 8X CD-ROM 7-27-95", NULL, IDE_CD_FLAG_PRE_ATAPI1=
2},
+	/*
+	 * ACER 50X CD-ROM and WPI 32X CD-ROM require the full spec length
+	 * mode sense page capabilities size, but older drives break.
+	 */
+	{ "ATAPI CD ROM DRIVE 50X MAX",	NULL,	IDE_CD_FLAG_FULL_CAPS_PAGE  },
+	{ "WPI CDS-32X",		NULL,	IDE_CD_FLAG_FULL_CAPS_PAGE  },
+	/* ACER/AOpen 24X CD-ROM has the speed fields byte-swapped. */
+	{ "",			     "241N", IDE_CD_FLAG_LE_SPEED_FIELDS    },
+	/*
+	 * Some drives used by Apple don't advertise audio play
+	 * but they do support reading TOC & audio datas.
+	 */
+	{ "MATSHITADVD-ROM SR-8187", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
+	{ "MATSHITADVD-ROM SR-8186", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
+	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
+	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
+	{ NULL, NULL, 0 }
+};
+
+static unsigned int ide_cd_flags(struct hd_driveid *id)
+{
+	const struct cd_list_entry *cle =3D ide_cd_quirks_list;
+
+	while (cle->id_model) {
+		if (strcmp(cle->id_model, id->model) =3D=3D 0 &&
+		    (cle->id_firmware =3D=3D NULL ||
+		     strstr(id->fw_rev, cle->id_firmware)))
+			return cle->cd_flags;
+		cle++;
+	}
+
+	return 0;
+}
+
 static
 int ide_cdrom_setup (ide_drive_t *drive)
 {
-	struct cdrom_info *info =3D drive->driver_data;
-	struct cdrom_device_info *cdi =3D &info->devinfo;
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct cdrom_device_info *cdi =3D &cd->devinfo;
+	struct hd_driveid *id =3D drive->id;
 	int nslots;
=20
 	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
@@ -3153,101 +1962,21 @@ int ide_cdrom_setup (ide_drive_t *drive)
=20
 	drive->special.all	=3D 0;
=20
-	CDROM_STATE_FLAGS(drive)->media_changed =3D 1;
-	CDROM_STATE_FLAGS(drive)->toc_valid     =3D 0;
-	CDROM_STATE_FLAGS(drive)->door_locked   =3D 0;
+	cd->cd_flags =3D IDE_CD_FLAG_MEDIA_CHANGED | IDE_CD_FLAG_NO_EJECT |
+		       ide_cd_flags(id);
=20
-#if NO_DOOR_LOCKING
-	CDROM_CONFIG_FLAGS(drive)->no_doorlock =3D 1;
-#else
-	CDROM_CONFIG_FLAGS(drive)->no_doorlock =3D 0;
-#endif
+	if ((id->config & 0x0060) =3D=3D 0x20)
+		cd->cd_flags |=3D IDE_CD_FLAG_DRQ_INTERRUPT;
=20
-	CDROM_CONFIG_FLAGS(drive)->drq_interrupt =3D ((drive->id->config & 0x=
0060) =3D=3D 0x20);
-	CDROM_CONFIG_FLAGS(drive)->is_changer =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->cd_r =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->cd_rw =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->test_write =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd_r =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->dvd_ram =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->no_eject =3D 1;
-	CDROM_CONFIG_FLAGS(drive)->supp_disc_present =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->audio_play =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->close_tray =3D 1;
-=09
-	/* limit transfer size per interrupt. */
-	CDROM_CONFIG_FLAGS(drive)->limit_nframes =3D 0;
-	/* a testament to the nice quality of Samsung drives... */
-	if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2430"))
-		CDROM_CONFIG_FLAGS(drive)->limit_nframes =3D 1;
-	else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-2432"))
-		CDROM_CONFIG_FLAGS(drive)->limit_nframes =3D 1;
-	/* the 3231 model does not support the SET_CD_SPEED command */
-	else if (!strcmp(drive->id->model, "SAMSUNG CD-ROM SCR-3231"))
-		CDROM_CONFIG_FLAGS(drive)->no_speed_select =3D 1;
-
-#if ! STANDARD_ATAPI
-	/* by default Sanyo 3 CD changer support is turned off and
-           ATAPI Rev 2.2+ standard support for CD changers is used */
-	cdi->sanyo_slot =3D 0;
-
-	CDROM_CONFIG_FLAGS(drive)->nec260 =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd =3D 0;
-	CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd =3D 0;
-
-	if (strcmp (drive->id->model, "V003S0DS") =3D=3D 0 &&
-	    drive->id->fw_rev[4] =3D=3D '1' &&
-	    drive->id->fw_rev[6] <=3D '2') {
-		/* Vertos 300.
-		   Some versions of this drive like to talk BCD. */
-		CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd =3D 1;
-	}
-
-	else if (strcmp (drive->id->model, "V006E0DS") =3D=3D 0 &&
-	    drive->id->fw_rev[4] =3D=3D '1' &&
-	    drive->id->fw_rev[6] <=3D '2') {
-		/* Vertos 600 ESD. */
-		CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd =3D 1;
-	}
-	else if (strcmp(drive->id->model, "NEC CD-ROM DRIVE:260") =3D=3D 0 &&
-		 strncmp(drive->id->fw_rev, "1.01", 4) =3D=3D 0) { /* FIXME */
-		/* Old NEC260 (not R).
-		   This drive was released before the 1.2 version
-		   of the spec. */
-		CDROM_CONFIG_FLAGS(drive)->tocaddr_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->nec260         =3D 1;
-	}
-	else if (strcmp(drive->id->model, "WEARNES CDD-120") =3D=3D 0 &&
-		 strncmp(drive->id->fw_rev, "A1.1", 4) =3D=3D 0) { /* FIXME */
-		/* Wearnes */
-		CDROM_CONFIG_FLAGS(drive)->playmsf_as_bcd =3D 1;
-		CDROM_CONFIG_FLAGS(drive)->subchan_as_bcd =3D 1;
-	}
-        /* Sanyo 3 CD changer uses a non-standard command
-           for CD changing */
-        else if ((strcmp(drive->id->model, "CD-ROM CDR-C3 G") =3D=3D 0=
) ||
-                 (strcmp(drive->id->model, "CD-ROM CDR-C3G") =3D=3D 0)=
 ||
-                 (strcmp(drive->id->model, "CD-ROM CDR_C36") =3D=3D 0)=
) {
-                 /* uses CD in slot 0 when value is set to 3 */
-                 cdi->sanyo_slot =3D 3;
-        }
-#endif /* not STANDARD_ATAPI */
-
-	info->toc		=3D NULL;
-	info->buffer		=3D NULL;
-	info->sector_buffered	=3D 0;
-	info->nsectors_buffered	=3D 0;
-	info->changer_info      =3D NULL;
-	info->last_block	=3D 0;
-	info->start_seek	=3D 0;
+	if ((cd->cd_flags & IDE_CD_FLAG_VERTOS_300_SSD) &&
+	    id->fw_rev[4] =3D=3D '1' && id->fw_rev[6] <=3D '2')
+		cd->cd_flags |=3D (IDE_CD_FLAG_TOCTRACKS_AS_BCD |
+				 IDE_CD_FLAG_TOCADDR_AS_BCD);
+	else if ((cd->cd_flags & IDE_CD_FLAG_VERTOS_600_ESD) &&
+		 id->fw_rev[4] =3D=3D '1' && id->fw_rev[6] <=3D '2')
+		cd->cd_flags |=3D IDE_CD_FLAG_TOCTRACKS_AS_BCD;
+	else if (cd->cd_flags & IDE_CD_FLAG_SANYO_3CD)
+		cdi->sanyo_slot =3D 3;	/* 3 =3D> use CD in slot 0 */
=20
 	nslots =3D ide_cdrom_probe_capabilities (drive);
=20
@@ -3262,7 +1991,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
=20
 	if (ide_cdrom_register(drive, nslots)) {
 		printk (KERN_ERR "%s: ide_cdrom_setup failed to register device with=
 the cdrom driver.\n", drive->name);
-		info->devinfo.handle =3D NULL;
+		cd->devinfo.handle =3D NULL;
 		return 1;
 	}
 	ide_cdrom_add_settings(drive);
@@ -3302,7 +2031,6 @@ static void ide_cd_release(struct kref *kref)
=20
 	kfree(info->buffer);
 	kfree(info->toc);
-	kfree(info->changer_info);
 	if (devinfo->handle =3D=3D drive && unregister_cdrom(devinfo))
 		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
 				"driver.\n", __FUNCTION__, drive->name);
@@ -3458,7 +2186,9 @@ static int idecd_revalidate_disk(struct gendisk *=
disk)
 {
 	struct cdrom_info *info =3D ide_cd_g(disk);
 	struct request_sense sense;
-	cdrom_read_toc(info->drive, &sense);
+
+	ide_cd_read_toc(info->drive, &sense);
+
 	return  0;
 }
=20
@@ -3533,7 +2263,7 @@ static int ide_cd_probe(ide_drive_t *drive)
 		goto failed;
 	}
=20
-	cdrom_read_toc(drive, &sense);
+	ide_cd_read_toc(drive, &sense);
 	g->fops =3D &idecd_ops;
 	g->flags |=3D GENHD_FL_REMOVABLE;
 	add_disk(g);
@@ -3556,6 +2286,7 @@ static int __init ide_cdrom_init(void)
 }
=20
 MODULE_ALIAS("ide:*m-cdrom*");
+MODULE_ALIAS("ide-cd");
 module_init(ide_cdrom_init);
 module_exit(ide_cdrom_exit);
 MODULE_LICENSE("GPL");
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 1b302fe..22e3751 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/ide_cd.h
- *
  *  Copyright (C) 1996-98  Erik Andersen
  *  Copyright (C) 1998-2000 Jens Axboe
  */
@@ -10,31 +8,6 @@
 #include <linux/cdrom.h>
 #include <asm/byteorder.h>
=20
-/* Turn this on to have the driver print out the meanings of the
-   ATAPI error codes.  This will use up additional kernel-space
-   memory, though. */
-
-#ifndef VERBOSE_IDE_CD_ERRORS
-#define VERBOSE_IDE_CD_ERRORS 1
-#endif
-
-
-/* Turning this on will remove code to work around various nonstandard
-   ATAPI implementations.  If you know your drive follows the standard=
,
-   this will give you a slightly smaller kernel. */
-
-#ifndef STANDARD_ATAPI
-#define STANDARD_ATAPI 0
-#endif
-
-
-/* Turning this on will disable the door-locking functionality.
-   This is apparently needed for supermount. */
-
-#ifndef NO_DOOR_LOCKING
-#define NO_DOOR_LOCKING 0
-#endif
-
 /*
  * typical timeout for packet command
  */
@@ -49,68 +22,47 @@
 #endif
 #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
-#define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)
-#define SECTORS_MAX		(131072 >> SECTOR_BITS)
-
-#define BLOCKS_PER_FRAME	(CD_FRAMESIZE / BLOCK_SIZE)
-
-/* special command codes for strategy routine. */
-#define PACKET_COMMAND        4315
-#define REQUEST_SENSE_COMMAND 4316
-#define RESET_DRIVE_COMMAND   4317
-
-
-/* Configuration flags.  These describe the capabilities of the drive.
-   They generally do not change after initialization, unless we learn
-   more about the drive from stuff failing. */
-struct ide_cd_config_flags {
-	__u8 drq_interrupt	: 1; /* Device sends an interrupt when ready
-					for a packet command. */
-	__u8 no_doorlock	: 1; /* Drive cannot lock the door. */
-	__u8 no_eject		: 1; /* Drive cannot eject the disc. */
-	__u8 nec260		: 1; /* Drive is a pre-1.2 NEC 260 drive. */
-	__u8 playmsf_as_bcd	: 1; /* PLAYMSF command takes BCD args. */
-	__u8 tocaddr_as_bcd	: 1; /* TOC addresses are in BCD. */
-	__u8 toctracks_as_bcd	: 1; /* TOC track numbers are in BCD. */
-	__u8 subchan_as_bcd	: 1; /* Subchannel info is in BCD. */
-	__u8 is_changer		: 1; /* Drive is a changer. */
-	__u8 cd_r		: 1; /* Drive can write to CD-R media . */
-	__u8 cd_rw		: 1; /* Drive can write to CD-R/W media . */
-	__u8 dvd		: 1; /* Drive is a DVD-ROM */
-	__u8 dvd_r		: 1; /* Drive can write DVD-R */
-	__u8 dvd_ram		: 1; /* Drive can write DVD-RAM */
-	__u8 ram		: 1; /* generic WRITE (dvd-ram/mrw) */
-	__u8 test_write		: 1; /* Drive can fake writes */
-	__u8 supp_disc_present	: 1; /* Changer can report exact contents
-					of slots. */
-	__u8 limit_nframes	: 1; /* Drive does not provide data in
-					multiples of SECTOR_SIZE when more
-					than one interrupt is needed. */
-	__u8 seeking		: 1; /* Seeking in progress */
-	__u8 audio_play		: 1; /* can do audio related commands */
-	__u8 close_tray		: 1; /* can close the tray */
-	__u8 writing		: 1; /* pseudo write in progress */
-	__u8 mo_drive		: 1; /* drive is an MO device */
-	__u8 no_speed_select	: 1; /* SET_CD_SPEED command is unsupported. */
-	__u8 reserved		: 1;
-	byte max_speed;		     /* Max speed of the drive */
-};
-#define CDROM_CONFIG_FLAGS(drive) (&(((struct cdrom_info *)(drive->dri=
ver_data))->config_flags))
=20
-=20
-/* State flags.  These give information about the current state of the
-   drive, and will change during normal operation. */
-struct ide_cd_state_flags {
-	__u8 media_changed : 1; /* Driver has noticed a media change. */
-	__u8 toc_valid     : 1; /* Saved TOC information is current. */
-	__u8 door_locked   : 1; /* We think that the drive door is locked. */
-	__u8 writing       : 1; /* the drive is currently writing */
-	__u8 reserved      : 4;
-	byte current_speed;	/* Current speed of the drive */
+/* Capabilities Page size including 8 bytes of Mode Page Header */
+#define ATAPI_CAPABILITIES_PAGE_SIZE		(8 + 20)
+#define ATAPI_CAPABILITIES_PAGE_PAD_SIZE	4
+
+enum {
+	/* Device sends an interrupt when ready for a packet command. */
+	IDE_CD_FLAG_DRQ_INTERRUPT	=3D (1 << 0),
+	/* Drive cannot lock the door. */
+	IDE_CD_FLAG_NO_DOORLOCK		=3D (1 << 1),
+	/* Drive cannot eject the disc. */
+	IDE_CD_FLAG_NO_EJECT		=3D (1 << 2),
+	/* Drive is a pre ATAPI 1.2 drive. */
+	IDE_CD_FLAG_PRE_ATAPI12		=3D (1 << 3),
+	/* TOC addresses are in BCD. */
+	IDE_CD_FLAG_TOCADDR_AS_BCD	=3D (1 << 4),
+	/* TOC track numbers are in BCD. */
+	IDE_CD_FLAG_TOCTRACKS_AS_BCD	=3D (1 << 5),
+	/*
+	 * Drive does not provide data in multiples of SECTOR_SIZE
+	 * when more than one interrupt is needed.
+	 */
+	IDE_CD_FLAG_LIMIT_NFRAMES	=3D (1 << 6),
+	/* Seeking in progress. */
+	IDE_CD_FLAG_SEEKING		=3D (1 << 7),
+	/* Driver has noticed a media change. */
+	IDE_CD_FLAG_MEDIA_CHANGED	=3D (1 << 8),
+	/* Saved TOC information is current. */
+	IDE_CD_FLAG_TOC_VALID		=3D (1 << 9),
+	/* We think that the drive door is locked. */
+	IDE_CD_FLAG_DOOR_LOCKED		=3D (1 << 10),
+	/* SET_CD_SPEED command is unsupported. */
+	IDE_CD_FLAG_NO_SPEED_SELECT	=3D (1 << 11),
+	IDE_CD_FLAG_VERTOS_300_SSD	=3D (1 << 12),
+	IDE_CD_FLAG_VERTOS_600_ESD	=3D (1 << 13),
+	IDE_CD_FLAG_SANYO_3CD		=3D (1 << 14),
+	IDE_CD_FLAG_FULL_CAPS_PAGE	=3D (1 << 15),
+	IDE_CD_FLAG_PLAY_AUDIO_OK	=3D (1 << 16),
+	IDE_CD_FLAG_LE_SPEED_FIELDS	=3D (1 << 17),
 };
=20
-#define CDROM_STATE_FLAGS(drive) (&(((struct cdrom_info *)(drive->driv=
er_data))->state_flags))
-
 /* Structure of a MSF cdrom address. */
 struct atapi_msf {
 	byte reserved;
@@ -155,310 +107,6 @@ struct atapi_toc {
 	  /* One extra for the leadout. */
 };
=20
-
-/* This structure is annoyingly close to, but not identical with,
-   the cdrom_subchnl structure from cdrom.h. */
-struct atapi_cdrom_subchnl {
- 	u_char  acdsc_reserved;
- 	u_char  acdsc_audiostatus;
- 	u_short acdsc_length;
-	u_char  acdsc_format;
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	u_char  acdsc_ctrl:     4;
-	u_char  acdsc_adr:      4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u_char  acdsc_adr:	4;
-	u_char  acdsc_ctrl:	4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-	u_char  acdsc_trk;
-	u_char  acdsc_ind;
-	union {
-		struct atapi_msf msf;
-		int	lba;
-	} acdsc_absaddr;
-	union {
-		struct atapi_msf msf;
-		int	lba;
-	} acdsc_reladdr;
-};
-
-
-
-/* This should probably go into cdrom.h along with the other
- * generic stuff now in the Mt. Fuji spec.
- */
-struct atapi_capabilities_page {
-	struct mode_page_header header;
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 parameters_saveable : 1;
-	__u8 reserved1           : 1;
-	__u8 page_code           : 6;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 page_code           : 6;
-	__u8 reserved1           : 1;
-	__u8 parameters_saveable : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-	byte     page_length;
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved2           : 2;
-	/* Drive supports reading of DVD-RAM discs */
-	__u8 dvd_ram_read        : 1;
-	/* Drive supports reading of DVD-R discs */
-	__u8 dvd_r_read          : 1;
-	/* Drive supports reading of DVD-ROM discs */
-	__u8 dvd_rom             : 1;
-	/* Drive supports reading CD-R discs with addressing method 2 */
-	__u8 method2             : 1; /* reserved in 1.2 */
-	/* Drive can read from CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_read		 : 1; /* reserved in 1.2 */
-	/* Drive supports read from CD-R discs (orange book, part II) */
-	__u8 cd_r_read           : 1; /* reserved in 1.2 */
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive supports read from CD-R discs (orange book, part II) */
-	__u8 cd_r_read           : 1; /* reserved in 1.2 */
-	/* Drive can read from CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_read          : 1; /* reserved in 1.2 */
-	/* Drive supports reading CD-R discs with addressing method 2 */
-	__u8 method2             : 1;
-	/* Drive supports reading of DVD-ROM discs */
-	__u8 dvd_rom             : 1;
-	/* Drive supports reading of DVD-R discs */
-	__u8 dvd_r_read          : 1;
-	/* Drive supports reading of DVD-RAM discs */
-	__u8 dvd_ram_read        : 1;
-	__u8 reserved2		 : 2;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved3           : 2;
-	/* Drive can write DVD-RAM discs */
-	__u8 dvd_ram_write       : 1;
-	/* Drive can write DVD-R discs */
-	__u8 dvd_r_write         : 1;
-	__u8 reserved3a          : 1;
-	/* Drive can fake writes */
-	__u8 test_write          : 1;
-	/* Drive can write to CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_write	 : 1; /* reserved in 1.2 */
-	/* Drive supports write to CD-R discs (orange book, part II) */
-	__u8 cd_r_write          : 1; /* reserved in 1.2 */
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive can write to CD-R discs (orange book, part II) */
-	__u8 cd_r_write          : 1; /* reserved in 1.2 */
-	/* Drive can write to CD-R/W (CD-E) discs (orange book, part III) */
-	__u8 cd_rw_write	 : 1; /* reserved in 1.2 */
-	/* Drive can fake writes */
-	__u8 test_write          : 1;
-	__u8 reserved3a          : 1;
-	/* Drive can write DVD-R discs */
-	__u8 dvd_r_write         : 1;
-	/* Drive can write DVD-RAM discs */
-	__u8 dvd_ram_write       : 1;
-	__u8 reserved3           : 2;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved4           : 1;
-	/* Drive can read multisession discs. */
-	__u8 multisession        : 1;
-	/* Drive can read mode 2, form 2 data. */
-	__u8 mode2_form2         : 1;
-	/* Drive can read mode 2, form 1 (XA) data. */
-	__u8 mode2_form1         : 1;
-	/* Drive supports digital output on port 2. */
-	__u8 digport2            : 1;
-	/* Drive supports digital output on port 1. */
-	__u8 digport1            : 1;
-	/* Drive can deliver a composite audio/video data stream. */
-	__u8 composite           : 1;
-	/* Drive supports audio play operations. */
-	__u8 audio_play          : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive supports audio play operations. */
-	__u8 audio_play          : 1;
-	/* Drive can deliver a composite audio/video data stream. */
-	__u8 composite           : 1;
-	/* Drive supports digital output on port 1. */
-	__u8 digport1            : 1;
-	/* Drive supports digital output on port 2. */
-	__u8 digport2            : 1;
-	/* Drive can read mode 2, form 1 (XA) data. */
-	__u8 mode2_form1         : 1;
-	/* Drive can read mode 2, form 2 data. */
-	__u8 mode2_form2         : 1;
-	/* Drive can read multisession discs. */
-	__u8 multisession        : 1;
-	__u8 reserved4           : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved5           : 1;
-	/* Drive can return Media Catalog Number (UPC) info. */
-	__u8 upc                 : 1;
-	/* Drive can return International Standard Recording Code info. */
-	__u8 isrc                : 1;
-	/* Drive supports C2 error pointers. */
-	__u8 c2_pointers         : 1;
-	/* R-W data will be returned deinterleaved and error corrected. */
-	__u8 rw_corr             : 1;
-	/* Subchannel reads can return combined R-W information. */
-	__u8 rw_supported        : 1;
-	/* Drive can continue a read cdda operation from a loss of streaming.=
*/
-	__u8 cdda_accurate       : 1;
-	/* Drive can read Red Book audio data. */
-	__u8 cdda                : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	/* Drive can read Red Book audio data. */
-	__u8 cdda                : 1;
-	/* Drive can continue a read cdda operation from a loss of streaming.=
*/
-	__u8 cdda_accurate       : 1;
-	/* Subchannel reads can return combined R-W information. */
-	__u8 rw_supported        : 1;
-	/* R-W data will be returned deinterleaved and error corrected. */
-	__u8 rw_corr             : 1;
-	/* Drive supports C2 error pointers. */
-	__u8 c2_pointers         : 1;
-	/* Drive can return International Standard Recording Code info. */
-	__u8 isrc                : 1;
-	/* Drive can return Media Catalog Number (UPC) info. */
-	__u8 upc                 : 1;
-	__u8 reserved5           : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	/* Drive mechanism types. */
-	mechtype_t mechtype	 : 3;
-	__u8 reserved6           : 1;
-	/* Drive can eject a disc or changer cartridge. */
-	__u8 eject               : 1;
-	/* State of prevent/allow jumper. */
-	__u8 prevent_jumper      : 1;
-	/* Present state of door lock. */
-	__u8 lock_state          : 1;
-	/* Drive can lock the door. */
-	__u8 lock                : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-
-	/* Drive can lock the door. */
-	__u8 lock                : 1;
-	/* Present state of door lock. */
-	__u8 lock_state          : 1;
-	/* State of prevent/allow jumper. */
-	__u8 prevent_jumper      : 1;
-	/* Drive can eject a disc or changer cartridge. */
-	__u8 eject               : 1;
-	__u8 reserved6           : 1;
-	/* Drive mechanism types. */
-	mechtype_t mechtype	 : 3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 reserved7           : 4;
-	/* Drive supports software slot selection. */
-	__u8 sss                 : 1;  /* reserved in 1.2 */
-	/* Changer can report exact contents of slots. */
-	__u8 disc_present        : 1;  /* reserved in 1.2 */
-	/* Audio for each channel can be muted independently. */
-	__u8 separate_mute       : 1;
-	/* Audio level for each channel can be controlled independently. */
-	__u8 separate_volume     : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-
-	/* Audio level for each channel can be controlled independently. */
-	__u8 separate_volume     : 1;
-	/* Audio for each channel can be muted independently. */
-	__u8 separate_mute       : 1;
-	/* Changer can report exact contents of slots. */
-	__u8 disc_present        : 1;  /* reserved in 1.2 */
-	/* Drive supports software slot selection. */
-	__u8 sss                 : 1;  /* reserved in 1.2 */
-	__u8 reserved7           : 4;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-	/* Note: the following four fields are returned in big-endian form. *=
/
-	/* Maximum speed (in kB/s). */
-	unsigned short maxspeed;
-	/* Number of discrete volume levels. */
-	unsigned short n_vol_levels;
-	/* Size of cache in drive, in kB. */
-	unsigned short buffer_size;
-	/* Current speed (in kB/s). */
-	unsigned short curspeed;
-	char pad[4];
-};
-
-
-struct atapi_mechstat_header {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 fault         : 1;
-	__u8 changer_state : 2;
-	__u8 curslot       : 5;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 curslot       : 5;
-	__u8 changer_state : 2;
-	__u8 fault         : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 mech_state    : 3;
-	__u8 door_open     : 1;
-	__u8 reserved1     : 4;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 reserved1     : 4;
-	__u8 door_open     : 1;
-	__u8 mech_state    : 3;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-	byte     curlba[3];
-	byte     nslots;
-	__u16	 slot_tablelen;
-};
-
-
-struct atapi_slot {
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__u8 disc_present : 1;
-	__u8 reserved1    : 6;
-	__u8 change       : 1;
-#elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8 change       : 1;
-	__u8 reserved1    : 6;
-	__u8 disc_present : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
-
-	byte reserved2[3];
-};
-
-struct atapi_changer_info {
-	struct atapi_mechstat_header hdr;
-	struct atapi_slot slots[0];
-};
-
 /* Extra per-device info for cdrom drives. */
 struct cdrom_info {
 	ide_drive_t	*drive;
@@ -483,11 +131,11 @@ struct cdrom_info {
 	int dma;
 	unsigned long last_block;
 	unsigned long start_seek;
-	/* Buffer to hold mechanism status and changer slot table. */
-	struct atapi_changer_info *changer_info;
=20
-	struct ide_cd_config_flags	config_flags;
-	struct ide_cd_state_flags	state_flags;
+	unsigned int cd_flags;
+
+	u8 max_speed;		/* Max speed of the drive. */
+	u8 current_speed;	/* Current speed of the drive. */
=20
         /* Per-device info needed by cdrom.c generic driver. */
         struct cdrom_device_info devinfo;
@@ -495,250 +143,30 @@ struct cdrom_info {
 	unsigned long write_timeout;
 };
=20
-/*********************************************************************=
*******
- * Descriptions of ATAPI error codes.
- */
-
-/* This stuff should be in cdrom.h, since it is now generic... */
-
-/* ATAPI sense keys (from table 140 of ATAPI 2.6) */
-#define NO_SENSE                0x00
-#define RECOVERED_ERROR         0x01
-#define NOT_READY               0x02
-#define MEDIUM_ERROR            0x03
-#define HARDWARE_ERROR          0x04
-#define ILLEGAL_REQUEST         0x05
-#define UNIT_ATTENTION          0x06
-#define DATA_PROTECT            0x07
-#define BLANK_CHECK             0x08
-#define ABORTED_COMMAND         0x0b
-#define MISCOMPARE              0x0e
-
-=20
-
-/* This stuff should be in cdrom.h, since it is now generic... */
-#if VERBOSE_IDE_CD_ERRORS
-
- /* The generic packet command opcodes for CD/DVD Logical Units,
- * From Table 57 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */=20
-static const struct {
-	unsigned short packet_command;
-	const char * const text;
-} packet_command_texts[] =3D {
-	{ GPCMD_TEST_UNIT_READY, "Test Unit Ready" },
-	{ GPCMD_REQUEST_SENSE, "Request Sense" },
-	{ GPCMD_FORMAT_UNIT, "Format Unit" },
-	{ GPCMD_INQUIRY, "Inquiry" },
-	{ GPCMD_START_STOP_UNIT, "Start/Stop Unit" },
-	{ GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, "Prevent/Allow Medium Removal" =
},
-	{ GPCMD_READ_FORMAT_CAPACITIES, "Read Format Capacities" },
-	{ GPCMD_READ_CDVD_CAPACITY, "Read Cd/Dvd Capacity" },
-	{ GPCMD_READ_10, "Read 10" },
-	{ GPCMD_WRITE_10, "Write 10" },
-	{ GPCMD_SEEK, "Seek" },
-	{ GPCMD_WRITE_AND_VERIFY_10, "Write and Verify 10" },
-	{ GPCMD_VERIFY_10, "Verify 10" },
-	{ GPCMD_FLUSH_CACHE, "Flush Cache" },
-	{ GPCMD_READ_SUBCHANNEL, "Read Subchannel" },
-	{ GPCMD_READ_TOC_PMA_ATIP, "Read Table of Contents" },
-	{ GPCMD_READ_HEADER, "Read Header" },
-	{ GPCMD_PLAY_AUDIO_10, "Play Audio 10" },
-	{ GPCMD_GET_CONFIGURATION, "Get Configuration" },
-	{ GPCMD_PLAY_AUDIO_MSF, "Play Audio MSF" },
-	{ GPCMD_PLAYAUDIO_TI, "Play Audio TrackIndex" },
-	{ GPCMD_GET_EVENT_STATUS_NOTIFICATION, "Get Event Status Notification=
" },
-	{ GPCMD_PAUSE_RESUME, "Pause/Resume" },
-	{ GPCMD_STOP_PLAY_SCAN, "Stop Play/Scan" },
-	{ GPCMD_READ_DISC_INFO, "Read Disc Info" },
-	{ GPCMD_READ_TRACK_RZONE_INFO, "Read Track Rzone Info" },
-	{ GPCMD_RESERVE_RZONE_TRACK, "Reserve Rzone Track" },
-	{ GPCMD_SEND_OPC, "Send OPC" },
-	{ GPCMD_MODE_SELECT_10, "Mode Select 10" },
-	{ GPCMD_REPAIR_RZONE_TRACK, "Repair Rzone Track" },
-	{ GPCMD_MODE_SENSE_10, "Mode Sense 10" },
-	{ GPCMD_CLOSE_TRACK, "Close Track" },
-	{ GPCMD_BLANK, "Blank" },
-	{ GPCMD_SEND_EVENT, "Send Event" },
-	{ GPCMD_SEND_KEY, "Send Key" },
-	{ GPCMD_REPORT_KEY, "Report Key" },
-	{ GPCMD_LOAD_UNLOAD, "Load/Unload" },
-	{ GPCMD_SET_READ_AHEAD, "Set Read-ahead" },
-	{ GPCMD_READ_12, "Read 12" },
-	{ GPCMD_GET_PERFORMANCE, "Get Performance" },
-	{ GPCMD_SEND_DVD_STRUCTURE, "Send DVD Structure" },
-	{ GPCMD_READ_DVD_STRUCTURE, "Read DVD Structure" },
-	{ GPCMD_SET_STREAMING, "Set Streaming" },
-	{ GPCMD_READ_CD_MSF, "Read CD MSF" },
-	{ GPCMD_SCAN, "Scan" },
-	{ GPCMD_SET_SPEED, "Set Speed" },
-	{ GPCMD_PLAY_CD, "Play CD" },
-	{ GPCMD_MECHANISM_STATUS, "Mechanism Status" },
-	{ GPCMD_READ_CD, "Read CD" },
-};
-
-
-
-/* From Table 303 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
-static const char * const sense_key_texts[16] =3D {
-	"No sense data",
-	"Recovered error",
-	"Not ready",
-	"Medium error",
-	"Hardware error",
-	"Illegal request",
-	"Unit attention",
-	"Data protect",
-	"Blank check",
-	"(reserved)",
-	"(reserved)",
-	"Aborted command",
-	"(reserved)",
-	"(reserved)",
-	"Miscompare",
-	"(reserved)",
-};
-
-/* From Table 304 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
-static const struct {
-	unsigned long asc_ascq;
-	const char * const text;
-} sense_data_texts[] =3D {
-	{ 0x000000, "No additional sense information" },
-	{ 0x000011, "Play operation in progress" },
-	{ 0x000012, "Play operation paused" },
-	{ 0x000013, "Play operation successfully completed" },
-	{ 0x000014, "Play operation stopped due to error" },
-	{ 0x000015, "No current audio status to return" },
-	{ 0x010c0a, "Write error - padding blocks added" },
-	{ 0x011700, "Recovered data with no error correction applied" },
-	{ 0x011701, "Recovered data with retries" },
-	{ 0x011702, "Recovered data with positive head offset" },
-	{ 0x011703, "Recovered data with negative head offset" },
-	{ 0x011704, "Recovered data with retries and/or CIRC applied" },
-	{ 0x011705, "Recovered data using previous sector ID" },
-	{ 0x011800, "Recovered data with error correction applied" },
-	{ 0x011801, "Recovered data with error correction and retries applied=
"},
-	{ 0x011802, "Recovered data - the data was auto-reallocated" },
-	{ 0x011803, "Recovered data with CIRC" },
-	{ 0x011804, "Recovered data with L-EC" },
-	{ 0x015d00,=20
-	    "Failure prediction threshold exceeded - Predicted logical unit f=
ailure" },
-	{ 0x015d01,=20
-	    "Failure prediction threshold exceeded - Predicted media failure"=
 },
-	{ 0x015dff, "Failure prediction threshold exceeded - False" },
-	{ 0x017301, "Power calibration area almost full" },
-	{ 0x020400, "Logical unit not ready - cause not reportable" },
-	/* Following is misspelled in ATAPI 2.6, _and_ in Mt. Fuji */
-	{ 0x020401,
-	  "Logical unit not ready - in progress [sic] of becoming ready" },
-	{ 0x020402, "Logical unit not ready - initializing command required" =
},
-	{ 0x020403, "Logical unit not ready - manual intervention required" }=
,
-	{ 0x020404, "Logical unit not ready - format in progress" },
-	{ 0x020407, "Logical unit not ready - operation in progress" },
-	{ 0x020408, "Logical unit not ready - long write in progress" },
-	{ 0x020600, "No reference position found (media may be upside down)" =
},
-	{ 0x023000, "Incompatible medium installed" },
-	{ 0x023a00, "Medium not present" },
-	{ 0x025300, "Media load or eject failed" },
-	{ 0x025700, "Unable to recover table of contents" },
-	{ 0x030300, "Peripheral device write fault" },
-	{ 0x030301, "No write current" },
-	{ 0x030302, "Excessive write errors" },
-	{ 0x030c00, "Write error" },
-	{ 0x030c01, "Write error - Recovered with auto reallocation" },
-	{ 0x030c02, "Write error - auto reallocation failed" },
-	{ 0x030c03, "Write error - recommend reassignment" },
-	{ 0x030c04, "Compression check miscompare error" },
-	{ 0x030c05, "Data expansion occurred during compress" },
-	{ 0x030c06, "Block not compressible" },
-	{ 0x030c07, "Write error - recovery needed" },
-	{ 0x030c08, "Write error - recovery failed" },
-	{ 0x030c09, "Write error - loss of streaming" },
-	{ 0x031100, "Unrecovered read error" },
-	{ 0x031106, "CIRC unrecovered error" },
-	{ 0x033101, "Format command failed" },
-	{ 0x033200, "No defect spare location available" },
-	{ 0x033201, "Defect list update failure" },
-	{ 0x035100, "Erase failure" },
-	{ 0x037200, "Session fixation error" },
-	{ 0x037201, "Session fixation error writin lead-in" },
-	{ 0x037202, "Session fixation error writin lead-out" },
-	{ 0x037300, "CD control error" },
-	{ 0x037302, "Power calibration area is full" },
-	{ 0x037303, "Power calibration area error" },
-	{ 0x037304, "Program memory area / RMA update failure" },
-	{ 0x037305, "Program memory area / RMA is full" },
-	{ 0x037306, "Program memory area / RMA is (almost) full" },
-
-	{ 0x040200, "No seek complete" },
-	{ 0x040300, "Write fault" },
-	{ 0x040900, "Track following error" },
-	{ 0x040901, "Tracking servo failure" },
-	{ 0x040902, "Focus servo failure" },
-	{ 0x040903, "Spindle servo failure" },
-	{ 0x041500, "Random positioning error" },
-	{ 0x041501, "Mechanical positioning or changer error" },
-	{ 0x041502, "Positioning error detected by read of medium" },
-	{ 0x043c00, "Mechanical positioning or changer error" },
-	{ 0x044000, "Diagnostic failure on component (ASCQ)" },
-	{ 0x044400, "Internal CD/DVD logical unit failure" },
-	{ 0x04b600, "Media load mechanism failed" },
-	{ 0x051a00, "Parameter list length error" },
-	{ 0x052000, "Invalid command operation code" },
-	{ 0x052100, "Logical block address out of range" },
-	{ 0x052102, "Invalid address for write" },
-	{ 0x052400, "Invalid field in command packet" },
-	{ 0x052600, "Invalid field in parameter list" },
-	{ 0x052601, "Parameter not supported" },
-	{ 0x052602, "Parameter value invalid" },
-	{ 0x052700, "Write protected media" },
-	{ 0x052c00, "Command sequence error" },
-	{ 0x052c03, "Current program area is not empty" },
-	{ 0x052c04, "Current program area is empty" },
-	{ 0x053001, "Cannot read medium - unknown format" },
-	{ 0x053002, "Cannot read medium - incompatible format" },
-	{ 0x053900, "Saving parameters not supported" },
-	{ 0x054e00, "Overlapped commands attempted" },
-	{ 0x055302, "Medium removal prevented" },
-	{ 0x055500, "System resource failure" },
-	{ 0x056300, "End of user area encountered on this track" },
-	{ 0x056400, "Illegal mode for this track or incompatible medium" },
-	{ 0x056f00, "Copy protection key exchange failure - Authentication fa=
ilure" },
-	{ 0x056f01, "Copy protection key exchange failure - Key not present" =
},
-	{ 0x056f02, "Copy protection key exchange failure - Key not establish=
ed" },
-	{ 0x056f03, "Read of scrambled sector without authentication" },
-	{ 0x056f04, "Media region code is mismatched to logical unit" },
-	{ 0x056f05,  "Drive region must be permanent / region reset count err=
or" },
-	{ 0x057203, "Session fixation error - incomplete track in session" },
-	{ 0x057204, "Empty or partially written reserved track" },
-	{ 0x057205, "No more RZONE reservations are allowed" },
-	{ 0x05bf00, "Loss of streaming" },
-	{ 0x062800, "Not ready to ready transition, medium may have changed" =
},
-	{ 0x062900, "Power on, reset or hardware reset occurred" },
-	{ 0x062a00, "Parameters changed" },
-	{ 0x062a01, "Mode parameters changed" },
-	{ 0x062e00, "Insufficient time for operation" },
-	{ 0x063f00, "Logical unit operating conditions have changed" },
-	{ 0x063f01, "Microcode has been changed" },
-	{ 0x065a00, "Operator request or state change input (unspecified)" },
-	{ 0x065a01, "Operator medium removal request" },
-	{ 0x0bb900, "Play operation aborted" },
-
-	/* Here we use 0xff for the key (not a valid key) to signify
-	 * that these can have _any_ key value associated with them... */
-	{ 0xff0401, "Logical unit is in process of becoming ready" },
-	{ 0xff0400, "Logical unit not ready, cause not reportable" },
-	{ 0xff0402, "Logical unit not ready, initializing command required" }=
,
-	{ 0xff0403, "Logical unit not ready, manual intervention required" },
-	{ 0xff0500, "Logical unit does not respond to selection" },
-	{ 0xff0800, "Logical unit communication failure" },
-	{ 0xff0802, "Logical unit communication parity error" },
-	{ 0xff0801, "Logical unit communication time-out" },
-	{ 0xff2500, "Logical unit not supported" },
-	{ 0xff4c00, "Logical unit failed self-configuration" },
-	{ 0xff3e00, "Logical unit has not self-configured yet" },
-};
-#endif
-
+/* ide-cd_verbose.c */
+void ide_cd_log_error(const char *, struct request *, struct request_s=
ense *);
+
+/* ide-cd.c functions used by ide-cd_ioctl.c */
+void ide_cd_init_rq(ide_drive_t *, struct request *);
+int ide_cd_queue_pc(ide_drive_t *, struct request *);
+int ide_cd_read_toc(ide_drive_t *, struct request_sense *);
+int ide_cdrom_get_capabilities(ide_drive_t *, u8 *);
+void ide_cdrom_update_speed(ide_drive_t *, u8 *);
+int cdrom_check_status(ide_drive_t *, struct request_sense *);
+
+/* ide-cd_ioctl.c */
+int ide_cdrom_open_real(struct cdrom_device_info *, int);
+void ide_cdrom_release_real(struct cdrom_device_info *);
+int ide_cdrom_drive_status(struct cdrom_device_info *, int);
+int ide_cdrom_check_media_change_real(struct cdrom_device_info *, int)=
;
+int ide_cdrom_tray_move(struct cdrom_device_info *, int);
+int ide_cdrom_lock_door(struct cdrom_device_info *, int);
+int ide_cdrom_select_speed(struct cdrom_device_info *, int);
+int ide_cdrom_get_last_session(struct cdrom_device_info *,
+			       struct cdrom_multisession *);
+int ide_cdrom_get_mcn(struct cdrom_device_info *, struct cdrom_mcn *);
+int ide_cdrom_reset(struct cdrom_device_info *cdi);
+int ide_cdrom_audio_ioctl(struct cdrom_device_info *, unsigned int, vo=
id *);
+int ide_cdrom_packet(struct cdrom_device_info *, struct packet_command=
 *);
=20
 #endif /* _IDE_CD_H */
diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
new file mode 100644
index 0000000..b68284d
--- /dev/null
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -0,0 +1,475 @@
+/*
+ * cdrom.c IOCTLs handling for ide-cd driver.
+ *
+ * Copyright (C) 1994-1996  Scott Snyder <snyder@fnald0.fnal.gov>
+ * Copyright (C) 1996-1998  Erik Andersen <andersee@debian.org>
+ * Copyright (C) 1998-2000  Jens Axboe <axboe@suse.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/cdrom.h>
+#include <linux/ide.h>
+#include <scsi/scsi.h>
+
+#include "ide-cd.h"
+
+/*********************************************************************=
*******
+ * Other driver requests (open, close, check media change).
+ */
+int ide_cdrom_open_real(struct cdrom_device_info *cdi, int purpose)
+{
+	return 0;
+}
+
+/*
+ * Close down the device.  Invalidate all cached blocks.
+ */
+void ide_cdrom_release_real(struct cdrom_device_info *cdi)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+
+	if (!cdi->use_count)
+		cd->cd_flags &=3D ~IDE_CD_FLAG_TOC_VALID;
+}
+
+/*
+ * add logic to try GET_EVENT command first to check for media and tra=
y
+ * status. this should be supported by newer cd-r/w and all DVD etc
+ * drives
+ */
+int ide_cdrom_drive_status(struct cdrom_device_info *cdi, int slot_nr)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct media_event_desc med;
+	struct request_sense sense;
+	int stat;
+
+	if (slot_nr !=3D CDSL_CURRENT)
+		return -EINVAL;
+
+	stat =3D cdrom_check_status(drive, &sense);
+	if (!stat || sense.sense_key =3D=3D UNIT_ATTENTION)
+		return CDS_DISC_OK;
+
+	if (!cdrom_get_media_event(cdi, &med)) {
+		if (med.media_present)
+			return CDS_DISC_OK;
+		else if (med.door_open)
+			return CDS_TRAY_OPEN;
+		else
+			return CDS_NO_DISC;
+	}
+
+	if (sense.sense_key =3D=3D NOT_READY && sense.asc =3D=3D 0x04
+			&& sense.ascq =3D=3D 0x04)
+		return CDS_DISC_OK;
+
+	/*
+	 * If not using Mt Fuji extended media tray reports,
+	 * just return TRAY_OPEN since ATAPI doesn't provide
+	 * any other way to detect this...
+	 */
+	if (sense.sense_key =3D=3D NOT_READY) {
+		if (sense.asc =3D=3D 0x3a && sense.ascq =3D=3D 1)
+			return CDS_NO_DISC;
+		else
+			return CDS_TRAY_OPEN;
+	}
+	return CDS_DRIVE_NOT_READY;
+}
+
+int ide_cdrom_check_media_change_real(struct cdrom_device_info *cdi,
+				       int slot_nr)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+	int retval;
+
+	if (slot_nr =3D=3D CDSL_CURRENT) {
+		(void) cdrom_check_status(drive, NULL);
+		retval =3D (cd->cd_flags & IDE_CD_FLAG_MEDIA_CHANGED) ? 1 : 0;
+		cd->cd_flags &=3D ~IDE_CD_FLAG_MEDIA_CHANGED;
+		return retval;
+	} else {
+		return -EINVAL;
+	}
+}
+
+/* Eject the disk if EJECTFLAG is 0.
+   If EJECTFLAG is 1, try to reload the disk. */
+static
+int cdrom_eject(ide_drive_t *drive, int ejectflag,
+		struct request_sense *sense)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct cdrom_device_info *cdi =3D &cd->devinfo;
+	struct request req;
+	char loej =3D 0x02;
+
+	if ((cd->cd_flags & IDE_CD_FLAG_NO_EJECT) && !ejectflag)
+		return -EDRIVE_CANT_DO_THIS;
+
+	/* reload fails on some drives, if the tray is locked */
+	if ((cd->cd_flags & IDE_CD_FLAG_DOOR_LOCKED) && ejectflag)
+		return 0;
+
+	ide_cd_init_rq(drive, &req);
+
+	/* only tell drive to close tray if open, if it can do that */
+	if (ejectflag && (cdi->mask & CDC_CLOSE_TRAY))
+		loej =3D 0;
+
+	req.sense =3D sense;
+	req.cmd[0] =3D GPCMD_START_STOP_UNIT;
+	req.cmd[4] =3D loej | (ejectflag !=3D 0);
+
+	return ide_cd_queue_pc(drive, &req);
+}
+
+/* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
+static
+int ide_cd_lockdoor(ide_drive_t *drive, int lockflag,
+		    struct request_sense *sense)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct request_sense my_sense;
+	struct request req;
+	int stat;
+
+	if (sense =3D=3D NULL)
+		sense =3D &my_sense;
+
+	/* If the drive cannot lock the door, just pretend. */
+	if (cd->cd_flags & IDE_CD_FLAG_NO_DOORLOCK) {
+		stat =3D 0;
+	} else {
+		ide_cd_init_rq(drive, &req);
+		req.sense =3D sense;
+		req.cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
+		req.cmd[4] =3D lockflag ? 1 : 0;
+		stat =3D ide_cd_queue_pc(drive, &req);
+	}
+
+	/* If we got an illegal field error, the drive
+	   probably cannot lock the door. */
+	if (stat !=3D 0 &&
+	    sense->sense_key =3D=3D ILLEGAL_REQUEST &&
+	    (sense->asc =3D=3D 0x24 || sense->asc =3D=3D 0x20)) {
+		printk(KERN_ERR "%s: door locking not supported\n",
+			drive->name);
+		cd->cd_flags |=3D IDE_CD_FLAG_NO_DOORLOCK;
+		stat =3D 0;
+	}
+
+	/* no medium, that's alright. */
+	if (stat !=3D 0 && sense->sense_key =3D=3D NOT_READY && sense->asc =3D=
=3D 0x3a)
+		stat =3D 0;
+
+	if (stat =3D=3D 0) {
+		if (lockflag)
+			cd->cd_flags |=3D IDE_CD_FLAG_DOOR_LOCKED;
+		else
+			cd->cd_flags &=3D ~IDE_CD_FLAG_DOOR_LOCKED;
+	}
+
+	return stat;
+}
+
+int ide_cdrom_tray_move(struct cdrom_device_info *cdi, int position)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct request_sense sense;
+
+	if (position) {
+		int stat =3D ide_cd_lockdoor(drive, 0, &sense);
+
+		if (stat)
+			return stat;
+	}
+
+	return cdrom_eject(drive, !position, &sense);
+}
+
+int ide_cdrom_lock_door(struct cdrom_device_info *cdi, int lock)
+{
+	ide_drive_t *drive =3D cdi->handle;
+
+	return ide_cd_lockdoor(drive, lock, NULL);
+}
+
+/*
+ * ATAPI devices are free to select the speed you request or any slowe=
r
+ * rate. :-(  Requesting too fast a speed will _not_ produce an error.
+ */
+int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct request rq;
+	struct request_sense sense;
+	u8 buf[ATAPI_CAPABILITIES_PAGE_SIZE];
+	int stat;
+
+	ide_cd_init_rq(drive, &rq);
+
+	rq.sense =3D &sense;
+
+	if (speed =3D=3D 0)
+		speed =3D 0xffff; /* set to max */
+	else
+		speed *=3D 177;   /* Nx to kbytes/s */
+
+	rq.cmd[0] =3D GPCMD_SET_SPEED;
+	/* Read Drive speed in kbytes/second MSB/LSB */
+	rq.cmd[2] =3D (speed >> 8) & 0xff;
+	rq.cmd[3] =3D speed & 0xff;
+	if ((cdi->mask & (CDC_CD_R | CDC_CD_RW | CDC_DVD_R)) !=3D
+	    (CDC_CD_R | CDC_CD_RW | CDC_DVD_R)) {
+		/* Write Drive speed in kbytes/second MSB/LSB */
+		rq.cmd[4] =3D (speed >> 8) & 0xff;
+		rq.cmd[5] =3D speed & 0xff;
+	}
+
+	stat =3D ide_cd_queue_pc(drive, &rq);
+
+	if (!ide_cdrom_get_capabilities(drive, buf)) {
+		ide_cdrom_update_speed(drive, buf);
+		cdi->speed =3D cd->current_speed;
+	}
+
+	return 0;
+}
+
+int ide_cdrom_get_last_session(struct cdrom_device_info *cdi,
+			       struct cdrom_multisession *ms_info)
+{
+	struct atapi_toc *toc;
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *info =3D drive->driver_data;
+	struct request_sense sense;
+	int ret;
+
+	if ((info->cd_flags & IDE_CD_FLAG_TOC_VALID) =3D=3D 0 || !info->toc) =
{
+		ret =3D ide_cd_read_toc(drive, &sense);
+		if (ret)
+			return ret;
+	}
+
+	toc =3D info->toc;
+	ms_info->addr.lba =3D toc->last_session_lba;
+	ms_info->xa_flag =3D toc->xa_flag;
+
+	return 0;
+}
+
+int ide_cdrom_get_mcn(struct cdrom_device_info *cdi,
+		      struct cdrom_mcn *mcn_info)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	int stat, mcnlen;
+	struct request rq;
+	char buf[24];
+
+	ide_cd_init_rq(drive, &rq);
+
+	rq.data =3D buf;
+	rq.data_len =3D sizeof(buf);
+
+	rq.cmd[0] =3D GPCMD_READ_SUBCHANNEL;
+	rq.cmd[1] =3D 2;		/* MSF addressing */
+	rq.cmd[2] =3D 0x40;	/* request subQ data */
+	rq.cmd[3] =3D 2;		/* format */
+	rq.cmd[8] =3D sizeof(buf);
+
+	stat =3D ide_cd_queue_pc(drive, &rq);
+	if (stat)
+		return stat;
+
+	mcnlen =3D sizeof(mcn_info->medium_catalog_number) - 1;
+	memcpy(mcn_info->medium_catalog_number, buf + 9, mcnlen);
+	mcn_info->medium_catalog_number[mcnlen] =3D '\0';
+
+	return 0;
+}
+
+int ide_cdrom_reset(struct cdrom_device_info *cdi)
+{
+	ide_drive_t *drive =3D cdi->handle;
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct request_sense sense;
+	struct request req;
+	int ret;
+
+	ide_cd_init_rq(drive, &req);
+	req.cmd_type =3D REQ_TYPE_SPECIAL;
+	req.cmd_flags =3D REQ_QUIET;
+	ret =3D ide_do_drive_cmd(drive, &req, ide_wait);
+
+	/*
+	 * A reset will unlock the door. If it was previously locked,
+	 * lock it again.
+	 */
+	if (cd->cd_flags & IDE_CD_FLAG_DOOR_LOCKED)
+		(void)ide_cd_lockdoor(drive, 1, &sense);
+
+	return ret;
+}
+
+static int ide_cd_get_toc_entry(ide_drive_t *drive, int track,
+				struct atapi_toc_entry **ent)
+{
+	struct cdrom_info *info =3D drive->driver_data;
+	struct atapi_toc *toc =3D info->toc;
+	int ntracks;
+
+	/*
+	 * don't serve cached data, if the toc isn't valid
+	 */
+	if ((info->cd_flags & IDE_CD_FLAG_TOC_VALID) =3D=3D 0)
+		return -EINVAL;
+
+	/* Check validity of requested track number. */
+	ntracks =3D toc->hdr.last_track - toc->hdr.first_track + 1;
+
+	if (toc->hdr.first_track =3D=3D CDROM_LEADOUT)
+		ntracks =3D 0;
+
+	if (track =3D=3D CDROM_LEADOUT)
+		*ent =3D &toc->ent[ntracks];
+	else if (track < toc->hdr.first_track || track > toc->hdr.last_track)
+		return -EINVAL;
+	else
+		*ent =3D &toc->ent[track - toc->hdr.first_track];
+
+	return 0;
+}
+
+static int ide_cd_fake_play_trkind(ide_drive_t *drive, void *arg)
+{
+	struct cdrom_ti *ti =3D arg;
+	struct atapi_toc_entry *first_toc, *last_toc;
+	unsigned long lba_start, lba_end;
+	int stat;
+	struct request rq;
+	struct request_sense sense;
+
+	stat =3D ide_cd_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
+	if (stat)
+		return stat;
+
+	stat =3D ide_cd_get_toc_entry(drive, ti->cdti_trk1, &last_toc);
+	if (stat)
+		return stat;
+
+	if (ti->cdti_trk1 !=3D CDROM_LEADOUT)
+		++last_toc;
+	lba_start =3D first_toc->addr.lba;
+	lba_end   =3D last_toc->addr.lba;
+
+	if (lba_end <=3D lba_start)
+		return -EINVAL;
+
+	ide_cd_init_rq(drive, &rq);
+
+	rq.sense =3D &sense;
+	rq.cmd[0] =3D GPCMD_PLAY_AUDIO_MSF;
+	lba_to_msf(lba_start,   &rq.cmd[3], &rq.cmd[4], &rq.cmd[5]);
+	lba_to_msf(lba_end - 1, &rq.cmd[6], &rq.cmd[7], &rq.cmd[8]);
+
+	return ide_cd_queue_pc(drive, &rq);
+}
+
+static int ide_cd_read_tochdr(ide_drive_t *drive, void *arg)
+{
+	struct cdrom_info *cd =3D drive->driver_data;
+	struct cdrom_tochdr *tochdr =3D arg;
+	struct atapi_toc *toc;
+	int stat;
+
+	/* Make sure our saved TOC is valid. */
+	stat =3D ide_cd_read_toc(drive, NULL);
+	if (stat)
+		return stat;
+
+	toc =3D cd->toc;
+	tochdr->cdth_trk0 =3D toc->hdr.first_track;
+	tochdr->cdth_trk1 =3D toc->hdr.last_track;
+
+	return 0;
+}
+
+static int ide_cd_read_tocentry(ide_drive_t *drive, void *arg)
+{
+	struct cdrom_tocentry *tocentry =3D arg;
+	struct atapi_toc_entry *toce;
+	int stat;
+
+	stat =3D ide_cd_get_toc_entry(drive, tocentry->cdte_track, &toce);
+	if (stat)
+		return stat;
+
+	tocentry->cdte_ctrl =3D toce->control;
+	tocentry->cdte_adr  =3D toce->adr;
+	if (tocentry->cdte_format =3D=3D CDROM_MSF) {
+		lba_to_msf(toce->addr.lba,
+			   &tocentry->cdte_addr.msf.minute,
+			   &tocentry->cdte_addr.msf.second,
+			   &tocentry->cdte_addr.msf.frame);
+	} else
+		tocentry->cdte_addr.lba =3D toce->addr.lba;
+
+	return 0;
+}
+
+int ide_cdrom_audio_ioctl(struct cdrom_device_info *cdi,
+			  unsigned int cmd, void *arg)
+{
+	ide_drive_t *drive =3D cdi->handle;
+
+	switch (cmd) {
+	/*
+	 * emulate PLAY_AUDIO_TI command with PLAY_AUDIO_10, since
+	 * atapi doesn't support it
+	 */
+	case CDROMPLAYTRKIND:
+		return ide_cd_fake_play_trkind(drive, arg);
+	case CDROMREADTOCHDR:
+		return ide_cd_read_tochdr(drive, arg);
+	case CDROMREADTOCENTRY:
+		return ide_cd_read_tocentry(drive, arg);
+	default:
+		return -EINVAL;
+	}
+}
+
+/* the generic packet interface to cdrom.c */
+int ide_cdrom_packet(struct cdrom_device_info *cdi,
+			    struct packet_command *cgc)
+{
+	struct request req;
+	ide_drive_t *drive =3D cdi->handle;
+
+	if (cgc->timeout <=3D 0)
+		cgc->timeout =3D ATAPI_WAIT_PC;
+
+	/* here we queue the commands from the uniform CD-ROM
+	   layer. the packet must be complete, as we do not
+	   touch it at all. */
+	ide_cd_init_rq(drive, &req);
+	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
+	if (cgc->sense)
+		memset(cgc->sense, 0, sizeof(struct request_sense));
+	req.data =3D cgc->buffer;
+	req.data_len =3D cgc->buflen;
+	req.timeout =3D cgc->timeout;
+
+	if (cgc->quiet)
+		req.cmd_flags |=3D REQ_QUIET;
+
+	req.sense =3D cgc->sense;
+	cgc->stat =3D ide_cd_queue_pc(drive, &req);
+	if (!cgc->stat)
+		cgc->buflen -=3D req.data_len;
+	return cgc->stat;
+}
diff --git a/drivers/ide/ide-cd_verbose.c b/drivers/ide/ide-cd_verbose.=
c
new file mode 100644
index 0000000..6ed7ca0
--- /dev/null
+++ b/drivers/ide/ide-cd_verbose.c
@@ -0,0 +1,359 @@
+/*
+ * Verbose error logging for ATAPI CD/DVD devices.
+ *
+ * Copyright (C) 1994-1996  Scott Snyder <snyder@fnald0.fnal.gov>
+ * Copyright (C) 1996-1998  Erik Andersen <andersee@debian.org>
+ * Copyright (C) 1998-2000  Jens Axboe <axboe@suse.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/cdrom.h>
+#include <scsi/scsi.h>
+
+#ifndef CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS
+void ide_cd_log_error(const char *name, struct request *failed_command=
,
+		      struct request_sense *sense)
+{
+	/* Suppress printing unit attention and `in progress of becoming read=
y'
+	   errors when we're not being verbose. */
+	if (sense->sense_key =3D=3D UNIT_ATTENTION ||
+	    (sense->sense_key =3D=3D NOT_READY && (sense->asc =3D=3D 4 ||
+						sense->asc =3D=3D 0x3a)))
+		return;
+
+	printk(KERN_ERR "%s: error code: 0x%02x  sense_key: 0x%02x  "
+			"asc: 0x%02x  ascq: 0x%02x\n",
+			name, sense->error_code, sense->sense_key,
+			sense->asc, sense->ascq);
+}
+#else
+/* The generic packet command opcodes for CD/DVD Logical Units,
+ * From Table 57 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
+static const struct {
+	unsigned short packet_command;
+	const char * const text;
+} packet_command_texts[] =3D {
+	{ GPCMD_TEST_UNIT_READY, "Test Unit Ready" },
+	{ GPCMD_REQUEST_SENSE, "Request Sense" },
+	{ GPCMD_FORMAT_UNIT, "Format Unit" },
+	{ GPCMD_INQUIRY, "Inquiry" },
+	{ GPCMD_START_STOP_UNIT, "Start/Stop Unit" },
+	{ GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, "Prevent/Allow Medium Removal" =
},
+	{ GPCMD_READ_FORMAT_CAPACITIES, "Read Format Capacities" },
+	{ GPCMD_READ_CDVD_CAPACITY, "Read Cd/Dvd Capacity" },
+	{ GPCMD_READ_10, "Read 10" },
+	{ GPCMD_WRITE_10, "Write 10" },
+	{ GPCMD_SEEK, "Seek" },
+	{ GPCMD_WRITE_AND_VERIFY_10, "Write and Verify 10" },
+	{ GPCMD_VERIFY_10, "Verify 10" },
+	{ GPCMD_FLUSH_CACHE, "Flush Cache" },
+	{ GPCMD_READ_SUBCHANNEL, "Read Subchannel" },
+	{ GPCMD_READ_TOC_PMA_ATIP, "Read Table of Contents" },
+	{ GPCMD_READ_HEADER, "Read Header" },
+	{ GPCMD_PLAY_AUDIO_10, "Play Audio 10" },
+	{ GPCMD_GET_CONFIGURATION, "Get Configuration" },
+	{ GPCMD_PLAY_AUDIO_MSF, "Play Audio MSF" },
+	{ GPCMD_PLAYAUDIO_TI, "Play Audio TrackIndex" },
+	{ GPCMD_GET_EVENT_STATUS_NOTIFICATION,
+		"Get Event Status Notification" },
+	{ GPCMD_PAUSE_RESUME, "Pause/Resume" },
+	{ GPCMD_STOP_PLAY_SCAN, "Stop Play/Scan" },
+	{ GPCMD_READ_DISC_INFO, "Read Disc Info" },
+	{ GPCMD_READ_TRACK_RZONE_INFO, "Read Track Rzone Info" },
+	{ GPCMD_RESERVE_RZONE_TRACK, "Reserve Rzone Track" },
+	{ GPCMD_SEND_OPC, "Send OPC" },
+	{ GPCMD_MODE_SELECT_10, "Mode Select 10" },
+	{ GPCMD_REPAIR_RZONE_TRACK, "Repair Rzone Track" },
+	{ GPCMD_MODE_SENSE_10, "Mode Sense 10" },
+	{ GPCMD_CLOSE_TRACK, "Close Track" },
+	{ GPCMD_BLANK, "Blank" },
+	{ GPCMD_SEND_EVENT, "Send Event" },
+	{ GPCMD_SEND_KEY, "Send Key" },
+	{ GPCMD_REPORT_KEY, "Report Key" },
+	{ GPCMD_LOAD_UNLOAD, "Load/Unload" },
+	{ GPCMD_SET_READ_AHEAD, "Set Read-ahead" },
+	{ GPCMD_READ_12, "Read 12" },
+	{ GPCMD_GET_PERFORMANCE, "Get Performance" },
+	{ GPCMD_SEND_DVD_STRUCTURE, "Send DVD Structure" },
+	{ GPCMD_READ_DVD_STRUCTURE, "Read DVD Structure" },
+	{ GPCMD_SET_STREAMING, "Set Streaming" },
+	{ GPCMD_READ_CD_MSF, "Read CD MSF" },
+	{ GPCMD_SCAN, "Scan" },
+	{ GPCMD_SET_SPEED, "Set Speed" },
+	{ GPCMD_PLAY_CD, "Play CD" },
+	{ GPCMD_MECHANISM_STATUS, "Mechanism Status" },
+	{ GPCMD_READ_CD, "Read CD" },
+};
+
+/* From Table 303 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
+static const char * const sense_key_texts[16] =3D {
+	"No sense data",
+	"Recovered error",
+	"Not ready",
+	"Medium error",
+	"Hardware error",
+	"Illegal request",
+	"Unit attention",
+	"Data protect",
+	"Blank check",
+	"(reserved)",
+	"(reserved)",
+	"Aborted command",
+	"(reserved)",
+	"(reserved)",
+	"Miscompare",
+	"(reserved)",
+};
+
+/* From Table 304 of the SFF8090 Ver. 3 (Mt. Fuji) draft standard. */
+static const struct {
+	unsigned long asc_ascq;
+	const char * const text;
+} sense_data_texts[] =3D {
+	{ 0x000000, "No additional sense information" },
+	{ 0x000011, "Play operation in progress" },
+	{ 0x000012, "Play operation paused" },
+	{ 0x000013, "Play operation successfully completed" },
+	{ 0x000014, "Play operation stopped due to error" },
+	{ 0x000015, "No current audio status to return" },
+	{ 0x010c0a, "Write error - padding blocks added" },
+	{ 0x011700, "Recovered data with no error correction applied" },
+	{ 0x011701, "Recovered data with retries" },
+	{ 0x011702, "Recovered data with positive head offset" },
+	{ 0x011703, "Recovered data with negative head offset" },
+	{ 0x011704, "Recovered data with retries and/or CIRC applied" },
+	{ 0x011705, "Recovered data using previous sector ID" },
+	{ 0x011800, "Recovered data with error correction applied" },
+	{ 0x011801, "Recovered data with error correction and retries applied=
"},
+	{ 0x011802, "Recovered data - the data was auto-reallocated" },
+	{ 0x011803, "Recovered data with CIRC" },
+	{ 0x011804, "Recovered data with L-EC" },
+	{ 0x015d00, "Failure prediction threshold exceeded"
+		    " - Predicted logical unit failure" },
+	{ 0x015d01, "Failure prediction threshold exceeded"
+		    " - Predicted media failure" },
+	{ 0x015dff, "Failure prediction threshold exceeded - False" },
+	{ 0x017301, "Power calibration area almost full" },
+	{ 0x020400, "Logical unit not ready - cause not reportable" },
+	/* Following is misspelled in ATAPI 2.6, _and_ in Mt. Fuji */
+	{ 0x020401, "Logical unit not ready"
+		    " - in progress [sic] of becoming ready" },
+	{ 0x020402, "Logical unit not ready - initializing command required" =
},
+	{ 0x020403, "Logical unit not ready - manual intervention required" }=
,
+	{ 0x020404, "Logical unit not ready - format in progress" },
+	{ 0x020407, "Logical unit not ready - operation in progress" },
+	{ 0x020408, "Logical unit not ready - long write in progress" },
+	{ 0x020600, "No reference position found (media may be upside down)" =
},
+	{ 0x023000, "Incompatible medium installed" },
+	{ 0x023a00, "Medium not present" },
+	{ 0x025300, "Media load or eject failed" },
+	{ 0x025700, "Unable to recover table of contents" },
+	{ 0x030300, "Peripheral device write fault" },
+	{ 0x030301, "No write current" },
+	{ 0x030302, "Excessive write errors" },
+	{ 0x030c00, "Write error" },
+	{ 0x030c01, "Write error - Recovered with auto reallocation" },
+	{ 0x030c02, "Write error - auto reallocation failed" },
+	{ 0x030c03, "Write error - recommend reassignment" },
+	{ 0x030c04, "Compression check miscompare error" },
+	{ 0x030c05, "Data expansion occurred during compress" },
+	{ 0x030c06, "Block not compressible" },
+	{ 0x030c07, "Write error - recovery needed" },
+	{ 0x030c08, "Write error - recovery failed" },
+	{ 0x030c09, "Write error - loss of streaming" },
+	{ 0x031100, "Unrecovered read error" },
+	{ 0x031106, "CIRC unrecovered error" },
+	{ 0x033101, "Format command failed" },
+	{ 0x033200, "No defect spare location available" },
+	{ 0x033201, "Defect list update failure" },
+	{ 0x035100, "Erase failure" },
+	{ 0x037200, "Session fixation error" },
+	{ 0x037201, "Session fixation error writin lead-in" },
+	{ 0x037202, "Session fixation error writin lead-out" },
+	{ 0x037300, "CD control error" },
+	{ 0x037302, "Power calibration area is full" },
+	{ 0x037303, "Power calibration area error" },
+	{ 0x037304, "Program memory area / RMA update failure" },
+	{ 0x037305, "Program memory area / RMA is full" },
+	{ 0x037306, "Program memory area / RMA is (almost) full" },
+	{ 0x040200, "No seek complete" },
+	{ 0x040300, "Write fault" },
+	{ 0x040900, "Track following error" },
+	{ 0x040901, "Tracking servo failure" },
+	{ 0x040902, "Focus servo failure" },
+	{ 0x040903, "Spindle servo failure" },
+	{ 0x041500, "Random positioning error" },
+	{ 0x041501, "Mechanical positioning or changer error" },
+	{ 0x041502, "Positioning error detected by read of medium" },
+	{ 0x043c00, "Mechanical positioning or changer error" },
+	{ 0x044000, "Diagnostic failure on component (ASCQ)" },
+	{ 0x044400, "Internal CD/DVD logical unit failure" },
+	{ 0x04b600, "Media load mechanism failed" },
+	{ 0x051a00, "Parameter list length error" },
+	{ 0x052000, "Invalid command operation code" },
+	{ 0x052100, "Logical block address out of range" },
+	{ 0x052102, "Invalid address for write" },
+	{ 0x052400, "Invalid field in command packet" },
+	{ 0x052600, "Invalid field in parameter list" },
+	{ 0x052601, "Parameter not supported" },
+	{ 0x052602, "Parameter value invalid" },
+	{ 0x052700, "Write protected media" },
+	{ 0x052c00, "Command sequence error" },
+	{ 0x052c03, "Current program area is not empty" },
+	{ 0x052c04, "Current program area is empty" },
+	{ 0x053001, "Cannot read medium - unknown format" },
+	{ 0x053002, "Cannot read medium - incompatible format" },
+	{ 0x053900, "Saving parameters not supported" },
+	{ 0x054e00, "Overlapped commands attempted" },
+	{ 0x055302, "Medium removal prevented" },
+	{ 0x055500, "System resource failure" },
+	{ 0x056300, "End of user area encountered on this track" },
+	{ 0x056400, "Illegal mode for this track or incompatible medium" },
+	{ 0x056f00, "Copy protection key exchange failure"
+		    " - Authentication failure" },
+	{ 0x056f01, "Copy protection key exchange failure - Key not present" =
},
+	{ 0x056f02, "Copy protection key exchange failure"
+		     " - Key not established" },
+	{ 0x056f03, "Read of scrambled sector without authentication" },
+	{ 0x056f04, "Media region code is mismatched to logical unit" },
+	{ 0x056f05, "Drive region must be permanent"
+		    " / region reset count error" },
+	{ 0x057203, "Session fixation error - incomplete track in session" },
+	{ 0x057204, "Empty or partially written reserved track" },
+	{ 0x057205, "No more RZONE reservations are allowed" },
+	{ 0x05bf00, "Loss of streaming" },
+	{ 0x062800, "Not ready to ready transition, medium may have changed" =
},
+	{ 0x062900, "Power on, reset or hardware reset occurred" },
+	{ 0x062a00, "Parameters changed" },
+	{ 0x062a01, "Mode parameters changed" },
+	{ 0x062e00, "Insufficient time for operation" },
+	{ 0x063f00, "Logical unit operating conditions have changed" },
+	{ 0x063f01, "Microcode has been changed" },
+	{ 0x065a00, "Operator request or state change input (unspecified)" },
+	{ 0x065a01, "Operator medium removal request" },
+	{ 0x0bb900, "Play operation aborted" },
+	/* Here we use 0xff for the key (not a valid key) to signify
+	 * that these can have _any_ key value associated with them... */
+	{ 0xff0401, "Logical unit is in process of becoming ready" },
+	{ 0xff0400, "Logical unit not ready, cause not reportable" },
+	{ 0xff0402, "Logical unit not ready, initializing command required" }=
,
+	{ 0xff0403, "Logical unit not ready, manual intervention required" },
+	{ 0xff0500, "Logical unit does not respond to selection" },
+	{ 0xff0800, "Logical unit communication failure" },
+	{ 0xff0802, "Logical unit communication parity error" },
+	{ 0xff0801, "Logical unit communication time-out" },
+	{ 0xff2500, "Logical unit not supported" },
+	{ 0xff4c00, "Logical unit failed self-configuration" },
+	{ 0xff3e00, "Logical unit has not self-configured yet" },
+};
+
+void ide_cd_log_error(const char *name, struct request *failed_command=
,
+		      struct request_sense *sense)
+{
+	int i;
+	const char *s =3D "bad sense key!";
+	char buf[80];
+
+	printk(KERN_ERR "ATAPI device %s:\n", name);
+	if (sense->error_code =3D=3D 0x70)
+		printk(KERN_CONT "  Error: ");
+	else if (sense->error_code =3D=3D 0x71)
+		printk("  Deferred Error: ");
+	else if (sense->error_code =3D=3D 0x7f)
+		printk(KERN_CONT "  Vendor-specific Error: ");
+	else
+		printk(KERN_CONT "  Unknown Error Type: ");
+
+	if (sense->sense_key < ARRAY_SIZE(sense_key_texts))
+		s =3D sense_key_texts[sense->sense_key];
+
+	printk(KERN_CONT "%s -- (Sense key=3D0x%02x)\n", s, sense->sense_key)=
;
+
+	if (sense->asc =3D=3D 0x40) {
+		sprintf(buf, "Diagnostic failure on component 0x%02x",
+			sense->ascq);
+		s =3D buf;
+	} else {
+		int lo =3D 0, mid, hi =3D ARRAY_SIZE(sense_data_texts);
+		unsigned long key =3D (sense->sense_key << 16);
+
+		key |=3D (sense->asc << 8);
+		if (!(sense->ascq >=3D 0x80 && sense->ascq <=3D 0xdd))
+			key |=3D sense->ascq;
+		s =3D NULL;
+
+		while (hi > lo) {
+			mid =3D (lo + hi) / 2;
+			if (sense_data_texts[mid].asc_ascq =3D=3D key ||
+			    sense_data_texts[mid].asc_ascq =3D=3D (0xff0000|key)) {
+				s =3D sense_data_texts[mid].text;
+				break;
+			} else if (sense_data_texts[mid].asc_ascq > key)
+				hi =3D mid;
+			else
+				lo =3D mid + 1;
+		}
+	}
+
+	if (s =3D=3D NULL) {
+		if (sense->asc > 0x80)
+			s =3D "(vendor-specific error)";
+		else
+			s =3D "(reserved error code)";
+	}
+
+	printk(KERN_ERR "  %s -- (asc=3D0x%02x, ascq=3D0x%02x)\n",
+			s, sense->asc, sense->ascq);
+
+	if (failed_command !=3D NULL) {
+		int lo =3D 0, mid, hi =3D ARRAY_SIZE(packet_command_texts);
+		s =3D NULL;
+
+		while (hi > lo) {
+			mid =3D (lo + hi) / 2;
+			if (packet_command_texts[mid].packet_command =3D=3D
+			    failed_command->cmd[0]) {
+				s =3D packet_command_texts[mid].text;
+				break;
+			}
+			if (packet_command_texts[mid].packet_command >
+			    failed_command->cmd[0])
+				hi =3D mid;
+			else
+				lo =3D mid + 1;
+		}
+
+		printk(KERN_ERR "  The failed \"%s\" packet command "
+				"was: \n  \"", s);
+		for (i =3D 0; i < sizeof(failed_command->cmd); i++)
+			printk(KERN_CONT "%02x ", failed_command->cmd[i]);
+		printk(KERN_CONT "\"\n");
+	}
+
+	/* The SKSV bit specifies validity of the sense_key_specific
+	 * in the next two commands. It is bit 7 of the first byte.
+	 * In the case of NOT_READY, if SKSV is set the drive can
+	 * give us nice ETA readings.
+	 */
+	if (sense->sense_key =3D=3D NOT_READY && (sense->sks[0] & 0x80)) {
+		int progress =3D (sense->sks[1] << 8 | sense->sks[2]) * 100;
+
+		printk(KERN_ERR "  Command is %02d%% complete\n",
+				progress / 0xffff);
+	}
+
+	if (sense->sense_key =3D=3D ILLEGAL_REQUEST &&
+	    (sense->sks[0] & 0x80) !=3D 0) {
+		printk(KERN_ERR "  Error in %s byte %d",
+				(sense->sks[0] & 0x40) !=3D 0 ?
+				"command packet" : "command data",
+				(sense->sks[1] << 8) + sense->sks[2]);
+
+		if ((sense->sks[0] & 0x40) !=3D 0)
+			printk(KERN_CONT " bit %d", sense->sks[0] & 0x07);
+
+		printk(KERN_CONT "\n");
+	}
+}
+#endif
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 717e114..3c69822 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1,10 +1,9 @@
 /*
- *  linux/drivers/ide/ide-disk.c	Version 1.18	Mar 05, 2003
- *
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
- *  Copyright (C) 1998-2002  Linux ATA Development
- *				Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2003	     Red Hat <alan@redhat.com>
+ *  Copyright (C) 1994-1998	   Linus Torvalds & authors (see below)
+ *  Copyright (C) 1998-2002	   Linux ATA Development
+ *				      Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2003		   Red Hat <alan@redhat.com>
+ *  Copyright (C) 2003-2005, 2007  Bartlomiej Zolnierkiewicz
  */
=20
 /*
diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 5bf3203..7beaf1e 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -1,15 +1,13 @@
 /*
- *  linux/drivers/ide/ide-dma.c		Version 4.10	June 9, 2000
+ *  Copyright (C) 1995-1998   Mark Lord
+ *  Copyright (C) 1999-2000   Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2004, 2007  Bartlomiej Zolnierkiewicz
  *
- *  Copyright (c) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  *  May be copied or modified under the terms of the GNU General Publi=
c License
  */
=20
 /*
  *  Special Thanks to Mark for his Six years of work.
- *
- *  Copyright (c) 1995-1998  Mark Lord
- *  May be copied or modified under the terms of the GNU General Publi=
c License
  */
=20
 /*
@@ -85,6 +83,7 @@
 #include <linux/ide.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
=20
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -169,16 +168,15 @@ static int ide_dma_good_drive(ide_drive_t *drive)
 	return ide_in_drive_list(drive->id, drive_whitelist);
 }
=20
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_build_sglist	-	map IDE scatter gather for DMA I/O
  *	@drive: the drive to build the DMA table for
  *	@rq: the request holding the sg list
  *
- *	Perform the PCI mapping magic necessary to access the source or
- *	target buffers of a request via PCI DMA. The lower layers of the
+ *	Perform the DMA mapping magic necessary to access the source or
+ *	target buffers of a request via DMA.  The lower layers of the
  *	kernel provide the necessary cache management so that we can
- *	operate in a portable fashion
+ *	operate in a portable fashion.
  */
=20
 int ide_build_sglist(ide_drive_t *drive, struct request *rq)
@@ -186,20 +184,20 @@ int ide_build_sglist(ide_drive_t *drive, struct r=
equest *rq)
 	ide_hwif_t *hwif =3D HWIF(drive);
 	struct scatterlist *sg =3D hwif->sg_table;
=20
-	BUG_ON((rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) && rq->nr_sectors =
> 256);
-
 	ide_map_sg(drive, rq);
=20
 	if (rq_data_dir(rq) =3D=3D READ)
-		hwif->sg_dma_direction =3D PCI_DMA_FROMDEVICE;
+		hwif->sg_dma_direction =3D DMA_FROM_DEVICE;
 	else
-		hwif->sg_dma_direction =3D PCI_DMA_TODEVICE;
+		hwif->sg_dma_direction =3D DMA_TO_DEVICE;
=20
-	return pci_map_sg(hwif->pci_dev, sg, hwif->sg_nents, hwif->sg_dma_dir=
ection);
+	return dma_map_sg(hwif->dev, sg, hwif->sg_nents,
+			  hwif->sg_dma_direction);
 }
=20
 EXPORT_SYMBOL_GPL(ide_build_sglist);
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
@@ -284,16 +282,17 @@ int ide_build_dmatable (ide_drive_t *drive, struc=
t request *rq)
 			*--table |=3D cpu_to_le32(0x80000000);
 		return count;
 	}
+
 	printk(KERN_ERR "%s: empty DMA table?\n", drive->name);
+
 use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev,
-		     hwif->sg_table,
-		     hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
+
 	return 0; /* revert to PIO for this request */
 }
=20
 EXPORT_SYMBOL_GPL(ide_build_dmatable);
+#endif
=20
 /**
  *	ide_destroy_dmatable	-	clean up DMA mapping
@@ -308,15 +307,15 @@ EXPORT_SYMBOL_GPL(ide_build_dmatable);
 =20
 void ide_destroy_dmatable (ide_drive_t *drive)
 {
-	struct pci_dev *dev =3D HWIF(drive)->pci_dev;
-	struct scatterlist *sg =3D HWIF(drive)->sg_table;
-	int nents =3D HWIF(drive)->sg_nents;
+	ide_hwif_t *hwif =3D drive->hwif;
=20
-	pci_unmap_sg(dev, sg, nents, HWIF(drive)->sg_dma_direction);
+	dma_unmap_sg(hwif->dev, hwif->sg_table, hwif->sg_nents,
+		     hwif->sg_dma_direction);
 }
=20
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	config_drive_for_dma	-	attempt to activate IDE DMA
  *	@drive: the drive to place in DMA mode
@@ -474,8 +473,6 @@ void ide_dma_on(ide_drive_t *drive)
 	drive->hwif->dma_host_set(drive, 1);
 }
=20
-EXPORT_SYMBOL(ide_dma_on);
-
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_setup	-	begin a DMA phase
@@ -847,10 +844,10 @@ EXPORT_SYMBOL(ide_dma_timeout);
 static void ide_release_dma_engine(ide_hwif_t *hwif)
 {
 	if (hwif->dmatable_cpu) {
-		pci_free_consistent(hwif->pci_dev,
-				    PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu,
-				    hwif->dmatable_dma);
+		struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
+
+		pci_free_consistent(pdev, PRD_ENTRIES * PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
 		hwif->dmatable_cpu =3D NULL;
 	}
 }
@@ -878,7 +875,9 @@ int ide_release_dma(ide_hwif_t *hwif)
=20
 static int ide_allocate_dma_engine(ide_hwif_t *hwif)
 {
-	hwif->dmatable_cpu =3D pci_alloc_consistent(hwif->pci_dev,
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
+
+	hwif->dmatable_cpu =3D pci_alloc_consistent(pdev,
 						  PRD_ENTRIES * PRD_BYTES,
 						  &hwif->dmatable_dma);
=20
@@ -891,19 +890,19 @@ static int ide_allocate_dma_engine(ide_hwif_t *hw=
if)
 	return 1;
 }
=20
-static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base, u=
nsigned int ports)
+static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
=20
 	return 0;
 }
=20
-static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigne=
d int ports)
+static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
-	       hwif->name, base, base + ports - 1);
+	       hwif->name, base, base + 7);
=20
-	if (!request_region(base, ports, hwif->name)) {
+	if (!request_region(base, 8, hwif->name)) {
 		printk(" -- Error, ports in use.\n");
 		return 1;
 	}
@@ -915,7 +914,7 @@ static int ide_iomio_dma(ide_hwif_t *hwif, unsigned=
 long base, unsigned int port
 			if (!request_region(hwif->extra_base,
 					    hwif->cds->extra, hwif->cds->name)) {
 				printk(" -- Error, extra ports in use.\n");
-				release_region(base, ports);
+				release_region(base, 8);
 				return 1;
 			}
 			hwif->extra_ports =3D hwif->cds->extra;
@@ -925,17 +924,19 @@ static int ide_iomio_dma(ide_hwif_t *hwif, unsign=
ed long base, unsigned int port
 	return 0;
 }
=20
-static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base, unsign=
ed int ports)
+static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base)
 {
 	if (hwif->mmio)
-		return ide_mapped_mmio_dma(hwif, base,ports);
+		return ide_mapped_mmio_dma(hwif, base);
=20
-	return ide_iomio_dma(hwif, base, ports);
+	return ide_iomio_dma(hwif, base);
 }
=20
-void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_=
ports)
+void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
-	if (ide_dma_iobase(hwif, base, num_ports))
+	u8 dma_stat;
+
+	if (ide_dma_iobase(hwif, base))
 		return;
=20
 	if (ide_allocate_dma_engine(hwif)) {
@@ -945,16 +946,16 @@ void ide_setup_dma(ide_hwif_t *hwif, unsigned lon=
g base, unsigned num_ports)
=20
 	hwif->dma_base =3D base;
=20
-	if (!(hwif->dma_command))
-		hwif->dma_command	=3D hwif->dma_base;
-	if (!(hwif->dma_vendor1))
-		hwif->dma_vendor1	=3D (hwif->dma_base + 1);
-	if (!(hwif->dma_status))
-		hwif->dma_status	=3D (hwif->dma_base + 2);
-	if (!(hwif->dma_vendor3))
-		hwif->dma_vendor3	=3D (hwif->dma_base + 3);
-	if (!(hwif->dma_prdtable))
-		hwif->dma_prdtable	=3D (hwif->dma_base + 4);
+	if (!hwif->dma_command)
+		hwif->dma_command	=3D hwif->dma_base + 0;
+	if (!hwif->dma_vendor1)
+		hwif->dma_vendor1	=3D hwif->dma_base + 1;
+	if (!hwif->dma_status)
+		hwif->dma_status	=3D hwif->dma_base + 2;
+	if (!hwif->dma_vendor3)
+		hwif->dma_vendor3	=3D hwif->dma_base + 3;
+	if (!hwif->dma_prdtable)
+		hwif->dma_prdtable	=3D hwif->dma_base + 4;
=20
 	if (!hwif->dma_host_set)
 		hwif->dma_host_set =3D &ide_dma_host_set;
@@ -973,13 +974,10 @@ void ide_setup_dma(ide_hwif_t *hwif, unsigned lon=
g base, unsigned num_ports)
 	if (!hwif->dma_lost_irq)
 		hwif->dma_lost_irq =3D &ide_dma_lost_irq;
=20
-	if (hwif->chipset !=3D ide_trm290) {
-		u8 dma_stat =3D hwif->INB(hwif->dma_status);
-		printk(", BIOS settings: %s:%s, %s:%s",
-		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
-	}
-	printk("\n");
+	dma_stat =3D hwif->INB(hwif->dma_status);
+	printk(KERN_CONT ", BIOS settings: %s:%s, %s:%s\n",
+	       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "PIO",
+	       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "PIO");
 }
=20
 EXPORT_SYMBOL_GPL(ide_setup_dma);
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index ff8232e..3512637 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1,13 +1,12 @@
 /*
- * linux/drivers/ide/ide-floppy.c	Version 0.99	Feb 24 2002
+ * IDE ATAPI floppy driver.
  *
- * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
- * Copyright (C) 2000 - 2002 Paul Bristow <paul@paulbristow.net>
+ * Copyright (C) 1996-1999  Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2000-2002  Paul Bristow <paul@paulbristow.net>
+ * Copyright (C) 2005       Bartlomiej Zolnierkiewicz
  */
=20
 /*
- * IDE ATAPI floppy driver.
- *
  * The driver currently doesn't have any fancy features, just the bare
  * minimum read/write support.
  *
@@ -17,67 +16,8 @@
  * Iomega Zip 100/250
  * Iomega PC Card Clik!/PocketZip
  *
- * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so =
many
- * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy dri=
ve.
- *
- * Ver 0.1   Oct 17 96   Initial test version, mostly based on ide-tap=
e.c.
- * Ver 0.2   Oct 31 96   Minor changes.
- * Ver 0.3   Dec  2 96   Fixed error recovery bug.
- * Ver 0.4   Jan 26 97   Add support for the HDIO_GETGEO ioctl.
- * Ver 0.5   Feb 21 97   Add partitions support.
- *                       Use the minimum of the LBA and CHS capacities=
=2E
- *                       Avoid hwgroup->rq =3D=3D NULL on the last irq=
=2E
- *                       Fix potential null dereferencing with DEBUG_L=
OG.
- * Ver 0.8   Dec  7 97   Increase irq timeout from 10 to 50 seconds.
- *                       Add media write-protect detection.
- *                       Issue START command only if TEST UNIT READY f=
ails.
- *                       Add work-around for IOMEGA ZIP revision 21.D.
- *                       Remove idefloppy_get_capabilities().
- * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number =
of
- *                        bytes requested on each interrupt to be zero=
=2E
- *                        Thanks to <shanos@es.co.nz> for pointing thi=
s out.
- * Ver 0.9.sv Jan 6 01   Sam Varshavchik <mrsam@courier-mta.com>
- *                       Implement low level formatting.  Reimplemente=
d
- *                       IDEFLOPPY_CAPABILITIES_PAGE, since we need th=
e srfp
- *                       bit.  My LS-120 drive barfs on
- *                       IDEFLOPPY_CAPABILITIES_PAGE, but maybe it's j=
ust me.
- *                       Compromise by not reporting a failure to get =
this
- *                       mode page.  Implemented four IOCTLs in order =
to
- *                       implement formatting.  IOCTls begin with 0x46=
00,
- *                       0x46 is 'F' as in Format.
- *            Jan 9 01   Userland option to select format verify.
- *                       Added PC_SUPPRESS_ERROR flag - some idefloppy=
 drives
- *                       do not implement IDEFLOPPY_CAPABILITIES_PAGE,=
 and
- *                       return a sense error.  Suppress error reporti=
ng in
- *                       this particular case in order to avoid spurio=
us
- *                       errors in syslog.  The culprit is
- *                       idefloppy_get_capability_page(), so move it t=
o
- *                       idefloppy_begin_format() so that it's not use=
d
- *                       unless absolutely necessary.
- *                       If drive does not support format progress ind=
ication
- *                       monitor the dsc bit in the status register.
- *                       Also, O_NDELAY on open will allow the device =
to be
- *                       opened without a disk available.  This can be=
 used to
- *                       open an unformatted disk, or get the device c=
apacity.
- * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by=20
- *     		   <paul@paulbristow.net>
- * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for t=
his=20
- *           		   driver.  Included Powerbook internal zip kludge.
- * Ver 0.93  Oct 24 00   Fixed bugs for Clik! drive
- *                        no disk on insert and disk change now works
- * Ver 0.94  Oct 27 00   Tidied up to remove strstr(Clik) everywhere
- * Ver 0.95  Nov  7 00   Brought across to kernel 2.4
- * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.=
0
- *                       including set_bit patch from Rusty Russell
- * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
- * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
- * Ver 0.98  Oct 26 01   Split idefloppy_transfer_pc into two pieces t=
o
- *                        fix a lost interrupt problem. It appears the=
 busy
- *                        bit was being deasserted by my IOMEGA ATAPI =
ZIP 100
- *                        drive before the drive was actually ready.
- * Ver 0.98a Oct 29 01   Expose delay value so we can play.
- * Ver 0.99  Feb 24 02   Remove duplicate code, modify clik! detection=
 code=20
- *                        to support new PocketZip drives=20
+ * For a historical changelog see
+ * Documentation/ide/ChangeLog.ide-floppy.1996-2002
  */
=20
 #define IDEFLOPPY_VERSION "0.99.newide"
@@ -1658,7 +1598,6 @@ static int idefloppy_identify_device (ide_drive_t=
 *drive,struct hd_driveid *id)
 {
 	struct idefloppy_id_gcw gcw;
 #if IDEFLOPPY_DEBUG_INFO
-	u16 mask,i;
 	char buffer[80];
 #endif /* IDEFLOPPY_DEBUG_INFO */
=20
@@ -1705,55 +1644,6 @@ static int idefloppy_identify_device (ide_drive_=
t *drive,struct hd_driveid *id)
 		default: sprintf(buffer, "Reserved");break;
 	}
 	printk(KERN_INFO "Command Packet Size: %s\n", buffer);
-	printk(KERN_INFO "Model: %.40s\n",id->model);
-	printk(KERN_INFO "Firmware Revision: %.8s\n",id->fw_rev);
-	printk(KERN_INFO "Serial Number: %.20s\n",id->serial_no);
-	printk(KERN_INFO "Write buffer size(?): %d bytes\n",id->buf_size*512)=
;
-	printk(KERN_INFO "DMA: %s",id->capability & 0x01 ? "Yes\n":"No\n");
-	printk(KERN_INFO "LBA: %s",id->capability & 0x02 ? "Yes\n":"No\n");
-	printk(KERN_INFO "IORDY can be disabled: %s",id->capability & 0x04 ? =
"Yes\n":"No\n");
-	printk(KERN_INFO "IORDY supported: %s",id->capability & 0x08 ? "Yes\n=
":"Unknown\n");
-	printk(KERN_INFO "ATAPI overlap supported: %s",id->capability & 0x20 =
? "Yes\n":"No\n");
-	printk(KERN_INFO "PIO Cycle Timing Category: %d\n",id->tPIO);
-	printk(KERN_INFO "DMA Cycle Timing Category: %d\n",id->tDMA);
-	printk(KERN_INFO "Single Word DMA supported modes:\n");
-	for (i=3D0,mask=3D1;i<8;i++,mask=3Dmask << 1) {
-		if (id->dma_1word & mask)
-			printk(KERN_INFO "   Mode %d%s\n", i,
-			(id->dma_1word & (mask << 8)) ? " (active)" : "");
-	}
-	printk(KERN_INFO "Multi Word DMA supported modes:\n");
-	for (i=3D0,mask=3D1;i<8;i++,mask=3Dmask << 1) {
-		if (id->dma_mword & mask)
-			printk(KERN_INFO "   Mode %d%s\n", i,
-			(id->dma_mword & (mask << 8)) ? " (active)" : "");
-	}
-	if (id->field_valid & 0x0002) {
-		printk(KERN_INFO "Enhanced PIO Modes: %s\n",
-			id->eide_pio_modes & 1 ? "Mode 3":"None");
-		if (id->eide_dma_min =3D=3D 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_dma_min);
-		printk(KERN_INFO "Minimum Multi-word DMA cycle per word: %s\n", buff=
er);
-		if (id->eide_dma_time =3D=3D 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_dma_time);
-		printk(KERN_INFO "Manufacturer\'s Recommended Multi-word cycle: %s\n=
", buffer);
-		if (id->eide_pio =3D=3D 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_pio);
-		printk(KERN_INFO "Minimum PIO cycle without IORDY: %s\n",
-			buffer);
-		if (id->eide_pio_iordy =3D=3D 0)
-			sprintf(buffer, "Not supported");
-		else
-			sprintf(buffer, "%d ns",id->eide_pio_iordy);
-		printk(KERN_INFO "Minimum PIO cycle with IORDY: %s\n", buffer);
-	} else
-		printk(KERN_INFO "According to the device, fields 64-70 are not vali=
d.\n");
 #endif /* IDEFLOPPY_DEBUG_INFO */
=20
 	if (gcw.protocol !=3D 2)
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index e6bb9cf..4bddef0 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1487,7 +1487,7 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 		 * remove all the ifdef PCI crap
 		 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
-		if (hwif->pci_dev && !hwif->pci_dev->vendor)
+		if (hwif->chipset !=3D ide_pci)
 #endif	/* CONFIG_BLK_DEV_IDEPCI */
 		{
 			/*
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index e2a7e95..16b1f6e 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/ide-iops.c	Version 0.37	Mar 05, 2003
- *
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003		Red Hat <alan@redhat.com>
  *
@@ -1168,7 +1166,7 @@ EXPORT_SYMBOL(ide_do_reset);
=20
 /*
  * ide_wait_not_busy() waits for the currently selected device on the =
hwif
- * to report a non-busy status, see comments in probe_hwif().
+ * to report a non-busy status, see comments in ide_probe_port().
  */
 int ide_wait_not_busy(ide_hwif_t *hwif, unsigned long timeout)
 {
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
index 9b44fbd..b42940d 100644
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -358,8 +358,10 @@ void ide_toggle_bounce(ide_drive_t *drive, int on)
 	if (!PCI_DMA_BUS_IS_PHYS) {
 		addr =3D BLK_BOUNCE_ANY;
 	} else if (on && drive->media =3D=3D ide_disk) {
-		if (HWIF(drive)->pci_dev)
-			addr =3D HWIF(drive)->pci_dev->dma_mask;
+		struct device *dev =3D drive->hwif->dev;
+
+		if (dev && dev->dma_mask)
+			addr =3D *dev->dma_mask;
 	}
=20
 	if (drive->queue)
diff --git a/drivers/ide/ide-pnp.c b/drivers/ide/ide-pnp.c
index cbbb0f7..4bda5cf 100644
--- a/drivers/ide/ide-pnp.c
+++ b/drivers/ide/ide-pnp.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/ide-pnp.c
- *
  * This file provides autodetection for ISA PnP IDE interfaces.
  * It was tested with "ESS ES1868 Plug and Play AudioDrive" IDE interf=
ace.
  *
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index edf650b..98a8af4 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1,7 +1,6 @@
 /*
- *  linux/drivers/ide/ide-probe.c	Version 1.11	Mar 05, 2003
- *
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1994-1998   Linus Torvalds & authors (see below)
+ *  Copyright (C) 2005, 2007  Bartlomiej Zolnierkiewicz
  */
=20
 /*
@@ -129,6 +128,10 @@ static inline void do_identify (ide_drive_t *drive=
, u8 cmd)
=20
 	drive->id_read =3D 1;
 	local_irq_enable();
+#ifdef DEBUG
+	printk(KERN_INFO "%s: dumping identify data\n", drive->name);
+	ide_dump_identify((u8 *)id);
+#endif
 	ide_fix_driveid(id);
=20
 #if defined (CONFIG_SCSI_EATA_PIO) || defined (CONFIG_SCSI_EATA)
@@ -610,7 +613,7 @@ static void hwif_release_dev (struct device *dev)
 	complete(&hwif->gendev_rel_comp);
 }
=20
-static void hwif_register (ide_hwif_t *hwif)
+static void ide_register_port(ide_hwif_t *hwif)
 {
 	int ret;
=20
@@ -618,8 +621,8 @@ static void hwif_register (ide_hwif_t *hwif)
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	hwif->gendev.driver_data =3D hwif;
 	if (hwif->gendev.parent =3D=3D NULL) {
-		if (hwif->pci_dev)
-			hwif->gendev.parent =3D &hwif->pci_dev->dev;
+		if (hwif->dev)
+			hwif->gendev.parent =3D hwif->dev;
 		else
 			/* Would like to do =3D &device_legacy */
 			hwif->gendev.parent =3D NULL;
@@ -631,7 +634,33 @@ static void hwif_register (ide_hwif_t *hwif)
 			__FUNCTION__, ret);
 }
=20
-static int wait_hwif_ready(ide_hwif_t *hwif)
+/**
+ *	ide_port_wait_ready	-	wait for port to become ready
+ *	@hwif: IDE port
+ *
+ *	This is needed on some PPCs and a bunch of BIOS-less embedded
+ *	platforms.  Typical cases are:
+ *
+ *	- The firmware hard reset the disk before booting the kernel,
+ *	  the drive is still doing it's poweron-reset sequence, that
+ *	  can take up to 30 seconds.
+ *
+ *	- The firmware does nothing (or no firmware), the device is
+ *	  still in POST state (same as above actually).
+ *
+ *	- Some CD/DVD/Writer combo drives tend to drive the bus during
+ *	  their reset sequence even when they are non-selected slave
+ *	  devices, thus preventing discovery of the main HD.
+ *
+ *	Doing this wait-for-non-busy should not harm any existing
+ *	configuration and fix some issues like the above.
+ *
+ *	BenH.
+ *
+ *	Returns 0 on success, error code (< 0) otherwise.
+ */
+
+static int ide_port_wait_ready(ide_hwif_t *hwif)
 {
 	int unit, rc;
=20
@@ -709,36 +738,16 @@ void ide_undecoded_slave(ide_drive_t *drive1)
=20
 EXPORT_SYMBOL_GPL(ide_undecoded_slave);
=20
-/*
- * This routine only knows how to look for drive units 0 and 1
- * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
- */
-static void probe_hwif(ide_hwif_t *hwif)
+static int ide_probe_port(ide_hwif_t *hwif)
 {
 	unsigned long flags;
 	unsigned int irqd;
-	int unit;
+	int unit, rc =3D -ENODEV;
=20
-	if (hwif->noprobe)
-		return;
+	BUG_ON(hwif->present);
=20
-	if ((hwif->chipset !=3D ide_4drives || !hwif->mate || !hwif->mate->pr=
esent) &&
-	    (ide_hwif_request_regions(hwif))) {
-		u16 msgout =3D 0;
-		for (unit =3D 0; unit < MAX_DRIVES; ++unit) {
-			ide_drive_t *drive =3D &hwif->drives[unit];
-			if (drive->present) {
-				drive->present =3D 0;
-				printk(KERN_ERR "%s: ERROR, PORTS ALREADY IN USE\n",
-					drive->name);
-				msgout =3D 1;
-			}
-		}
-		if (!msgout)
-			printk(KERN_ERR "%s: ports already in use, skipping probe\n",
-				hwif->name);
-		return;=09
-	}
+	if (hwif->noprobe)
+		return -EACCES;
=20
 	/*
 	 * We must always disable IRQ, as probe_for_drive will assert IRQ, bu=
t
@@ -750,26 +759,7 @@ static void probe_hwif(ide_hwif_t *hwif)
=20
 	local_irq_set(flags);
=20
-	/* This is needed on some PPCs and a bunch of BIOS-less embedded
-	 * platforms. Typical cases are:
-	 *=20
-	 *  - The firmware hard reset the disk before booting the kernel,
-	 *    the drive is still doing it's poweron-reset sequence, that
-	 *    can take up to 30 seconds
-	 *  - The firmware does nothing (or no firmware), the device is
-	 *    still in POST state (same as above actually).
-	 *  - Some CD/DVD/Writer combo drives tend to drive the bus during
-	 *    their reset sequence even when they are non-selected slave
-	 *    devices, thus preventing discovery of the main HD
-	 *   =20
-	 *  Doing this wait-for-busy should not harm any existing configurati=
on
-	 *  (at least things won't be worse than what current code does, that
-	 *  is blindly go & talk to the drive) and fix some issues like the
-	 *  above.
-	 * =20
-	 *  BenH.
-	 */
-	if (wait_hwif_ready(hwif) =3D=3D -EBUSY)
+	if (ide_port_wait_ready(hwif) =3D=3D -EBUSY)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif=
->name);
=20
 	/*
@@ -779,14 +769,8 @@ static void probe_hwif(ide_hwif_t *hwif)
 		ide_drive_t *drive =3D &hwif->drives[unit];
 		drive->dn =3D (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
-		if (drive->present && !hwif->present) {
-			hwif->present =3D 1;
-			if (hwif->chipset !=3D ide_4drives ||
-			    !hwif->mate ||=20
-			    !hwif->mate->present) {
-				hwif_register(hwif);
-			}
-		}
+		if (drive->present)
+			rc =3D 0;
 	}
 	if (hwif->io_ports[IDE_CONTROL_OFFSET] && hwif->reset) {
 		printk(KERN_WARNING "%s: reset\n", hwif->name);
@@ -803,10 +787,12 @@ static void probe_hwif(ide_hwif_t *hwif)
 	if (irqd)
 		enable_irq(irqd);
=20
-	if (!hwif->present) {
-		ide_hwif_release_regions(hwif);
-		return;
-	}
+	return rc;
+}
+
+static void ide_port_tune_devices(ide_hwif_t *hwif)
+{
+	int unit;
=20
 	for (unit =3D 0; unit < MAX_DRIVES; unit++) {
 		ide_drive_t *drive =3D &hwif->drives[unit];
@@ -997,21 +983,17 @@ static int init_irq (ide_hwif_t *hwif)
 		spin_lock_irq(&ide_lock);
 		hwif->next =3D hwgroup->hwif->next;
 		hwgroup->hwif->next =3D hwif;
+		BUG_ON(hwif->next =3D=3D hwif);
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup =3D kmalloc_node(sizeof(ide_hwgroup_t),
-					GFP_KERNEL | __GFP_ZERO,
-					hwif_to_node(hwif->drives[0].hwif));
-		if (!hwgroup)
-	       		goto out_up;
+		hwgroup =3D kmalloc_node(sizeof(*hwgroup), GFP_KERNEL|__GFP_ZERO,
+				       hwif_to_node(hwif));
+		if (hwgroup =3D=3D NULL)
+			goto out_up;
=20
 		hwif->hwgroup =3D hwgroup;
+		hwgroup->hwif =3D hwif->next =3D hwif;
=20
-		hwgroup->hwif     =3D hwif->next =3D hwif;
-		hwgroup->rq       =3D NULL;
-		hwgroup->handler  =3D NULL;
-		hwgroup->drive    =3D NULL;
-		hwgroup->busy     =3D 0;
 		init_timer(&hwgroup->timer);
 		hwgroup->timer.function =3D &ide_timer_expiry;
 		hwgroup->timer.data =3D (unsigned long) hwgroup;
@@ -1079,25 +1061,7 @@ static int init_irq (ide_hwif_t *hwif)
 	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_unlink:
-	spin_lock_irq(&ide_lock);
-	if (hwif->next =3D=3D hwif) {
-		BUG_ON(match);
-		BUG_ON(hwgroup->hwif !=3D hwif);
-		kfree(hwgroup);
-	} else {
-		ide_hwif_t *g;
-		g =3D hwgroup->hwif;
-		while (g->next !=3D hwif)
-			g =3D g->next;
-		g->next =3D hwif->next;
-		if (hwgroup->hwif =3D=3D hwif) {
-			/* Impossible. */
-			printk(KERN_ERR "Duh. Uninitialized hwif listed as active hwif.\n")=
;
-			hwgroup->hwif =3D g;
-		}
-		BUG_ON(hwgroup->hwif =3D=3D hwif);
-	}
-	spin_unlock_irq(&ide_lock);
+	ide_remove_port_from_hwgroup(hwif);
 out_up:
 	mutex_unlock(&ide_cfg_mtx);
 	return 1;
@@ -1246,28 +1210,21 @@ static int hwif_init(ide_hwif_t *hwif)
 {
 	int old_irq;
=20
-	/* Return success if no device is connected */
-	if (!hwif->present)
-		return 1;
-
 	if (!hwif->irq) {
 		if (!(hwif->irq =3D ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET])=
))
 		{
 			printk("%s: DISABLED, NO IRQ\n", hwif->name);
-			return (hwif->present =3D 0);
+			return 0;
 		}
 	}
 #ifdef CONFIG_BLK_DEV_HD
 	if (hwif->irq =3D=3D HD_IRQ && hwif->io_ports[IDE_DATA_OFFSET] !=3D H=
D_DATA) {
 		printk("%s: CANNOT SHARE IRQ WITH OLD "
 			"HARDDISK DRIVER (hd.c)\n", hwif->name);
-		return (hwif->present =3D 0);
+		return 0;
 	}
 #endif /* CONFIG_BLK_DEV_HD */
=20
-	/* we set it back to 1 if all is ok below */=09
-	hwif->present =3D 0;
-
 	if (register_blkdev(hwif->major, hwif->name))
 		return 0;
=20
@@ -1306,10 +1263,7 @@ static int hwif_init(ide_hwif_t *hwif)
=20
 done:
 	init_gendisk(hwif);
-
 	ide_acpi_init(hwif);
-
-	hwif->present =3D 1;	/* success */
 	return 1;
=20
 out:
@@ -1344,7 +1298,27 @@ int ide_device_add_all(u8 *idx)
 		if (idx[i] =3D=3D 0xff)
 			continue;
=20
-		probe_hwif(&ide_hwifs[idx[i]]);
+		hwif =3D &ide_hwifs[idx[i]];
+
+		if ((hwif->chipset !=3D ide_4drives || !hwif->mate ||
+		     !hwif->mate->present) && ide_hwif_request_regions(hwif)) {
+			printk(KERN_ERR "%s: ports already in use, "
+					"skipping probe\n", hwif->name);
+			continue;
+		}
+
+		if (ide_probe_port(hwif) < 0) {
+			ide_hwif_release_regions(hwif);
+			continue;
+		}
+
+		hwif->present =3D 1;
+
+		if (hwif->chipset !=3D ide_4drives || !hwif->mate ||
+		    !hwif->mate->present)
+			ide_register_port(hwif);
+
+		ide_port_tune_devices(hwif);
 	}
=20
 	for (i =3D 0; i < MAX_HWIFS; i++) {
@@ -1353,9 +1327,13 @@ int ide_device_add_all(u8 *idx)
=20
 		hwif =3D &ide_hwifs[idx[i]];
=20
+		if (!hwif->present)
+			continue;
+
 		if (hwif_init(hwif) =3D=3D 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
 					 "interface\n", hwif->name);
+			hwif->present =3D 0;
 			rc =3D -1;
 			continue;
 		}
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index aa663e7..00c249c 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/ide-proc.c	Version 1.05	Mar 05, 2003
- *
  *  Copyright (C) 1997-1998	Mark Lord
  *  Copyright (C) 2003		Red Hat <alan@redhat.com>
  *
diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
index 7ffa332..93d2e41 100644
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -81,7 +81,7 @@ static int __init ide_scan_pcidev(struct pci_dev *dev=
)
  *	module ordering not traditionally ordered.
  */
=20
-int __init ide_scan_pcibus(void)
+static int __init ide_scan_pcibus(void)
 {
 	struct pci_dev *dev =3D NULL;
 	struct pci_driver *d;
@@ -113,9 +113,4 @@ int __init ide_scan_pcibus(void)
 	return 0;
 }
=20
-static int __init ide_scan_pci(void)
-{
-	return ide_scan_pcibus();
-}
-
-module_init(ide_scan_pci);
+module_init(ide_scan_pcibus);
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index d71a584..5aef63a 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1,7 +1,6 @@
 /*
- * linux/drivers/ide/ide-tape.c		Version 1.19	Nov, 2003
- *
- * Copyright (C) 1995 - 1999 Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 1995-1999  Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2003-2005  Bartlomiej Zolnierkiewicz
  *
  * $Header$
  *
@@ -4291,9 +4290,6 @@ static int idetape_identify_device (ide_drive_t *=
drive)
 {
 	struct idetape_id_gcw gcw;
 	struct hd_driveid *id =3D drive->id;
-#if IDETAPE_DEBUG_INFO
-	unsigned short mask,i;
-#endif /* IDETAPE_DEBUG_INFO */
=20
 	if (drive->id_read =3D=3D 0)
 		return 1;
@@ -4333,62 +4329,6 @@ static int idetape_identify_device (ide_drive_t =
*drive)
 		case 1: printk("16 bytes\n");break;
 		default: printk("Reserved\n");break;
 	}
-	printk(KERN_INFO "ide-tape: Model: %.40s\n",id->model);
-	printk(KERN_INFO "ide-tape: Firmware Revision: %.8s\n",id->fw_rev);
-	printk(KERN_INFO "ide-tape: Serial Number: %.20s\n",id->serial_no);
-	printk(KERN_INFO "ide-tape: Write buffer size: %d bytes\n",id->buf_si=
ze*512);
-	printk(KERN_INFO "ide-tape: DMA: %s",id->capability & 0x01 ? "Yes\n":=
"No\n");
-	printk(KERN_INFO "ide-tape: LBA: %s",id->capability & 0x02 ? "Yes\n":=
"No\n");
-	printk(KERN_INFO "ide-tape: IORDY can be disabled: %s",id->capability=
 & 0x04 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: IORDY supported: %s",id->capability & 0x0=
8 ? "Yes\n":"Unknown\n");
-	printk(KERN_INFO "ide-tape: ATAPI overlap supported: %s",id->capabili=
ty & 0x20 ? "Yes\n":"No\n");
-	printk(KERN_INFO "ide-tape: PIO Cycle Timing Category: %d\n",id->tPIO=
);
-	printk(KERN_INFO "ide-tape: DMA Cycle Timing Category: %d\n",id->tDMA=
);
-	printk(KERN_INFO "ide-tape: Single Word DMA supported modes: ");
-	for (i=3D0,mask=3D1;i<8;i++,mask=3Dmask << 1) {
-		if (id->dma_1word & mask)
-			printk("%d ",i);
-		if (id->dma_1word & (mask << 8))
-			printk("(active) ");
-	}
-	printk("\n");
-	printk(KERN_INFO "ide-tape: Multi Word DMA supported modes: ");
-	for (i=3D0,mask=3D1;i<8;i++,mask=3Dmask << 1) {
-		if (id->dma_mword & mask)
-			printk("%d ",i);
-		if (id->dma_mword & (mask << 8))
-			printk("(active) ");
-	}
-	printk("\n");
-	if (id->field_valid & 0x0002) {
-		printk(KERN_INFO "ide-tape: Enhanced PIO Modes: %s\n",
-			id->eide_pio_modes & 1 ? "Mode 3":"None");
-		printk(KERN_INFO "ide-tape: Minimum Multi-word DMA cycle per word: "=
);
-		if (id->eide_dma_min =3D=3D 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_dma_min);
-
-		printk(KERN_INFO "ide-tape: Manufacturer\'s Recommended Multi-word c=
ycle: ");
-		if (id->eide_dma_time =3D=3D 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_dma_time);
-
-		printk(KERN_INFO "ide-tape: Minimum PIO cycle without IORDY: ");
-		if (id->eide_pio =3D=3D 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_pio);
-
-		printk(KERN_INFO "ide-tape: Minimum PIO cycle with IORDY: ");
-		if (id->eide_pio_iordy =3D=3D 0)
-			printk("Not supported\n");
-		else
-			printk("%d ns\n",id->eide_pio_iordy);
-	=09
-	} else
-		printk(KERN_INFO "ide-tape: According to the device, fields 64-70 ar=
e not valid.\n");
 #endif /* IDETAPE_DEBUG_INFO */
=20
 	/* Check that we can support this device */
@@ -4591,19 +4531,11 @@ static void idetape_setup (ide_drive_t *drive, =
idetape_tape_t *tape, int minor)
=20
 	spin_lock_init(&tape->spinlock);
 	drive->dsc_overlap =3D 1;
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	if (HWIF(drive)->pci_dev !=3D NULL) {
-		/*
-		 * These two ide-pci host adapters appear to need DSC overlap disabl=
ed.
-		 * This probably needs further analysis.
-		 */
-		if ((HWIF(drive)->pci_dev->device =3D=3D PCI_DEVICE_ID_ARTOP_ATP850U=
=46) ||
-		    (HWIF(drive)->pci_dev->device =3D=3D PCI_DEVICE_ID_TTI_HPT343)) =
{
-			printk(KERN_INFO "ide-tape: %s: disabling DSC overlap\n", tape->nam=
e);
-		    	drive->dsc_overlap =3D 0;
-		}
+	if (drive->hwif->host_flags & IDE_HFLAG_NO_DSC) {
+		printk(KERN_INFO "ide-tape: %s: disabling DSC overlap\n",
+				 tape->name);
+		drive->dsc_overlap =3D 0;
 	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
 	/* Seagate Travan drives do not support DSC overlap. */
 	if (strstr(drive->id->model, "Seagate STT3401"))
 		drive->dsc_overlap =3D 0;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 5eb6fa1..16a9a58 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -1,11 +1,9 @@
 /*
- * linux/drivers/ide/ide-taskfile.c	Version 0.38	March 05, 2003
- *
- *  Copyright (C) 2000-2002	Michael Cornwell <cornwell@acm.org>
- *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2001-2002	Klaus Smolin
+ *  Copyright (C) 2000-2002	   Michael Cornwell <cornwell@acm.org>
+ *  Copyright (C) 2000-2002	   Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2001-2002	   Klaus Smolin
  *					IBM Storage Technology Division
- *  Copyright (C) 2003-2004	Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2003-2004, 2007  Bartlomiej Zolnierkiewicz
  *
  *  The big the bad and the ugly.
  */
@@ -260,7 +258,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_=
t *drive)
 	return ide_stopped;
 }
=20
-u8 wait_drive_not_busy(ide_drive_t *drive)
+static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	int retries;
diff --git a/drivers/ide/ide-timing.h b/drivers/ide/ide-timing.h
index daffbb9..adeda76 100644
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -2,8 +2,6 @@
 #define _IDE_TIMING_H
=20
 /*
- * $Id: ide-timing.h,v 1.6 2001/12/23 22:47:56 vojtech Exp $
- *
  *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
=20
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 97894ab..ab9ca2b 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1,7 +1,6 @@
 /*
- *  linux/drivers/ide/ide.c		Version 7.00beta2	Mar 05 2003
- *
- *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+ *  Copyright (C) 1994-1998	    Linus Torvalds & authors (see below)
+ *  Copyrifht (C) 2003-2005, 2007   Bartlomiej Zolnierkiewicz
  */
=20
 /*
@@ -46,7 +45,6 @@
  */
=20
 #define	REVISION	"Revision: 7.00alpha2"
-#define	VERSION		"Id: ide.c 7.00a2 20020906"
=20
 #define _IDE_C			/* Tell ide.h it's really us */
=20
@@ -242,22 +240,12 @@ static int ide_system_bus_speed(void)
 #define pci_default 0
 #endif /* CONFIG_PCI */
=20
-	if (!system_bus_speed) {
-		if (idebus_parameter) {
-			/* user supplied value */
-			system_bus_speed =3D idebus_parameter;
-		} else if (pci_dev_present(pci_default)) {
-			/* safe default value for PCI */
-			system_bus_speed =3D 33;
-		} else {
-			/* safe default value for VESA and PCI */
-			system_bus_speed =3D 50;
-		}
-		printk(KERN_INFO "ide: Assuming %dMHz system bus speed "
-			"for PIO modes%s\n", system_bus_speed,
-			idebus_parameter ? "" : "; override with idebus=3Dxx");
-	}
-	return system_bus_speed;
+	/* user supplied value */
+	if (idebus_parameter)
+		return idebus_parameter;
+
+	/* safe default value for PCI or VESA and PCI*/
+	return pci_dev_present(pci_default) ? 33 : 50;
 }
=20
 ide_hwif_t * ide_find_port(unsigned long base)
@@ -405,8 +393,9 @@ static void ide_hwif_restore(ide_hwif_t *hwif, ide_=
hwif_t *tmp_hwif)
 	hwif->chipset			=3D tmp_hwif->chipset;
 	hwif->hold			=3D tmp_hwif->hold;
=20
+	hwif->dev			=3D tmp_hwif->dev;
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	hwif->pci_dev			=3D tmp_hwif->pci_dev;
 	hwif->cds			=3D tmp_hwif->cds;
 #endif
=20
@@ -472,6 +461,41 @@ static void ide_hwif_restore(ide_hwif_t *hwif, ide=
_hwif_t *tmp_hwif)
 	hwif->hwif_data			=3D tmp_hwif->hwif_data;
 }
=20
+void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
+{
+	ide_hwgroup_t *hwgroup =3D hwif->hwgroup;
+
+	spin_lock_irq(&ide_lock);
+	/*
+	 * Remove us from the hwgroup, and free
+	 * the hwgroup if we were the only member
+	 */
+	if (hwif->next =3D=3D hwif) {
+		BUG_ON(hwgroup->hwif !=3D hwif);
+		kfree(hwgroup);
+	} else {
+		/* There is another interface in hwgroup.
+		 * Unlink us, and set hwgroup->drive and ->hwif to
+		 * something sane.
+		 */
+		ide_hwif_t *g =3D hwgroup->hwif;
+
+		while (g->next !=3D hwif)
+			g =3D g->next;
+		g->next =3D hwif->next;
+		if (hwgroup->hwif =3D=3D hwif) {
+			/* Chose a random hwif for hwgroup->hwif.
+			 * It's guaranteed that there are no drives
+			 * left in the hwgroup.
+			 */
+			BUG_ON(hwgroup->drive !=3D NULL);
+			hwgroup->hwif =3D g;
+		}
+		BUG_ON(hwgroup->hwif =3D=3D hwif);
+	}
+	spin_unlock_irq(&ide_lock);
+}
+
 /**
  *	ide_unregister		-	free an IDE interface
  *	@index: index of interface (will change soon to a pointer)
@@ -539,43 +563,8 @@ void ide_unregister(unsigned int index)
 	if (irq_count =3D=3D 1)
 		free_irq(hwif->irq, hwgroup);
=20
-	spin_lock_irq(&ide_lock);
-	/*
-	 * Note that we only release the standard ports,
-	 * and do not even try to handle any extra ports
-	 * allocated for weird IDE interface chipsets.
-	 */
-	ide_hwif_release_regions(hwif);
-
-	/*
-	 * Remove us from the hwgroup, and free
-	 * the hwgroup if we were the only member
-	 */
-	if (hwif->next =3D=3D hwif) {
-		BUG_ON(hwgroup->hwif !=3D hwif);
-		kfree(hwgroup);
-	} else {
-		/* There is another interface in hwgroup.
-		 * Unlink us, and set hwgroup->drive and ->hwif to
-		 * something sane.
-		 */
-		g =3D hwgroup->hwif;
-		while (g->next !=3D hwif)
-			g =3D g->next;
-		g->next =3D hwif->next;
-		if (hwgroup->hwif =3D=3D hwif) {
-			/* Chose a random hwif for hwgroup->hwif.
-			 * It's guaranteed that there are no drives
-			 * left in the hwgroup.
-			 */
-			BUG_ON(hwgroup->drive !=3D NULL);
-			hwgroup->hwif =3D g;
-		}
-		BUG_ON(hwgroup->hwif =3D=3D hwif);
-	}
+	ide_remove_port_from_hwgroup(hwif);
=20
-	/* More messed up locking ... */
-	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
 	wait_for_completion(&hwif->gendev_rel_comp);
=20
@@ -601,6 +590,13 @@ void ide_unregister(unsigned int index)
 		hwif->extra_ports =3D 0;
 	}
=20
+	/*
+	 * Note that we only release the standard ports,
+	 * and do not even try to handle any extra ports
+	 * allocated for weird IDE interface chipsets.
+	 */
+	ide_hwif_release_regions(hwif);
+
 	/* copy original settings */
 	tmp_hwif =3D *hwif;
=20
@@ -913,7 +909,7 @@ static int set_unmaskirq(ide_drive_t *drive, int ar=
g)
=20
 int system_bus_clock (void)
 {
-	return((int) ((!system_bus_speed) ? ide_system_bus_speed() : system_b=
us_speed ));
+	return system_bus_speed;
 }
=20
 EXPORT_SYMBOL(system_bus_clock);
@@ -1668,6 +1664,10 @@ static int __init ide_init(void)
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n"=
);
 	system_bus_speed =3D ide_system_bus_speed();
=20
+	printk(KERN_INFO "ide: Assuming %dMHz system bus speed "
+			 "for PIO modes%s\n", system_bus_speed,
+			idebus_parameter ? "" : "; override with idebus=3Dxx");
+
 	ret =3D bus_register(&ide_bus_type);
 	if (ret < 0) {
 		printk(KERN_WARNING "IDE: bus_register error: %d\n", ret);
diff --git a/drivers/ide/legacy/ali14xx.c b/drivers/ide/legacy/ali14xx.=
c
index 5ec0be4..e3ea209 100644
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/legacy/ali14xx.c		Version 0.03	Feb 09, 1996
- *
  *  Copyright (C) 1996  Linus Torvalds & author (see below)
  */
=20
diff --git a/drivers/ide/legacy/buddha.c b/drivers/ide/legacy/buddha.c
index 74d28e0..dd3d198 100644
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/legacy/buddha.c -- Amiga Buddha, Catweasel and X=
-Surf IDE Driver
+ *  Amiga Buddha, Catweasel and X-Surf IDE Driver
  *
  *	Copyright (C) 1997, 2001 by Geert Uytterhoeven and others
  *
diff --git a/drivers/ide/legacy/dtc2278.c b/drivers/ide/legacy/dtc2278.=
c
index 13eee6d..611c970 100644
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/legacy/dtc2278.c		Version 0.02	Feb 10, 1996
- *
  *  Copyright (C) 1996  Linus Torvalds & author (see below)
  */
=20
diff --git a/drivers/ide/legacy/falconide.c b/drivers/ide/legacy/falcon=
ide.c
index 2860956..c9bd6bf 100644
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/legacy/falconide.c -- Atari Falcon IDE Driver
+ *  Atari Falcon IDE Driver
  *
  *     Created 12 Jul 1997 by Geert Uytterhoeven
  *
@@ -66,6 +66,7 @@ static int __init falconide_init(void)
 {
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
+	ide_hwif_t *hwif;
=20
 	printk(KERN_INFO "ide: Falcon IDE controller\n");
=20
diff --git a/drivers/ide/legacy/gayle.c b/drivers/ide/legacy/gayle.c
index 492fa04..f67c51a 100644
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/legacy/gayle.c -- Amiga Gayle IDE Driver
+ *  Amiga Gayle IDE Driver
  *
  *     Created 9 Jul 1997 by Geert Uytterhoeven
  *
diff --git a/drivers/ide/legacy/ht6560b.c b/drivers/ide/legacy/ht6560b.=
c
index 8da5031..57bc15c 100644
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/legacy/ht6560b.c		Version 0.07	Feb  1, 2000
- *
  *  Copyright (C) 1995-2000  Linus Torvalds & author (see below)
  */
=20
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index f4ea15b..3bd2967 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -2,8 +2,6 @@
=20
     A driver for PCMCIA IDE/ATA disk cards
=20
-    ide-cs.c 1.3 2002/10/26 05:45:31
-
     The contents of this file are subject to the Mozilla Public
     License Version 1.1 (the "License"); you may not use this file
     except in compliance with the License. You may obtain a copy of
diff --git a/drivers/ide/legacy/ide_platform.c b/drivers/ide/legacy/ide=
_platform.c
index 69a0fb0..7c3231a 100644
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -21,13 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
=20
-static struct {
-	void __iomem *plat_ide_mapbase;
-	void __iomem *plat_ide_alt_mapbase;
-	ide_hwif_t *hwif;
-	int index;
-} hwif_prop;
-
 static void __devinit plat_ide_setup_ports(hw_regs_t *hw,
 					   void __iomem *base,
 					   void __iomem *ctrl,
@@ -54,6 +47,7 @@ static void __devinit plat_ide_setup_ports(hw_regs_t =
*hw,
 static int __devinit plat_ide_probe(struct platform_device *pdev)
 {
 	struct resource *res_base, *res_alt, *res_irq;
+	void __iomem *base, *alt_base;
 	ide_hwif_t *hwif;
 	struct pata_platform_info *pdata;
 	u8 idx[4] =3D { 0xff, 0xff, 0xff, 0xff };
@@ -84,27 +78,25 @@ static int __devinit plat_ide_probe(struct platform=
_device *pdev)
 	}
=20
 	if (mmio) {
-		hwif_prop.plat_ide_mapbase =3D devm_ioremap(&pdev->dev,
+		base =3D devm_ioremap(&pdev->dev,
 			res_base->start, res_base->end - res_base->start + 1);
-		hwif_prop.plat_ide_alt_mapbase =3D devm_ioremap(&pdev->dev,
+		alt_base =3D devm_ioremap(&pdev->dev,
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	} else {
-		hwif_prop.plat_ide_mapbase =3D devm_ioport_map(&pdev->dev,
+		base =3D devm_ioport_map(&pdev->dev,
 			res_base->start, res_base->end - res_base->start + 1);
-		hwif_prop.plat_ide_alt_mapbase =3D devm_ioport_map(&pdev->dev,
+		alt_base =3D devm_ioport_map(&pdev->dev,
 			res_alt->start, res_alt->end - res_alt->start + 1);
 	}
=20
-	hwif =3D ide_find_port((unsigned long)hwif_prop.plat_ide_mapbase);
+	hwif =3D ide_find_port((unsigned long)base);
 	if (!hwif) {
 		ret =3D -ENODEV;
 		goto out;
 	}
=20
 	memset(&hw, 0, sizeof(hw));
-	plat_ide_setup_ports(&hw, hwif_prop.plat_ide_mapbase,
-			     hwif_prop.plat_ide_alt_mapbase,
-			     pdata, res_irq->start);
+	plat_ide_setup_ports(&hw, base, alt_base, pdata, res_irq->start);
 	hw.dev =3D &pdev->dev;
=20
 	ide_init_port_hw(hwif, &hw);
@@ -114,9 +106,6 @@ static int __devinit plat_ide_probe(struct platform=
_device *pdev)
 		default_hwif_mmiops(hwif);
 	}
=20
-	hwif_prop.hwif =3D hwif;
-	hwif_prop.index =3D hwif->index;
-
 	idx[0] =3D hwif->index;
=20
 	ide_device_add(idx);
@@ -133,14 +122,7 @@ static int __devexit plat_ide_remove(struct platfo=
rm_device *pdev)
 {
 	ide_hwif_t *hwif =3D pdev->dev.driver_data;
=20
-	if (hwif !=3D hwif_prop.hwif) {
-		dev_printk(KERN_DEBUG, &pdev->dev, "%s: hwif value error",
-		           pdev->name);
-	} else {
-		ide_unregister(hwif_prop.index);
-		hwif_prop.index =3D 0;
-		hwif_prop.hwif =3D NULL;
-	}
+	ide_unregister(hwif->index);
=20
 	return 0;
 }
diff --git a/drivers/ide/legacy/macide.c b/drivers/ide/legacy/macide.c
index 782d4c7..c54d07f 100644
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/legacy/macide.c -- Macintosh IDE Driver
+ *  Macintosh IDE Driver
  *
  *     Copyright (C) 1998 by Michael Schmitz
  *
diff --git a/drivers/ide/legacy/q40ide.c b/drivers/ide/legacy/q40ide.c
index f532973..a9c6b06 100644
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/legacy/q40ide.c -- Q40 I/O port IDE Driver
+ *  Q40 I/O port IDE Driver
  *
  *     (c) Richard Zidlicky
  *
diff --git a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
index 2bac4c1..37534bb 100644
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/legacy/qd65xx.c		Version 0.07	Sep 30, 2001
- *
  *  Copyright (C) 1996-2001  Linus Torvalds & author (see below)
  */
=20
diff --git a/drivers/ide/legacy/qd65xx.h b/drivers/ide/legacy/qd65xx.h
index 633a424..28dd50a 100644
--- a/drivers/ide/legacy/qd65xx.h
+++ b/drivers/ide/legacy/qd65xx.h
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/legacy/qd65xx.h
- *
  * Copyright (c) 2000	Linus Torvalds & authors
  */
=20
diff --git a/drivers/ide/legacy/umc8672.c b/drivers/ide/legacy/umc8672.=
c
index a1ae1ae..26f38ce 100644
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/legacy/umc8672.c		Version 0.05	Jul 31, 1996
- *
  *  Copyright (C) 1995-1996  Linus Torvalds & author (see below)
  */
=20
diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-id=
e.c
index 2d3e511..cd42b30 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/mips/au1xxx-ide.c  version 01.30.00        Aug. 0=
2 2005
- *
  * BRIEF MODULE DESCRIPTION
  * AMD Alchemy Au1xxx IDE interface routines over the Static Bus
  *
@@ -50,7 +48,6 @@
 #include <asm/mach-au1x00/au1xxx_ide.h>
=20
 #define DRV_NAME	"au1200-ide"
-#define DRV_VERSION	"1.0"
 #define DRV_AUTHOR	"Enrico Walther <enrico.walther@amd.com> / Pete Pop=
ov <ppopov@embeddedalley.com>"
=20
 /* enable the burstmode in the dbdma */
@@ -209,24 +206,6 @@ static void auide_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
  */
=20
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-
-static int auide_build_sglist(ide_drive_t *drive,  struct request *rq)
-{
-	ide_hwif_t *hwif =3D drive->hwif;
-	_auide_hwif *ahwif =3D (_auide_hwif*)hwif->hwif_data;
-	struct scatterlist *sg =3D hwif->sg_table;
-
-	ide_map_sg(drive, rq);
-
-	if (rq_data_dir(rq) =3D=3D READ)
-		hwif->sg_dma_direction =3D DMA_FROM_DEVICE;
-	else
-		hwif->sg_dma_direction =3D DMA_TO_DEVICE;
-
-	return dma_map_sg(ahwif->dev, sg, hwif->sg_nents,
-			  hwif->sg_dma_direction);
-}
-
 static int auide_build_dmatable(ide_drive_t *drive)
 {
 	int i, iswrite, count =3D 0;
@@ -241,8 +220,7 @@ static int auide_build_dmatable(ide_drive_t *drive)
 	/* Save for interrupt context */
 	ahwif->drive =3D drive;
=20
-	/* Build sglist */
-	hwif->sg_nents =3D i =3D auide_build_sglist(drive, rq);
+	hwif->sg_nents =3D i =3D ide_build_sglist(drive, rq);
=20
 	if (!i)
 		return 0;
@@ -300,10 +278,7 @@ static int auide_build_dmatable(ide_drive_t *drive=
)
 		return 1;
=20
  use_pio_instead:
-	dma_unmap_sg(ahwif->dev,
-		     hwif->sg_table,
-		     hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
=20
 	return 0; /* revert to PIO for this request */
 }
@@ -311,11 +286,9 @@ static int auide_build_dmatable(ide_drive_t *drive=
)
 static int auide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	_auide_hwif *ahwif =3D (_auide_hwif*)hwif->hwif_data;
=20
 	if (hwif->sg_nents) {
-		dma_unmap_sg(ahwif->dev, hwif->sg_table, hwif->sg_nents,
-			     hwif->sg_dma_direction);
+		ide_destroy_dmatable(drive);
 		hwif->sg_nents =3D 0;
 	}
=20
@@ -504,7 +477,7 @@ static int auide_ddma_init(_auide_hwif *auide) {
 	auide->rx_desc_head =3D (void*)au1xxx_dbdma_ring_alloc(auide->rx_chan=
,
 							     NUM_DESCRIPTORS);
 =20
-	hwif->dmatable_cpu =3D dma_alloc_coherent(auide->dev,
+	hwif->dmatable_cpu =3D dma_alloc_coherent(hwif->dev,
 						PRD_ENTRIES * PRD_BYTES,        /* 1 Page */
 						&hwif->dmatable_dma, GFP_KERNEL);
 =09
@@ -592,9 +565,6 @@ static int au_ide_probe(struct device *dev)
 #endif
=20
 	memset(&auide_hwif, 0, sizeof(_auide_hwif));
-	auide_hwif.dev                  =3D 0;
-
-	ahwif->dev =3D dev;
 	ahwif->irq =3D platform_get_irq(pdev, 0);
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -629,10 +599,13 @@ static int au_ide_probe(struct device *dev)
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
 	hw.irq =3D ahwif->irq;
+	hw.dev =3D dev;
 	hw.chipset =3D ide_au1xxx;
=20
 	ide_init_port_hw(hwif, &hw);
=20
+	hwif->dev =3D dev;
+
 	hwif->ultra_mask                =3D 0x0;  /* Disable Ultra DMA */
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 	hwif->mwdma_mask                =3D 0x07; /* Multimode-2 DMA  */
@@ -715,7 +688,7 @@ static int au_ide_remove(struct device *dev)
 	ide_hwif_t *hwif =3D dev_get_drvdata(dev);
 	_auide_hwif *ahwif =3D &auide_hwif;
=20
-	ide_unregister(hwif - ide_hwifs);
+	ide_unregister(hwif->index);
=20
 	iounmap((void *)ahwif->regbase);
=20
diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
index 7f4d185..824df78 100644
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/aec62xx.c		Version 0.27	Sep 16, 2007
- *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
  *
@@ -90,7 +88,7 @@ static u8 pci_bus_clock_list_ultra (u8 speed, struct =
chipset_bus_clock_list_entr
 static void aec6210_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u16 d_conf		=3D 0;
 	u8 ultra =3D 0, ultra_conf =3D 0;
 	u8 tmp0 =3D 0, tmp1 =3D 0, tmp2 =3D 0;
@@ -116,7 +114,7 @@ static void aec6210_set_mode(ide_drive_t *drive, co=
nst u8 speed)
 static void aec6260_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 unit		=3D (drive->select.b.unit & 0x01);
 	u8 tmp1 =3D 0, tmp2 =3D 0;
 	u8 ultra =3D 0, drive_conf =3D 0, ultra_conf =3D 0;
@@ -170,7 +168,7 @@ static unsigned int __devinit init_chipset_aec62xx(=
struct pci_dev *dev, const ch
=20
 static void __devinit init_hwif_aec62xx(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
=20
 	hwif->set_pio_mode =3D &aec_set_pio_mode;
=20
@@ -188,7 +186,7 @@ static void __devinit init_hwif_aec62xx(ide_hwif_t =
*hwif)
 	if (hwif->cbl !=3D ATA_CBL_PATA40_SHORT) {
 		u8 ata66 =3D 0, mask =3D hwif->channel ? 0x02 : 0x01;
=20
-		pci_read_config_byte(hwif->pci_dev, 0x49, &ata66);
+		pci_read_config_byte(dev, 0x49, &ata66);
=20
 		hwif->cbl =3D (ata66 & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 	}
@@ -202,6 +200,7 @@ static const struct ide_port_info aec62xx_chipsets[=
] __devinitdata =3D {
 		.enablebits	=3D {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	=3D IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_NO_DSC |
 				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	=3D ATA_PIO4,
diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index 49aa82e..130cc6e 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.29	Sep 16 2007
- *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
  *  Copyright (C) 1999-2000 CJ, cjtsai@ali.com.tw, Maintainer
@@ -293,7 +291,7 @@ static int ali_get_info (char *buffer, char **addr,=
 off_t offset, int count)
 static void ali_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	int s_time, a_time, c_time;
 	u8 s_clc, a_clc, r_clc;
 	unsigned long flags;
@@ -396,7 +394,7 @@ static u8 ali_udma_filter(ide_drive_t *drive)
 static void ali_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 speed1		=3D speed;
 	u8 unit			=3D (drive->select.b.unit & 0x01);
 	u8 tmpbyte		=3D 0x00;
@@ -625,7 +623,7 @@ static int ali_cable_override(struct pci_dev *pdev)
=20
 static u8 __devinit ata66_ali15x3(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned long flags;
 	u8 cbl =3D ATA_CBL_PATA40, tmpbyte;
=20
@@ -688,12 +686,13 @@ static void __devinit init_hwif_common_ali15x3 (i=
de_hwif_t *hwif)
=20
 static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 ideic, inmir;
 	s8 irq_routing_table[] =3D { -1,  9, 3, 10, 4,  5, 7,  6,
 				      1, 11, 0, 12, 0, 14, 0, 15 };
 	int irq =3D -1;
=20
-	if (hwif->pci_dev->device =3D=3D PCI_DEVICE_ID_AL_M5229)
+	if (dev->device =3D=3D PCI_DEVICE_ID_AL_M5229)
 		hwif->irq =3D hwif->channel ? 15 : 14;
=20
 	if (isa_dev) {
@@ -745,7 +744,7 @@ static void __devinit init_dma_ali15x3 (ide_hwif_t =
*hwif, unsigned long dmabase)
 		return;
 	if (!hwif->channel)
 		outb(inb(dmabase + 2) & 0x60, dmabase + 2);
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
=20
 static const struct ide_port_info ali15x3_chipset __devinitdata =3D {
@@ -775,7 +774,7 @@ static int __devinit alim15x3_init_one(struct pci_d=
ev *dev, const struct pci_dev
 	};
=20
 	struct ide_port_info d =3D ali15x3_chipset;
-	u8 rev =3D dev->revision;
+	u8 rev =3D dev->revision, idx =3D id->driver_data;
=20
 	if (pci_dev_present(ati_rs100))
 		printk(KERN_WARNING "alim15x3: ATI Radeon IGP Northbridge is not yet=
 fully tested.\n");
@@ -798,6 +797,9 @@ static int __devinit alim15x3_init_one(struct pci_d=
ev *dev, const struct pci_dev
 			d.udma_mask =3D ATA_UDMA6;
 	}
=20
+	if (idx =3D=3D 0)
+		d.host_flags |=3D IDE_HFLAG_CLEAR_SIMPLEX;
+
 #if defined(CONFIG_SPARC64)
 	d.init_hwif =3D init_hwif_common_ali15x3;
 #endif /* CONFIG_SPARC64 */
@@ -807,7 +809,7 @@ static int __devinit alim15x3_init_one(struct pci_d=
ev *dev, const struct pci_dev
=20
 static const struct pci_device_id alim15x3_pci_tbl[] =3D {
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5229), 0 },
-	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), 0 },
+	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), 1 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
diff --git a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
index cee51fd..8c52bc9 100644
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,6 +1,4 @@
 /*
- * Version 2.24
- *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
  *
@@ -28,81 +26,46 @@
=20
 #include "ide-timing.h"
=20
-#define AMD_IDE_CONFIG		(0x01 + amd_config->base)
-#define AMD_CABLE_DETECT	(0x02 + amd_config->base)
-#define AMD_DRIVE_TIMING	(0x08 + amd_config->base)
-#define AMD_8BIT_TIMING		(0x0e + amd_config->base)
-#define AMD_ADDRESS_SETUP	(0x0c + amd_config->base)
-#define AMD_UDMA_TIMING		(0x10 + amd_config->base)
-
-#define AMD_CHECK_SWDMA		0x08
-#define AMD_BAD_SWDMA		0x10
-#define AMD_BAD_FIFO		0x20
-#define AMD_CHECK_SERENADE	0x40
-
-/*
- * AMD SouthBridge chips.
- */
-
-static struct amd_ide_chip {
-	unsigned short id;
-	u8 base;
-	u8 udma_mask;
-	u8 flags;
-} amd_ide_chips[] =3D {
-	{ PCI_DEVICE_ID_AMD_COBRA_7401,		 0x40, ATA_UDMA2, AMD_BAD_SWDMA },
-	{ PCI_DEVICE_ID_AMD_VIPER_7409,		 0x40, ATA_UDMA4, AMD_CHECK_SWDMA },
-	{ PCI_DEVICE_ID_AMD_VIPER_7411,		 0x40, ATA_UDMA5, AMD_BAD_FIFO },
-	{ PCI_DEVICE_ID_AMD_OPUS_7441,		 0x40, ATA_UDMA5, },
-	{ PCI_DEVICE_ID_AMD_8111_IDE,		 0x40, ATA_UDMA6, AMD_CHECK_SERENADE }=
,
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	 0x50, ATA_UDMA5, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE, 0x50, ATA_UDMA6, },
-	{ PCI_DEVICE_ID_AMD_CS5536_IDE,		 0x40, ATA_UDMA5, },
-	{ 0 }
+enum {
+	AMD_IDE_CONFIG		=3D 0x41,
+	AMD_CABLE_DETECT	=3D 0x42,
+	AMD_DRIVE_TIMING	=3D 0x48,
+	AMD_8BIT_TIMING		=3D 0x4e,
+	AMD_ADDRESS_SETUP	=3D 0x4c,
+	AMD_UDMA_TIMING		=3D 0x50,
 };
=20
-static struct amd_ide_chip *amd_config;
-static const struct ide_port_info *amd_chipset;
 static unsigned int amd_80w;
 static unsigned int amd_clock;
=20
 static char *amd_dma[] =3D { "16", "25", "33", "44", "66", "100", "133=
" };
 static unsigned char amd_cyc2udma[] =3D { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3=
, 3, 3, 3, 3, 3, 7 };
=20
+static inline u8 amd_offset(struct pci_dev *dev)
+{
+	return (dev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA) ? 0x10 : 0;
+}
+
 /*
  * amd_set_speed() writes timing values to the chipset registers
  */
=20
-static void amd_set_speed(struct pci_dev *dev, unsigned char dn, struc=
t ide_timing *timing)
+static void amd_set_speed(struct pci_dev *dev, u8 dn, u8 udma_mask,
+			  struct ide_timing *timing)
 {
-	unsigned char t;
+	u8 t =3D 0, offset =3D amd_offset(dev);
=20
-	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
+	pci_read_config_byte(dev, AMD_ADDRESS_SETUP + offset, &t);
 	t =3D (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1)=
 << ((3 - dn) << 1));
-	pci_write_config_byte(dev, AMD_ADDRESS_SETUP, t);
+	pci_write_config_byte(dev, AMD_ADDRESS_SETUP + offset, t);
=20
-	pci_write_config_byte(dev, AMD_8BIT_TIMING + (1 - (dn >> 1)),
+	pci_write_config_byte(dev, AMD_8BIT_TIMING + offset + (1 - (dn >> 1))=
,
 		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) =
- 1));
=20
-	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
+	pci_write_config_byte(dev, AMD_DRIVE_TIMING + offset + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 1=
6) - 1));
=20
-	switch (amd_config->udma_mask) {
+	switch (udma_mask) {
 	case ATA_UDMA2: t =3D timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5)=
 - 2)) : 0x03; break;
 	case ATA_UDMA4: t =3D timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing-=
>udma, 2, 10)]) : 0x03; break;
 	case ATA_UDMA5: t =3D timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing-=
>udma, 1, 10)]) : 0x03; break;
@@ -110,7 +73,7 @@ static void amd_set_speed(struct pci_dev *dev, unsig=
ned char dn, struct ide_timi
 	default: return;
 	}
=20
-	pci_write_config_byte(dev, AMD_UDMA_TIMING + (3 - dn), t);
+	pci_write_config_byte(dev, AMD_UDMA_TIMING + offset + (3 - dn), t);
 }
=20
 /*
@@ -120,12 +83,15 @@ static void amd_set_speed(struct pci_dev *dev, uns=
igned char dn, struct ide_timi
=20
 static void amd_set_drive(ide_drive_t *drive, const u8 speed)
 {
-	ide_drive_t *peer =3D HWIF(drive)->drives + (~drive->dn & 1);
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+	ide_drive_t *peer =3D hwif->drives + (~drive->dn & 1);
 	struct ide_timing t, p;
 	int T, UT;
+	u8 udma_mask =3D hwif->ultra_mask;
=20
 	T =3D 1000000000 / amd_clock;
-	UT =3D (amd_config->udma_mask =3D=3D ATA_UDMA2) ? T : (T / 2);
+	UT =3D (udma_mask =3D=3D ATA_UDMA2) ? T : (T / 2);
=20
 	ide_timing_compute(drive, speed, &t, T, UT);
=20
@@ -137,7 +103,7 @@ static void amd_set_drive(ide_drive_t *drive, const=
 u8 speed)
 	if (speed =3D=3D XFER_UDMA_5 && amd_clock <=3D 33333) t.udma =3D 1;
 	if (speed =3D=3D XFER_UDMA_6 && amd_clock <=3D 33333) t.udma =3D 15;
=20
-	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
+	amd_set_speed(dev, drive->dn, udma_mask, &t);
 }
=20
 /*
@@ -149,67 +115,68 @@ static void amd_set_pio_mode(ide_drive_t *drive, =
const u8 pio)
 	amd_set_drive(drive, XFER_PIO_0 + pio);
 }
=20
-/*
- * The initialization callback. Here we determine the IDE chip type
- * and initialize its drive independent registers.
- */
+static void __devinit amd7409_cable_detect(struct pci_dev *dev,
+					   const char *name)
+{
+	/* no host side cable detection */
+	amd_80w =3D 0x03;
+}
=20
-static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev=
, const char *name)
+static void __devinit amd7411_cable_detect(struct pci_dev *dev,
+					   const char *name)
 {
-	unsigned char t;
-	unsigned int u;
 	int i;
+	u32 u =3D 0;
+	u8 t =3D 0, offset =3D amd_offset(dev);
+
+	pci_read_config_byte(dev, AMD_CABLE_DETECT + offset, &t);
+	pci_read_config_dword(dev, AMD_UDMA_TIMING + offset, &u);
+	amd_80w =3D ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
+	for (i =3D 24; i >=3D 0; i -=3D 8)
+		if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
+			printk(KERN_WARNING "%s: BIOS didn't set cable bits "
+					    "correctly. Enabling workaround.\n",
+					    name);
+			amd_80w |=3D (1 << (1 - (i >> 4)));
+		}
+}
=20
 /*
- * Check for bad SWDMA.
+ * The initialization callback.  Initialize drive independent register=
s.
  */
=20
-	if (amd_config->flags & AMD_CHECK_SWDMA) {
-		if (dev->revision <=3D 7)
-			amd_config->flags |=3D AMD_BAD_SWDMA;
-	}
+static unsigned int __devinit init_chipset_amd74xx(struct pci_dev *dev=
,
+						   const char *name)
+{
+	u8 t =3D 0, offset =3D amd_offset(dev);
=20
 /*
  * Check 80-wire cable presence.
  */
=20
-	switch (amd_config->udma_mask) {
-
-		case ATA_UDMA6:
-		case ATA_UDMA5:
-			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
-			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
-			amd_80w =3D ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
-			for (i =3D 24; i >=3D 0; i -=3D 8)
-				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
-					printk(KERN_WARNING "%s: BIOS didn't set cable bits correctly. En=
abling workaround.\n",
-						amd_chipset->name);
-					amd_80w |=3D (1 << (1 - (i >> 4)));
-				}
-			break;
-
-		case ATA_UDMA4:
-			/* no host side cable detection */
-			amd_80w =3D 0x03;
-			break;
-	}
+	if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+	    dev->device =3D=3D PCI_DEVICE_ID_AMD_COBRA_7401)
+		; /* no UDMA > 2 */
+	else if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+		 dev->device =3D=3D PCI_DEVICE_ID_AMD_VIPER_7409)
+		amd7409_cable_detect(dev, name);
+	else
+		amd7411_cable_detect(dev, name);
=20
 /*
  * Take care of prefetch & postwrite.
  */
=20
-	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
-	pci_write_config_byte(dev, AMD_IDE_CONFIG,
-		(amd_config->flags & AMD_BAD_FIFO) ? (t & 0x0f) : (t | 0xf0));
-
-/*
- * Take care of incorrectly wired Serenade mainboards.
- */
-
-	if ((amd_config->flags & AMD_CHECK_SERENADE) &&
-		dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_AMD &&
-		dev->subsystem_device =3D=3D PCI_DEVICE_ID_AMD_SERENADE)
-			amd_config->udma_mask =3D ATA_UDMA5;
+	pci_read_config_byte(dev, AMD_IDE_CONFIG + offset, &t);
+	/*
+	 * Check for broken FIFO support.
+	 */
+	if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+	    dev->vendor =3D=3D PCI_DEVICE_ID_AMD_VIPER_7411)
+		t &=3D 0x0f;
+	else
+		t |=3D 0xf0;
+	pci_write_config_byte(dev, AMD_IDE_CONFIG + offset, t);
=20
 /*
  * Determine the system bus clock.
@@ -225,25 +192,19 @@ static unsigned int __devinit init_chipset_amd74x=
x(struct pci_dev *dev, const ch
=20
 	if (amd_clock < 20000 || amd_clock > 50000) {
 		printk(KERN_WARNING "%s: User given PCI clock speed impossible (%d),=
 using 33 MHz instead.\n",
-			amd_chipset->name, amd_clock);
+				    name, amd_clock);
 		amd_clock =3D 33333;
 	}
=20
-/*
- * Print the boot message.
- */
-
-	printk(KERN_INFO "%s: %s (rev %02x) UDMA%s controller\n",
-		amd_chipset->name, pci_name(dev), dev->revision,
-		amd_dma[fls(amd_config->udma_mask) - 1]);
-
 	return dev->irq;
 }
=20
 static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	if (hwif->irq =3D=3D 0) /* 0 is bogus but will do for now */
-		hwif->irq =3D pci_get_legacy_ide_irq(hwif->pci_dev, hwif->channel);
+		hwif->irq =3D pci_get_legacy_ide_irq(dev, hwif->channel);
=20
 	hwif->set_pio_mode =3D &amd_set_pio_mode;
 	hwif->set_dma_mode =3D &amd_set_drive;
@@ -251,10 +212,6 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t=
 *hwif)
 	if (!hwif->dma_base)
 		return;
=20
-	hwif->ultra_mask =3D amd_config->udma_mask;
-	if (amd_config->flags & AMD_BAD_SWDMA)
-		hwif->swdma_mask =3D 0x00;
-
 	if (hwif->cbl !=3D ATA_CBL_PATA40_SHORT) {
 		if ((amd_80w >> hwif->channel) & 1)
 			hwif->cbl =3D ATA_CBL_PATA80;
@@ -272,7 +229,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t =
*hwif)
 	 IDE_HFLAG_UNMASK_IRQS | \
 	 IDE_HFLAG_BOOTABLE)
=20
-#define DECLARE_AMD_DEV(name_str)					\
+#define DECLARE_AMD_DEV(name_str, swdma, udma)				\
 	{								\
 		.name		=3D name_str,				\
 		.init_chipset	=3D init_chipset_amd74xx,			\
@@ -280,11 +237,12 @@ static void __devinit init_hwif_amd74xx(ide_hwif_=
t *hwif)
 		.enablebits	=3D {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
 		.host_flags	=3D IDE_HFLAGS_AMD,			\
 		.pio_mask	=3D ATA_PIO5,				\
-		.swdma_mask	=3D ATA_SWDMA2,				\
+		.swdma_mask	=3D swdma,				\
 		.mwdma_mask	=3D ATA_MWDMA2,				\
+		.udma_mask	=3D udma,					\
 	}
=20
-#define DECLARE_NV_DEV(name_str)					\
+#define DECLARE_NV_DEV(name_str, udma)					\
 	{								\
 		.name		=3D name_str,				\
 		.init_chipset	=3D init_chipset_amd74xx,			\
@@ -294,45 +252,62 @@ static void __devinit init_hwif_amd74xx(ide_hwif_=
t *hwif)
 		.pio_mask	=3D ATA_PIO5,				\
 		.swdma_mask	=3D ATA_SWDMA2,				\
 		.mwdma_mask	=3D ATA_MWDMA2,				\
+		.udma_mask	=3D udma,					\
 	}
=20
 static const struct ide_port_info amd74xx_chipsets[] __devinitdata =3D=
 {
-	/*  0 */ DECLARE_AMD_DEV("AMD7401"),
-	/*  1 */ DECLARE_AMD_DEV("AMD7409"),
-	/*  2 */ DECLARE_AMD_DEV("AMD7411"),
-	/*  3 */ DECLARE_AMD_DEV("AMD7441"),
-	/*  4 */ DECLARE_AMD_DEV("AMD8111"),
-
-	/*  5 */ DECLARE_NV_DEV("NFORCE"),
-	/*  6 */ DECLARE_NV_DEV("NFORCE2"),
-	/*  7 */ DECLARE_NV_DEV("NFORCE2-U400R"),
-	/*  8 */ DECLARE_NV_DEV("NFORCE2-U400R-SATA"),
-	/*  9 */ DECLARE_NV_DEV("NFORCE3-150"),
-	/* 10 */ DECLARE_NV_DEV("NFORCE3-250"),
-	/* 11 */ DECLARE_NV_DEV("NFORCE3-250-SATA"),
-	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
-	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
-	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
-	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51"),
-	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55"),
-	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61"),
-	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP65"),
-	/* 19 */ DECLARE_NV_DEV("NFORCE-MCP67"),
-	/* 20 */ DECLARE_NV_DEV("NFORCE-MCP73"),
-	/* 21 */ DECLARE_NV_DEV("NFORCE-MCP77"),
-	/* 22 */ DECLARE_AMD_DEV("AMD5536"),
+	/*  0 */ DECLARE_AMD_DEV("AMD7401",	  0x00, ATA_UDMA2),
+	/*  1 */ DECLARE_AMD_DEV("AMD7409", ATA_SWDMA2, ATA_UDMA4),
+	/*  2 */ DECLARE_AMD_DEV("AMD7411", ATA_SWDMA2, ATA_UDMA5),
+	/*  3 */ DECLARE_AMD_DEV("AMD7441", ATA_SWDMA2, ATA_UDMA5),
+	/*  4 */ DECLARE_AMD_DEV("AMD8111", ATA_SWDMA2, ATA_UDMA6),
+
+	/*  5 */ DECLARE_NV_DEV("NFORCE",		ATA_UDMA5),
+	/*  6 */ DECLARE_NV_DEV("NFORCE2",		ATA_UDMA6),
+	/*  7 */ DECLARE_NV_DEV("NFORCE2-U400R",	ATA_UDMA6),
+	/*  8 */ DECLARE_NV_DEV("NFORCE2-U400R-SATA",	ATA_UDMA6),
+	/*  9 */ DECLARE_NV_DEV("NFORCE3-150",		ATA_UDMA6),
+	/* 10 */ DECLARE_NV_DEV("NFORCE3-250",		ATA_UDMA6),
+	/* 11 */ DECLARE_NV_DEV("NFORCE3-250-SATA",	ATA_UDMA6),
+	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2",	ATA_UDMA6),
+	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804",		ATA_UDMA6),
+	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04",		ATA_UDMA6),
+	/* 15 */ DECLARE_NV_DEV("NFORCE-MCP51",		ATA_UDMA6),
+	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP55",		ATA_UDMA6),
+	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP61",		ATA_UDMA6),
+	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP65",		ATA_UDMA6),
+	/* 19 */ DECLARE_NV_DEV("NFORCE-MCP67",		ATA_UDMA6),
+	/* 20 */ DECLARE_NV_DEV("NFORCE-MCP73",		ATA_UDMA6),
+	/* 21 */ DECLARE_NV_DEV("NFORCE-MCP77",		ATA_UDMA6),
+
+	/* 22 */ DECLARE_AMD_DEV("AMD5536", ATA_SWDMA2, ATA_UDMA5),
 };
=20
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct p=
ci_device_id *id)
 {
-	amd_chipset =3D amd74xx_chipsets + id->driver_data;
-	amd_config =3D amd_ide_chips + id->driver_data;
-	if (dev->device !=3D amd_config->id) {
-		printk(KERN_ERR "%s: assertion 0x%02x =3D=3D 0x%02x failed !\n",
-		       pci_name(dev), dev->device, amd_config->id);
-		return -ENODEV;
+	struct ide_port_info d;
+	u8 idx =3D id->driver_data;
+
+	d =3D amd74xx_chipsets[idx];
+
+	/*
+	 * Check for bad SWDMA and incorrectly wired Serenade mainboards.
+	 */
+	if (idx =3D=3D 1) {
+		if (dev->revision <=3D 7)
+			d.swdma_mask =3D 0;
+		d.host_flags |=3D IDE_HFLAG_CLEAR_SIMPLEX;
+	} else if (idx =3D=3D 4) {
+		if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_AMD &&
+		    dev->subsystem_device =3D=3D PCI_DEVICE_ID_AMD_SERENADE)
+			d.udma_mask =3D ATA_UDMA5;
 	}
-	return ide_setup_pci_device(dev, amd_chipset);
+
+	printk(KERN_INFO "%s: %s (rev %02x) UDMA%s controller\n",
+			 d.name, pci_name(dev), dev->revision,
+			 amd_dma[fls(d.udma_mask) - 1]);
+
+	return ide_setup_pci_device(dev, &d);
 }
=20
 static const struct pci_device_id amd74xx_pci_tbl[] =3D {
diff --git a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
index 4918719..b56274a 100644
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.05	Nov 9 2007
- *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
  *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
  */
@@ -55,7 +53,7 @@ static DEFINE_SPINLOCK(atiixp_lock);
=20
 static void atiixp_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
 	int timing_shift =3D (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 :=
 8;
 	u32 pio_timing_data;
@@ -88,7 +86,7 @@ static void atiixp_set_pio_mode(ide_drive_t *drive, c=
onst u8 pio)
=20
 static void atiixp_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	unsigned long flags;
 	int timing_shift =3D (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 :=
 8;
 	u32 tmp32;
@@ -133,9 +131,8 @@ static void atiixp_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
=20
 static void __devinit init_hwif_atiixp(ide_hwif_t *hwif)
 {
-	u8 udma_mode =3D 0;
-	u8 ch =3D hwif->channel;
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
+	u8 udma_mode =3D 0, ch =3D hwif->channel;
=20
 	hwif->set_pio_mode =3D &atiixp_set_pio_mode;
 	hwif->set_dma_mode =3D &atiixp_set_dma_mode;
diff --git a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
index da3565e..7240c20 100644
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/cmd640.c		Version 1.02  Sep 01, 1996
- *
  *  Copyright (C) 1995-1996  Linus Torvalds & authors (see below)
  */
=20
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index cd4eb9d..04aa9e5 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.53	Dec 24, 2007
- *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI mac=
hines.
  *           Due to massive hardware bugs, UltraDMA is only supported
  *           on the 646U2 and not on the 646U.
@@ -71,7 +69,7 @@ static u8 quantize_timing(int timing, int quant)
  */
 static void program_cycle_times (ide_drive_t *drive, int cycle_time, i=
nt active_time)
 {
-	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
 	int clock_time		=3D 1000 / system_bus_clock();
 	u8  cycle_count, active_count, recovery_count, drwtim;
 	static const u8 recovery_values[] =3D
@@ -118,7 +116,7 @@ static void program_cycle_times (ide_drive_t *drive=
, int cycle_time, int active_
 static void cmd64x_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	unsigned int cycle_time;
 	u8 setup_count, arttim =3D 0;
=20
@@ -183,7 +181,7 @@ static void cmd64x_set_pio_mode(ide_drive_t *drive,=
 const u8 pio)
 static void cmd64x_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 unit			=3D drive->dn & 0x01;
 	u8 regU =3D 0, pciU	=3D hwif->channel ? UDIDETCR1 : UDIDETCR0;
=20
@@ -245,7 +243,7 @@ static int cmd648_ide_dma_end (ide_drive_t *drive)
 static int cmd64x_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int irq_reg		=3D hwif->channel ? ARTTIM23 : CFR;
 	u8  irq_mask		=3D hwif->channel ? ARTTIM23_INTR_CH1 :
 						  CFR_INTR_CH0;
@@ -285,7 +283,7 @@ static int cmd648_ide_dma_test_irq (ide_drive_t *dr=
ive)
 static int cmd64x_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int irq_reg		=3D hwif->channel ? ARTTIM23 : CFR;
 	u8  irq_mask		=3D hwif->channel ? ARTTIM23_INTR_CH1 :
 						  CFR_INTR_CH0;
@@ -375,7 +373,7 @@ static unsigned int __devinit init_chipset_cmd64x(s=
truct pci_dev *dev, const cha
=20
 static u8 __devinit ata66_cmd64x(ide_hwif_t *hwif)
 {
-	struct pci_dev  *dev	=3D hwif->pci_dev;
+	struct pci_dev  *dev	=3D to_pci_dev(hwif->dev);
 	u8 bmidecsr =3D 0, mask	=3D hwif->channel ? 0x02 : 0x01;
=20
 	switch (dev->device) {
@@ -390,7 +388,7 @@ static u8 __devinit ata66_cmd64x(ide_hwif_t *hwif)
=20
 static void __devinit init_hwif_cmd64x(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
=20
 	hwif->set_pio_mode =3D &cmd64x_set_pio_mode;
 	hwif->set_dma_mode =3D &cmd64x_set_dma_mode;
@@ -443,7 +441,9 @@ static const struct ide_port_info cmd64x_chipsets[]=
 __devinitdata =3D {
 		.init_chipset	=3D init_chipset_cmd64x,
 		.init_hwif	=3D init_hwif_cmd64x,
 		.enablebits	=3D {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
-		.host_flags	=3D IDE_HFLAG_ABUSE_PREFETCH | IDE_HFLAG_BOOTABLE,
+		.host_flags	=3D IDE_HFLAG_CLEAR_SIMPLEX |
+				  IDE_HFLAG_ABUSE_PREFETCH |
+				  IDE_HFLAG_BOOTABLE,
 		.pio_mask	=3D ATA_PIO5,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D 0x00, /* no udma */
diff --git a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
index 6ec00b8..9e01c6d 100644
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -69,7 +69,7 @@ static struct pio_clocks cs5520_pio_clocks[]=3D{
 static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	int controller =3D drive->dn > 1 ? 1 : 0;
=20
 	/* FIXME: if DMA =3D 1 do we need to set the DMA bit here ? */
diff --git a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
index df5966b..765aac3 100644
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/cs5530.c		Version 0.77	Sep 24 2007
- *
  * Copyright (C) 2000			Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2000			Mark Lord <mlord@pobox.com>
  * Copyright (C) 2007			Bartlomiej Zolnierkiewicz
diff --git a/drivers/ide/pci/cs5535.c b/drivers/ide/pci/cs5535.c
index 50b3d77..66433aa 100644
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/cs5535.c
- *
  * Copyright (C) 2004-2005 Advanced Micro Devices, Inc.
  * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  *
@@ -177,13 +175,15 @@ static u8 __devinit cs5535_cable_detect(struct pc=
i_dev *dev)
  */
 static void __devinit init_hwif_cs5535(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	hwif->set_pio_mode =3D &cs5535_set_pio_mode;
 	hwif->set_dma_mode =3D &cs5535_set_dma_mode;
=20
 	if (hwif->dma_base =3D=3D 0)
 		return;
=20
-	hwif->cbl =3D cs5535_cable_detect(hwif->pci_dev);
+	hwif->cbl =3D cs5535_cable_detect(dev);
 }
=20
 static const struct ide_port_info cs5535_chipset __devinitdata =3D {
diff --git a/drivers/ide/pci/cy82c693.c b/drivers/ide/pci/cy82c693.c
index 3ec4c65..50100ac 100644
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/cy82c693.c		Version 0.44	Nov 8, 2007
- *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), M=
aintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integ=
rator
  *
@@ -228,7 +226,7 @@ static void cy82c693_set_dma_mode(ide_drive_t *driv=
e, const u8 mode)
 static void cy82c693_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	pio_clocks_t pclk;
 	unsigned int addrCtrl;
=20
@@ -397,8 +395,9 @@ static void __devinit init_hwif_cy82c693(ide_hwif_t=
 *hwif)
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	static ide_hwif_t *primary;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
=20
-	if (PCI_FUNC(hwif->pci_dev->devfn) =3D=3D 1)
+	if (PCI_FUNC(dev->devfn) =3D=3D 1)
 		primary =3D hwif;
 	else {
 		hwif->mate =3D primary;
diff --git a/drivers/ide/pci/delkin_cb.c b/drivers/ide/pci/delkin_cb.c
index 26aa492..27e47fc 100644
--- a/drivers/ide/pci/delkin_cb.c
+++ b/drivers/ide/pci/delkin_cb.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/delkin_cb.c
- *
  *  Created 20 Oct 2004 by Mark Lord
  *
  *  Basic support for Delkin/ASKA/Workbit Cardbus CompactFlash adapter
@@ -87,7 +85,7 @@ delkin_cb_probe (struct pci_dev *dev, const struct pc=
i_device_id *id)
 		return -ENODEV;
 	}
 	pci_set_drvdata(dev, hwif);
-	hwif->pci_dev =3D dev;
+	hwif->dev =3D &dev->dev;
 	drive =3D &hwif->drives[0];
 	if (drive->present) {
 		drive->io_32bit =3D 1;
diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index 0688569..59ebe84 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/generic.c	Version 0.11	December 30, 2002
- *
  *  Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  *  Portions (C) Copyright 2002  Red Hat Inc <alan@redhat.com>
  *
@@ -104,7 +102,8 @@ static const struct ide_port_info generic_chipsets[=
] __devinitdata =3D {
=20
 	{	/* 14 */
 		.name		=3D "Revolution",
-		.host_flags	=3D IDE_HFLAG_TRUST_BIOS_FOR_DMA |
+		.host_flags	=3D IDE_HFLAG_CLEAR_SIMPLEX |
+				  IDE_HFLAG_TRUST_BIOS_FOR_DMA |
 				  IDE_HFLAG_OFF_BOARD,
 		.swdma_mask	=3D ATA_SWDMA2,
 		.mwdma_mask	=3D ATA_MWDMA2,
diff --git a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
index dfba0d1..25dbb81 100644
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -1,7 +1,6 @@
 /*
- * linux/drivers/ide/pci/hpt34x.c		Version 0.40	Sept 10, 2002
- *
  * Copyright (C) 1998-2000	Andre Hedrick <andre@linux-ide.org>
+ *
  * May be copied or modified under the terms of the GNU General Public=
 License
  *
  *
@@ -45,7 +44,7 @@
=20
 static void hpt34x_set_mode(ide_drive_t *drive, const u8 speed)
 {
-	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 reg1=3D 0, tmp1 =3D 0, reg2 =3D 0, tmp2 =3D 0;
 	u8			hi_speed, lo_speed;
=20
@@ -131,6 +130,7 @@ static void __devinit init_hwif_hpt34x(ide_hwif_t *=
hwif)
=20
 #define IDE_HFLAGS_HPT34X \
 	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_NO_DSC | \
 	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
 	 IDE_HFLAG_NO_AUTODMA)
=20
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
index 1268593..5623cad 100644
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.30	Dec 12, 2007
- *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
@@ -626,7 +624,8 @@ static int check_in_drive_list(ide_drive_t *drive, =
const char **list)
 static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct hpt_info *info	=3D pci_get_drvdata(hwif->pci_dev);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
+	struct hpt_info *info	=3D pci_get_drvdata(dev);
 	u8 mask 		=3D hwif->ultra_mask;
=20
 	switch (info->chip_type) {
@@ -665,7 +664,8 @@ static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 static u8 hpt3xx_mdma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct hpt_info *info	=3D pci_get_drvdata(hwif->pci_dev);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
+	struct hpt_info *info	=3D pci_get_drvdata(dev);
=20
 	switch (info->chip_type) {
 	case HPT372 :
@@ -699,7 +699,7 @@ static u32 get_speed_setting(u8 speed, struct hpt_i=
nfo *info)
=20
 static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
-	struct pci_dev  *dev	=3D HWIF(drive)->pci_dev;
+	struct pci_dev  *dev	=3D to_pci_dev(drive->hwif->dev);
 	struct hpt_info	*info	=3D pci_get_drvdata(dev);
 	struct hpt_timings *t	=3D info->timings;
 	u8  itr_addr		=3D 0x40 + (drive->dn * 4);
@@ -742,7 +742,7 @@ static void hpt3xx_quirkproc(ide_drive_t *drive)
 static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev	*dev	=3D hwif->pci_dev;
+	struct pci_dev	*dev	=3D to_pci_dev(hwif->dev);
 	struct hpt_info *info	=3D pci_get_drvdata(dev);
=20
 	if (drive->quirk_list) {
@@ -774,7 +774,7 @@ static void hpt3xx_maskproc(ide_drive_t *drive, int=
 mask)
  */
 static void hpt366_dma_lost_irq(ide_drive_t *drive)
 {
-	struct pci_dev *dev =3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u8 mcr1 =3D 0, mcr3 =3D 0, scr1 =3D 0;
=20
 	pci_read_config_byte(dev, 0x50, &mcr1);
@@ -790,18 +790,20 @@ static void hpt366_dma_lost_irq(ide_drive_t *driv=
e)
 static void hpt370_clear_engine(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
=20
-	pci_write_config_byte(hwif->pci_dev, hwif->select_data, 0x37);
+	pci_write_config_byte(dev, hwif->select_data, 0x37);
 	udelay(10);
 }
=20
 static void hpt370_irq_timeout(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u16 bfifo		=3D 0;
 	u8  dma_cmd;
=20
-	pci_read_config_word(hwif->pci_dev, hwif->select_data + 2, &bfifo);
+	pci_read_config_word(dev, hwif->select_data + 2, &bfifo);
 	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo & 0x1f=
f);
=20
 	/* get DMA command mode */
@@ -844,10 +846,11 @@ static void hpt370_dma_timeout(ide_drive_t *drive=
)
 static int hpt374_ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u16 bfifo		=3D 0;
 	u8  dma_stat;
=20
-	pci_read_config_word(hwif->pci_dev, hwif->select_data + 2, &bfifo);
+	pci_read_config_word(dev, hwif->select_data + 2, &bfifo);
 	if (bfifo & 0x1FF) {
 //		printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
 		return 0;
@@ -867,7 +870,7 @@ static int hpt374_ide_dma_test_irq(ide_drive_t *dri=
ve)
 static int hpt374_ide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev	*dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 mcr	=3D 0, mcr_addr	=3D hwif->select_data;
 	u8 bwsr =3D 0, mask	=3D hwif->channel ? 0x02 : 0x01;
=20
@@ -942,7 +945,7 @@ static void hpt3xxn_rw_disk(ide_drive_t *drive, str=
uct request *rq)
 static int hpt3xx_busproc(ide_drive_t *drive, int state)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8  mcr_addr		=3D hwif->select_data + 2;
 	u8  resetmask		=3D hwif->channel ? 0x80 : 0x40;
 	u8  bsr2		=3D 0;
@@ -1278,7 +1281,7 @@ static unsigned int __devinit init_chipset_hpt366=
(struct pci_dev *dev, const cha
=20
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev	*dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	struct hpt_info *info	=3D pci_get_drvdata(dev);
 	int serialize		=3D HPT_SERIALIZE_IO;
 	u8  scr1 =3D 0, ata66	=3D hwif->channel ? 0x01 : 0x02;
@@ -1393,7 +1396,7 @@ static void __devinit init_hwif_hpt366(ide_hwif_t=
 *hwif)
=20
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long =
dmabase)
 {
-	struct pci_dev	*dev		=3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 masterdma	=3D 0, slavedma	=3D 0;
 	u8 dma_new	=3D 0, dma_old	=3D 0;
 	unsigned long flags;
@@ -1413,7 +1416,7 @@ static void __devinit init_dma_hpt366(ide_hwif_t =
*hwif, unsigned long dmabase)
=20
 	local_irq_restore(flags);
=20
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
=20
 static void __devinit hpt374_init(struct pci_dev *dev, struct pci_dev =
*dev2)
diff --git a/drivers/ide/pci/it8213.c b/drivers/ide/pci/it8213.c
index 2a0f45c..df74e58 100644
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -28,7 +28,7 @@
 static void it8213_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int is_slave		=3D drive->dn & 1;
 	int master_port		=3D 0x40;
 	int slave_port		=3D 0x44;
@@ -85,7 +85,7 @@ static void it8213_set_pio_mode(ide_drive_t *drive, c=
onst u8 pio)
 static void it8213_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 maslave		=3D 0x40;
 	int a_speed		=3D 3 << (drive->dn * 4);
 	int u_flag		=3D 1 << drive->dn;
@@ -152,6 +152,7 @@ static void it8213_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
=20
 static void __devinit init_hwif_it8213(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 reg42h =3D 0;
=20
 	hwif->set_dma_mode =3D &it8213_set_dma_mode;
@@ -160,7 +161,7 @@ static void __devinit init_hwif_it8213(ide_hwif_t *=
hwif)
 	if (!hwif->dma_base)
 		return;
=20
-	pci_read_config_byte(hwif->pci_dev, 0x42, &reg42h);
+	pci_read_config_byte(dev, 0x42, &reg42h);
=20
 	if (hwif->cbl !=3D ATA_CBL_PATA40_SHORT)
 		hwif->cbl =3D (reg42h & 0x02) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
index e610a53..938d35f 100644
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -1,7 +1,4 @@
-
 /*
- * linux/drivers/ide/pci/it821x.c		Version 0.16	Jul 3 2007
- *
  * Copyright (C) 2004		Red Hat <alan@redhat.com>
  * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  *
@@ -113,7 +110,8 @@ static int it8212_noraid;
=20
 static void it821x_program(ide_drive_t *drive, u16 timing)
 {
-	ide_hwif_t *hwif	=3D drive->hwif;
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *itdev =3D ide_get_hwifdata(hwif);
 	int channel =3D hwif->channel;
 	u8 conf;
@@ -123,7 +121,8 @@ static void it821x_program(ide_drive_t *drive, u16 =
timing)
 		conf =3D timing >> 8;
 	else
 		conf =3D timing & 0xFF;
-	pci_write_config_byte(hwif->pci_dev, 0x54 + 4 * channel, conf);
+
+	pci_write_config_byte(dev, 0x54 + 4 * channel, conf);
 }
=20
 /**
@@ -137,7 +136,8 @@ static void it821x_program(ide_drive_t *drive, u16 =
timing)
=20
 static void it821x_program_udma(ide_drive_t *drive, u16 timing)
 {
-	ide_hwif_t *hwif	=3D drive->hwif;
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *itdev =3D ide_get_hwifdata(hwif);
 	int channel =3D hwif->channel;
 	int unit =3D drive->select.b.unit;
@@ -148,11 +148,12 @@ static void it821x_program_udma(ide_drive_t *driv=
e, u16 timing)
 		conf =3D timing >> 8;
 	else
 		conf =3D timing & 0xFF;
-	if(itdev->timing10 =3D=3D 0)
-		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel + unit, conf=
);
+
+	if (itdev->timing10 =3D=3D 0)
+		pci_write_config_byte(dev, 0x56 + 4 * channel + unit, conf);
 	else {
-		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel, conf);
-		pci_write_config_byte(hwif->pci_dev, 0x56 + 4 * channel + 1, conf);
+		pci_write_config_byte(dev, 0x56 + 4 * channel, conf);
+		pci_write_config_byte(dev, 0x56 + 4 * channel + 1, conf);
 	}
 }
=20
@@ -167,6 +168,7 @@ static void it821x_program_udma(ide_drive_t *drive,=
 u16 timing)
 static void it821x_clock_strategy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *itdev =3D ide_get_hwifdata(hwif);
=20
 	u8 unit =3D drive->select.b.unit;
@@ -205,10 +207,11 @@ static void it821x_clock_strategy(ide_drive_t *dr=
ive)
 		itdev->clock_mode =3D ATA_50;
 		sel =3D 1;
 	}
-	pci_read_config_byte(hwif->pci_dev, 0x50, &v);
+
+	pci_read_config_byte(dev, 0x50, &v);
 	v &=3D ~(1 << (1 + hwif->channel));
 	v |=3D sel << (1 + hwif->channel);
-	pci_write_config_byte(hwif->pci_dev, 0x50, v);
+	pci_write_config_byte(dev, 0x50, v);
=20
 	/*
 	 *	Reprogram the UDMA/PIO of the pair drive for the switch
@@ -282,7 +285,8 @@ static void it821x_set_pio_mode(ide_drive_t *drive,=
 const u8 pio)
=20
 static void it821x_tune_mwdma (ide_drive_t *drive, byte mode_wanted)
 {
-	ide_hwif_t *hwif	=3D drive->hwif;
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *itdev =3D (void *)ide_get_hwifdata(hwif);
 	int unit =3D drive->select.b.unit;
 	int channel =3D hwif->channel;
@@ -297,12 +301,12 @@ static void it821x_tune_mwdma (ide_drive_t *drive=
, byte mode_wanted)
 	itdev->udma[unit] =3D UDMA_OFF;
=20
 	/* UDMA bits off - Revision 0x10 do them in pairs */
-	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
-	if(itdev->timing10)
+	pci_read_config_byte(dev, 0x50, &conf);
+	if (itdev->timing10)
 		conf |=3D channel ? 0x60: 0x18;
 	else
 		conf |=3D 1 << (3 + 2 * channel + unit);
-	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+	pci_write_config_byte(dev, 0x50, conf);
=20
 	it821x_clock_strategy(drive);
 	/* FIXME: do we need to program this ? */
@@ -320,7 +324,8 @@ static void it821x_tune_mwdma (ide_drive_t *drive, =
byte mode_wanted)
=20
 static void it821x_tune_udma (ide_drive_t *drive, byte mode_wanted)
 {
-	ide_hwif_t *hwif	=3D drive->hwif;
+	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *itdev =3D ide_get_hwifdata(hwif);
 	int unit =3D drive->select.b.unit;
 	int channel =3D hwif->channel;
@@ -337,12 +342,12 @@ static void it821x_tune_udma (ide_drive_t *drive,=
 byte mode_wanted)
 		itdev->udma[unit] |=3D 0x8080;	/* UDMA 5/6 select on */
=20
 	/* UDMA on. Again revision 0x10 must do the pair */
-	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
-	if(itdev->timing10)
+	pci_read_config_byte(dev, 0x50, &conf);
+	if (itdev->timing10)
 		conf &=3D channel ? 0x9F: 0xE7;
 	else
 		conf &=3D ~ (1 << (3 + 2 * channel + unit));
-	pci_write_config_byte(hwif->pci_dev, 0x50, conf);
+	pci_write_config_byte(dev, 0x50, conf);
=20
 	it821x_clock_strategy(drive);
 	it821x_program_udma(drive, itdev->udma[unit]);
@@ -520,6 +525,7 @@ static void __devinit it821x_quirkproc(ide_drive_t =
*drive)
=20
 static void __devinit init_hwif_it821x(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct it821x_dev *idev =3D kzalloc(sizeof(struct it821x_dev), GFP_KE=
RNEL);
 	u8 conf;
=20
@@ -532,7 +538,7 @@ static void __devinit init_hwif_it821x(ide_hwif_t *=
hwif)
=20
 	ide_set_hwifdata(hwif, idev);
=20
-	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
+	pci_read_config_byte(dev, 0x50, &conf);
 	if (conf & 1) {
 		idev->smart =3D 1;
 		hwif->host_flags |=3D IDE_HFLAG_NO_ATAPI_DMA;
@@ -555,7 +561,7 @@ static void __devinit init_hwif_it821x(ide_hwif_t *=
hwif)
 	 *	this is necessary.
 	 */
=20
-	pci_read_config_byte(hwif->pci_dev, 0x08, &conf);
+	pci_read_config_byte(dev, 0x08, &conf);
 	if (conf =3D=3D 0x10) {
 		idev->timing10 =3D 1;
 		hwif->host_flags |=3D IDE_HFLAG_NO_ATAPI_DMA;
diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index 0083eaf..8b40f64 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -30,7 +30,7 @@ typedef enum {
=20
 static u8 __devinit ata66_jmicron(ide_hwif_t *hwif)
 {
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
=20
 	u32 control;
 	u32 control5;
diff --git a/drivers/ide/pci/ns87415.c b/drivers/ide/pci/ns87415.c
index d4df464..fc9eee9 100644
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/ns87415.c		Version 2.00  Sep. 10, 2002
- *
  * Copyright (C) 1997-1998	Mark Lord <mlord@pobox.com>
  * Copyright (C) 1998		Eddie C. Dost <ecd@skynet.be>
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
@@ -71,10 +69,9 @@ static u8 superio_ide_inb (unsigned long port)
=20
 static void __devinit superio_ide_init_iops (struct hwif_s *hwif)
 {
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	u32 base, dmabase;
-	u8 tmp;
-	struct pci_dev *pdev =3D hwif->pci_dev;
-	u8 port =3D hwif->channel;
+	u8 port =3D hwif->channel, tmp;
=20
 	base =3D pci_resource_start(pdev, port * 2) & ~3;
 	dmabase =3D pci_resource_start(pdev, 4) & ~3;
@@ -93,10 +90,11 @@ static void __devinit superio_ide_init_iops (struct=
 hwif_s *hwif)
=20
 static void __devinit init_iops_ns87415(ide_hwif_t *hwif)
 {
-	if (PCI_SLOT(hwif->pci_dev->devfn) =3D=3D 0xE) {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
+	if (PCI_SLOT(dev->devfn) =3D=3D 0xE)
 		/* Built-in - assume it's under superio. */
 		superio_ide_init_iops(hwif);
-	}
 }
 #endif
=20
@@ -110,8 +108,8 @@ static unsigned int ns87415_count =3D 0, ns87415_co=
ntrol[MAX_HWIFS] =3D { 0 };
 static void ns87415_prepare_drive (ide_drive_t *drive, unsigned int us=
e_dma)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned int bit, other, new, *old =3D (unsigned int *) hwif->select_=
data;
-	struct pci_dev *dev =3D hwif->pci_dev;
 	unsigned long flags;
=20
 	local_irq_save(flags);
@@ -189,7 +187,7 @@ static int ns87415_ide_dma_setup(ide_drive_t *drive=
)
=20
 static void __devinit init_hwif_ns87415 (ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned int ctrl, using_inta;
 	u8 progif;
 #ifdef __sparc_v9__
@@ -231,8 +229,8 @@ static void __devinit init_hwif_ns87415 (ide_hwif_t=
 *hwif)
=20
 #ifdef __sparc_v9__
 		/*
-		 * XXX: Reset the device, if we don't it will not respond
-		 *      to SELECT_DRIVE() properly during first probe_hwif().
+		 * XXX: Reset the device, if we don't it will not respond to
+		 *      SELECT_DRIVE() properly during first ide_probe_port().
 		 */
 		timeout =3D 10000;
 		outb(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
diff --git a/drivers/ide/pci/opti621.c b/drivers/ide/pci/opti621.c
index 8953d9c..0ce92d3 100644
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/opti621.c		Version 0.9	Sep 24, 2007
- *
  *  Copyright (C) 1996-1998  Linus Torvalds & authors (see below)
  */
=20
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_=
new.c
index 89d2363..bb29db0 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -149,6 +149,7 @@ static struct udma_timing {
 static void pdcnew_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 adj			=3D (drive->dn & 1) ? 0x08 : 0x00;
=20
 	/*
@@ -159,7 +160,7 @@ static void pdcnew_set_dma_mode(ide_drive_t *drive,=
 const u8 speed)
 	 * As we set up the PLL to output 133 MHz for UltraDMA/133 capable
 	 * chips, we must override the default register settings...
 	 */
-	if (max_dma_rate(hwif->pci_dev) =3D=3D 4) {
+	if (max_dma_rate(dev) =3D=3D 4) {
 		u8 mode =3D speed & 0x07;
=20
 		if (speed >=3D XFER_UDMA_0) {
@@ -186,9 +187,10 @@ static void pdcnew_set_dma_mode(ide_drive_t *drive=
, const u8 speed)
 static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 adj =3D (drive->dn & 1) ? 0x08 : 0x00;
=20
-	if (max_dma_rate(hwif->pci_dev) =3D=3D 4) {
+	if (max_dma_rate(dev) =3D=3D 4) {
 		set_indexed_reg(hwif, 0x0c + adj, pio_timings[pio].reg0c);
 		set_indexed_reg(hwif, 0x0d + adj, pio_timings[pio].reg0d);
 		set_indexed_reg(hwif, 0x13 + adj, pio_timings[pio].reg13);
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_=
old.c
index 3a1e081..31a1308 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/pdc202xx_old.c	Version 0.52	Aug 27, 2007
- *
  *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007		MontaVista Software, Inc.
  *  Copyright (C) 2007			Bartlomiej Zolnierkiewicz
@@ -66,7 +64,7 @@ static void pdc_old_disable_66MHz_clock(ide_hwif_t *)=
;
 static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 drive_pci		=3D 0x60 + (drive->dn << 2);
=20
 	u8			AP =3D 0, BP =3D 0, CP =3D 0;
@@ -144,9 +142,10 @@ static void pdc202xx_set_pio_mode(ide_drive_t *dri=
ve, const u8 pio)
=20
 static u8 pdc202xx_old_cable_detect (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u16 CIS =3D 0, mask =3D (hwif->channel) ? (1<<11) : (1<<10);
=20
-	pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
+	pci_read_config_word(dev, 0x50, &CIS);
=20
 	return (CIS & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
 }
@@ -305,12 +304,14 @@ static unsigned int __devinit init_chipset_pdc202=
xx(struct pci_dev *dev,
=20
 static void __devinit init_hwif_pdc202xx(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	hwif->set_pio_mode =3D &pdc202xx_set_pio_mode;
 	hwif->set_dma_mode =3D &pdc202xx_set_mode;
=20
 	hwif->quirkproc =3D &pdc202xx_quirkproc;
=20
-	if (hwif->pci_dev->device !=3D PCI_DEVICE_ID_PROMISE_20246)
+	if (dev->device !=3D PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc =3D &pdc202xx_reset;
=20
 	if (hwif->dma_base =3D=3D 0)
@@ -319,7 +320,7 @@ static void __devinit init_hwif_pdc202xx(ide_hwif_t=
 *hwif)
 	hwif->dma_lost_irq =3D &pdc202xx_dma_lost_irq;
 	hwif->dma_timeout =3D &pdc202xx_dma_timeout;
=20
-	if (hwif->pci_dev->device !=3D PCI_DEVICE_ID_PROMISE_20246) {
+	if (dev->device !=3D PCI_DEVICE_ID_PROMISE_20246) {
 		if (hwif->cbl !=3D ATA_CBL_PATA40_SHORT)
 			hwif->cbl =3D pdc202xx_old_cable_detect(hwif);
=20
@@ -334,7 +335,7 @@ static void __devinit init_dma_pdc202xx(ide_hwif_t =
*hwif, unsigned long dmabase)
 	u8 udma_speed_flag =3D 0, primary_mode =3D 0, secondary_mode =3D 0;
=20
 	if (hwif->channel) {
-		ide_setup_dma(hwif, dmabase, 8);
+		ide_setup_dma(hwif, dmabase);
 		return;
 	}
=20
@@ -358,7 +359,7 @@ static void __devinit init_dma_pdc202xx(ide_hwif_t =
*hwif, unsigned long dmabase)
 	}
 #endif /* CONFIG_PDC202XX_BURST */
=20
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
=20
 static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
diff --git a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
index bd6d3f7..c1a6b68 100644
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.54	Sep 5, 2007
- *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintai=
ner
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
@@ -8,53 +6,8 @@
  *
  *  May be copied or modified under the terms of the GNU General Publi=
c License
  *
- *  PIO mode setting function for Intel chipsets.
- *  For use instead of BIOS settings.
- *
- * 40-41
- * 42-43
- *=20
- *                 41
- *                 43
- *
- * | PIO 0       | c0 | 80 | 0 |
- * | PIO 2 | SW2 | d0 | 90 | 4 |
- * | PIO 3 | MW1 | e1 | a1 | 9 |
- * | PIO 4 | MW2 | e3 | a3 | b |
- *
- * sitre =3D word40 & 0x4000; primary
- * sitre =3D word42 & 0x4000; secondary
- *
- * 44 8421|8421    hdd|hdb
- *
- * 48 8421         hdd|hdc|hdb|hda udma enabled
- *
- *    0001         hda
- *    0010         hdb
- *    0100         hdc
- *    1000         hdd
- *
- * 4a 84|21        hdb|hda
- * 4b 84|21        hdd|hdc
- *
- *    ata-33/82371AB
- *    ata-33/82371EB
- *    ata-33/82801AB            ata-66/82801AA
- *    00|00 udma 0              00|00 reserved
- *    01|01 udma 1              01|01 udma 3
- *    10|10 udma 2              10|10 udma 4
- *    11|11 reserved            11|11 reserved
- *
- * 54 8421|8421    ata66 drive|ata66 enable
- *
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x40, &reg40);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x42, &reg42);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x44, &reg44);
- * pci_read_config_byte(HWIF(drive)->pci_dev, 0x48, &reg48);
- * pci_read_config_word(HWIF(drive)->pci_dev, 0x4a, &reg4a);
- * pci_read_config_byte(HWIF(drive)->pci_dev, 0x54, &reg54);
+ * Documentation:
  *
- * Documentation
  *	Publically available from Intel web site. Errata documentation
  * is also publically available. As an aide to anyone hacking on this
  * driver the list of errata that are relevant is below.going back to
@@ -116,7 +69,7 @@ static int no_piix_dma;
 static void piix_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int is_slave		=3D drive->dn & 1;
 	int master_port		=3D hwif->channel ? 0x42 : 0x40;
 	int slave_port		=3D 0x44;
@@ -185,7 +138,7 @@ static void piix_set_pio_mode(ide_drive_t *drive, c=
onst u8 pio)
 static void piix_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 maslave		=3D hwif->channel ? 0x42 : 0x40;
 	int a_speed		=3D 3 << (drive->dn * 4);
 	int u_flag		=3D 1 << drive->dn;
@@ -305,7 +258,7 @@ static const struct ich_laptop ich_laptop[] =3D {
=20
 static u8 __devinit piix_cable_detect(ide_hwif_t *hwif)
 {
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	const struct ich_laptop *lap =3D &ich_laptop[0];
 	u8 reg54h =3D 0, mask =3D hwif->channel ? 0xc0 : 0x30;
=20
diff --git a/drivers/ide/pci/rz1000.c b/drivers/ide/pci/rz1000.c
index 6b10ae2..7ed6625 100644
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/rz1000.c	Version 0.06	January 12, 2003
- *
  *  Copyright (C) 1995-1998  Linus Torvalds & author (see below)
  */
=20
@@ -32,8 +30,8 @@
=20
 static void __devinit init_hwif_rz1000 (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u16 reg;
-	struct pci_dev *dev =3D hwif->pci_dev;
=20
 	if (!pci_read_config_word (dev, 0x40, &reg) &&
 	    !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
index 32fdf53..af499a6 100644
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/sc1200.c		Version 0.97	Aug 3 2007
- *
  * Copyright (C) 2000-2002		Mark Lord <mlord@pobox.com>
  * Copyright (C)      2007		Bartlomiej Zolnierkiewicz
  *
@@ -87,7 +85,7 @@ static const unsigned int sc1200_pio_timings[4][5] =3D
 static void sc1200_tunepio(ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	unsigned int basereg =3D hwif->channel ? 0x50 : 0x40, format =3D 0;
=20
 	pci_read_config_dword(pdev, basereg + 4, &format);
@@ -130,6 +128,7 @@ out:
 static void sc1200_set_dma_mode(ide_drive_t *drive, const u8 mode)
 {
 	ide_hwif_t		*hwif =3D HWIF(drive);
+	struct pci_dev		*dev =3D to_pci_dev(hwif->dev);
 	int			unit =3D drive->select.b.unit;
 	unsigned int		reg, timings;
 	unsigned short		pci_clock;
@@ -160,12 +159,11 @@ static void sc1200_set_dma_mode(ide_drive_t *driv=
e, const u8 mode)
 		timings =3D mwdma_timing[pci_clock][mode - XFER_MW_DMA_0];
=20
 	if (unit =3D=3D 0) {			/* are we configuring drive0? */
-		pci_read_config_dword(hwif->pci_dev, basereg+4, &reg);
+		pci_read_config_dword(dev, basereg + 4, &reg);
 		timings |=3D reg & 0x80000000;	/* preserve PIO format bit */
-		pci_write_config_dword(hwif->pci_dev, basereg+4, timings);
-	} else {
-		pci_write_config_dword(hwif->pci_dev, basereg+12, timings);
-	}
+		pci_write_config_dword(dev, basereg + 4, timings);
+	} else
+		pci_write_config_dword(dev, basereg + 12, timings);
 }
=20
 /*  Replacement for the standard ide_dma_end action in
diff --git a/drivers/ide/pci/scc_pata.c b/drivers/ide/pci/scc_pata.c
index 24a85bb..7694969 100644
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -594,7 +594,7 @@ static int __devinit init_setup_scc(struct pci_dev =
*dev,
=20
 static void __devinit init_mmio_iops_scc(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	struct scc_ports *ports =3D pci_get_drvdata(dev);
 	unsigned long dma_base =3D ports->dma;
=20
@@ -620,7 +620,7 @@ static void __devinit init_mmio_iops_scc(ide_hwif_t=
 *hwif)
 	hwif->io_ports[IDE_STATUS_OFFSET] =3D dma_base + 0x3c;
 	hwif->io_ports[IDE_CONTROL_OFFSET] =3D dma_base + 0x40;
=20
-	hwif->irq =3D hwif->pci_dev->irq;
+	hwif->irq =3D dev->irq;
 	hwif->dma_base =3D dma_base;
 	hwif->config_data =3D ports->ctl;
 	hwif->mmio =3D 1;
@@ -636,7 +636,8 @@ static void __devinit init_mmio_iops_scc(ide_hwif_t=
 *hwif)
=20
 static void __devinit init_iops_scc(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D  hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	hwif->hwif_data =3D NULL;
 	if (pci_get_drvdata(dev) =3D=3D NULL)
 		return;
@@ -726,10 +727,8 @@ static void __devexit scc_remove(struct pci_dev *d=
ev)
 	unsigned long dma_size =3D pci_resource_len(dev, 1);
=20
 	if (hwif->dmatable_cpu) {
-		pci_free_consistent(hwif->pci_dev,
-				    PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu,
-				    hwif->dmatable_dma);
+		pci_free_consistent(dev, PRD_ENTRIES * PRD_BYTES,
+				    hwif->dmatable_cpu, hwif->dmatable_dma);
 		hwif->dmatable_cpu =3D NULL;
 	}
=20
diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverwork=
s.c
index 877c09b..f495253 100644
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/serverworks.c		Version 0.22	Jun 27 2007
- *
  * Copyright (C) 1998-2000 Michel Aubry
  * Copyright (C) 1998-2000 Andrzej Krzysztofowicz
  * Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -67,7 +65,7 @@ static int check_in_drive_lists (ide_drive_t *drive, =
const char **list)
=20
 static u8 svwks_udma_filter(ide_drive_t *drive)
 {
-	struct pci_dev *dev     =3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u8 mask =3D 0;
=20
 	if (dev->device =3D=3D PCI_DEVICE_ID_SERVERWORKS_HT1000IDE)
@@ -130,7 +128,7 @@ static void svwks_set_pio_mode(ide_drive_t *drive, =
const u8 pio)
 	static const u8 pio_modes[] =3D { 0x5d, 0x47, 0x34, 0x22, 0x20 };
 	static const u8 drive_pci[] =3D { 0x41, 0x40, 0x43, 0x42 };
=20
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
=20
 	pci_write_config_byte(dev, drive_pci[drive->dn], pio_modes[pio]);
=20
@@ -153,7 +151,7 @@ static void svwks_set_dma_mode(ide_drive_t *drive, =
const u8 speed)
 	static const u8 drive_pci2[]		=3D { 0x45, 0x44, 0x47, 0x46 };
=20
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 unit			=3D (drive->select.b.unit & 0x01);
=20
 	u8 ultra_enable	 =3D 0, ultra_timing =3D 0, dma_timing =3D 0;
@@ -287,7 +285,8 @@ static u8 __devinit ata66_svwks_svwks(ide_hwif_t *h=
wif)
  */
 static u8 __devinit ata66_svwks_dell(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_DELL &&
 	    dev->vendor	=3D=3D PCI_VENDOR_ID_SERVERWORKS &&
 	    (dev->device =3D=3D PCI_DEVICE_ID_SERVERWORKS_CSB5IDE ||
@@ -305,7 +304,8 @@ static u8 __devinit ata66_svwks_dell(ide_hwif_t *hw=
if)
  */
 static u8 __devinit ata66_svwks_cobalt(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SUN &&
 	    dev->vendor	=3D=3D PCI_VENDOR_ID_SERVERWORKS &&
 	    dev->device =3D=3D PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
@@ -316,7 +316,7 @@ static u8 __devinit ata66_svwks_cobalt(ide_hwif_t *=
hwif)
=20
 static u8 __devinit ata66_svwks(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
=20
 	/* Server Works */
 	if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SERVERWORKS)
@@ -340,6 +340,8 @@ static u8 __devinit ata66_svwks(ide_hwif_t *hwif)
=20
 static void __devinit init_hwif_svwks (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	hwif->set_pio_mode =3D &svwks_set_pio_mode;
 	hwif->set_dma_mode =3D &svwks_set_dma_mode;
 	hwif->udma_filter =3D &svwks_udma_filter;
@@ -347,7 +349,7 @@ static void __devinit init_hwif_svwks (ide_hwif_t *=
hwif)
 	if (!hwif->dma_base)
 		return;
=20
-	if (hwif->pci_dev->device !=3D PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
+	if (dev->device !=3D PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
 		if (hwif->cbl !=3D ATA_CBL_PATA40_SHORT)
 			hwif->cbl =3D ata66_svwks(hwif);
 	}
@@ -418,7 +420,9 @@ static int __devinit svwks_init_one(struct pci_dev =
*dev, const struct pci_device
=20
 	d =3D serverworks_chipsets[idx];
=20
-	if (idx =3D=3D 2 || idx =3D=3D 3) {
+	if (idx =3D=3D 1)
+		d.host_flags |=3D IDE_HFLAG_CLEAR_SIMPLEX;
+	else if (idx =3D=3D 2 || idx =3D=3D 3) {
 		if ((PCI_FUNC(dev->devfn) & 1) =3D=3D 0) {
 			if (pci_resource_start(dev, 0) !=3D 0x01f1)
 				d.host_flags &=3D ~IDE_HFLAG_BOOTABLE;
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index 9e0be7d..8590207 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -159,6 +159,7 @@ sgiioc4_clearirq(ide_drive_t * drive)
 		}
=20
 		if (intr_reg & 0x02) {
+			struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 			/* Error when transferring DMA data on PCI bus */
 			u32 pci_err_addr_low, pci_err_addr_high,
 			    pci_stat_cmd_reg;
@@ -167,7 +168,7 @@ sgiioc4_clearirq(ide_drive_t * drive)
 				readl((void __iomem *)hwif->io_ports[IDE_IRQ_OFFSET]);
 			pci_err_addr_high =3D
 				readl((void __iomem *)(hwif->io_ports[IDE_IRQ_OFFSET] + 4));
-			pci_read_config_dword(hwif->pci_dev, PCI_COMMAND,
+			pci_read_config_dword(dev, PCI_COMMAND,
 					      &pci_stat_cmd_reg);
 			printk(KERN_ERR
 			       "%s(%s) : PCI Bus Error when doing DMA:"
@@ -178,8 +179,7 @@ sgiioc4_clearirq(ide_drive_t * drive)
 			       __FUNCTION__, drive->name,
 			       pci_err_addr_high, pci_err_addr_low);
 			/* Clear the PCI Error indicator */
-			pci_write_config_dword(hwif->pci_dev, PCI_COMMAND,
-					       0x00000146);
+			pci_write_config_dword(dev, PCI_COMMAND, 0x00000146);
 		}
=20
 		/* Clear the Interrupt, Error bits on the IOC4 */
@@ -334,6 +334,7 @@ sgiioc4_INB(unsigned long port)
 static int __devinit
 ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	void __iomem *virt_dma_base;
 	int num_ports =3D sizeof (ioc4_dma_regs_t);
 	void *pad;
@@ -359,7 +360,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dm=
a_base)
 	}
 	hwif->dma_base =3D (unsigned long) virt_dma_base;
=20
-	hwif->dmatable_cpu =3D pci_alloc_consistent(hwif->pci_dev,
+	hwif->dmatable_cpu =3D pci_alloc_consistent(dev,
 					  IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 					  &hwif->dmatable_dma);
=20
@@ -368,7 +369,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dm=
a_base)
=20
 	hwif->sg_max_nents =3D IOC4_PRD_ENTRIES;
=20
-	pad =3D pci_alloc_consistent(hwif->pci_dev, IOC4_IDE_CACHELINE_SIZE,
+	pad =3D pci_alloc_consistent(dev, IOC4_IDE_CACHELINE_SIZE,
 				   (dma_addr_t *) &(hwif->dma_status));
=20
 	if (pad) {
@@ -376,8 +377,7 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dm=
a_base)
 		return 0;
 	}
=20
-	pci_free_consistent(hwif->pci_dev,
-			    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
+	pci_free_consistent(dev, IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 			    hwif->dmatable_cpu, hwif->dmatable_dma);
 	printk(KERN_INFO
 	       "%s() -- Error! Unable to allocate DMA Maps for drive %s\n",
@@ -517,8 +517,7 @@ sgiioc4_build_dma_table(ide_drive_t * drive, struct=
 request *rq, int ddir)
 	}
=20
 use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev, hwif->sg_table, hwif->sg_nents,
-		     hwif->sg_dma_direction);
+	ide_destroy_dmatable(drive);
=20
 	return 0;		/* revert to PIO for this request */
 }
@@ -641,7 +640,7 @@ sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 	hw.dev =3D &dev->dev;
 	ide_init_port_hw(hwif, &hw);
=20
-	hwif->pci_dev =3D dev;
+	hwif->dev =3D &dev->dev;
 	hwif->channel =3D 0;	/* Single Channel chip */
=20
 	/* The IOC4 uses MMIO rather than Port IO. */
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index 908f37b..4877bc8 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.19	Nov 16 2007
- *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
  * Copyright (C) 2007		MontaVista Software, Inc.
@@ -79,7 +77,7 @@ static int pdev_is_sata(struct pci_dev *pdev)
 =20
 static inline int is_sata(ide_hwif_t *hwif)
 {
-	return pdev_is_sata(hwif->pci_dev);
+	return pdev_is_sata(to_pci_dev(hwif->dev));
 }
=20
 /**
@@ -140,13 +138,14 @@ static inline unsigned long siimage_seldev(ide_dr=
ive_t *drive, int r)
 static u8 sil_pata_udma_filter(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned long base =3D (unsigned long) hwif->hwif_data;
 	u8 mask =3D 0, scsc =3D 0;
=20
 	if (hwif->mmio)
 		scsc =3D hwif->INB(base + 0x4A);
 	else
-		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
+		pci_read_config_byte(dev, 0x8A, &scsc);
=20
 	if ((scsc & 0x30) =3D=3D 0x10)	/* 133 */
 		mask =3D ATA_UDMA6;
@@ -219,19 +218,21 @@ static void sil_set_pio_mode(ide_drive_t *drive, =
u8 pio)
 		mode |=3D (unit ? 0x10 : 0x01);
 		hwif->OUTB(mode, base + addr_mask);
 	} else {
-		pci_write_config_word(hwif->pci_dev, addr, speedp);
-		pci_write_config_word(hwif->pci_dev, tfaddr, speedt);
-		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
+		struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
+		pci_write_config_word(dev, addr, speedp);
+		pci_write_config_word(dev, tfaddr, speedt);
+		pci_read_config_word(dev, tfaddr - 2, &speedp);
 		speedp &=3D ~0x200;
 		/* Set IORDY for mode 3 or 4 */
 		if (pio > 2)
 			speedp |=3D 0x200;
-		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
+		pci_write_config_word(dev, tfaddr - 2, speedp);
=20
-		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
+		pci_read_config_byte(dev, addr_mask, &mode);
 		mode &=3D ~(unit ? 0x30 : 0x03);
 		mode |=3D (unit ? 0x10 : 0x01);
-		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
+		pci_write_config_byte(dev, addr_mask, mode);
 	}
 }
=20
@@ -250,6 +251,7 @@ static void sil_set_dma_mode(ide_drive_t *drive, co=
nst u8 speed)
 	u16 dma[]		=3D { 0x2208, 0x10C2, 0x10C1 };
=20
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u16 ultra =3D 0, multi	=3D 0;
 	u8 mode =3D 0, unit	=3D drive->select.b.unit;
 	unsigned long base	=3D (unsigned long)hwif->hwif_data;
@@ -266,10 +268,10 @@ static void sil_set_dma_mode(ide_drive_t *drive, =
const u8 speed)
 		multi =3D hwif->INW(ma);
 		ultra =3D hwif->INW(ua);
 	} else {
-		pci_read_config_byte(hwif->pci_dev, 0x8A, &scsc);
-		pci_read_config_byte(hwif->pci_dev, addr_mask, &mode);
-		pci_read_config_word(hwif->pci_dev, ma, &multi);
-		pci_read_config_word(hwif->pci_dev, ua, &ultra);
+		pci_read_config_byte(dev, 0x8A, &scsc);
+		pci_read_config_byte(dev, addr_mask, &mode);
+		pci_read_config_word(dev, ma, &multi);
+		pci_read_config_word(dev, ua, &ultra);
 	}
=20
 	mode &=3D ~((unit) ? 0x30 : 0x03);
@@ -293,9 +295,9 @@ static void sil_set_dma_mode(ide_drive_t *drive, co=
nst u8 speed)
 		hwif->OUTW(multi, ma);
 		hwif->OUTW(ultra, ua);
 	} else {
-		pci_write_config_byte(hwif->pci_dev, addr_mask, mode);
-		pci_write_config_word(hwif->pci_dev, ma, multi);
-		pci_write_config_word(hwif->pci_dev, ua, ultra);
+		pci_write_config_byte(dev, addr_mask, mode);
+		pci_write_config_word(dev, ma, multi);
+		pci_write_config_word(dev, ua, ultra);
 	}
 }
=20
@@ -303,6 +305,7 @@ static void sil_set_dma_mode(ide_drive_t *drive, co=
nst u8 speed)
 static int siimage_io_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 dma_altstat		=3D 0;
 	unsigned long addr	=3D siimage_selreg(hwif, 1);
=20
@@ -311,7 +314,7 @@ static int siimage_io_ide_dma_test_irq (ide_drive_t=
 *drive)
 		return 1;
=20
 	/* return 1 if Device INTR asserted */
-	pci_read_config_byte(hwif->pci_dev, addr, &dma_altstat);
+	pci_read_config_byte(dev, addr, &dma_altstat);
 	if (dma_altstat & 8)
 		return 0;	//return 1;
 	return 0;
@@ -377,13 +380,14 @@ static int siimage_mmio_ide_dma_test_irq (ide_dri=
ve_t *drive)
 static int sil_sata_busproc(ide_drive_t * drive, int state)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u32 stat_config		=3D 0;
 	unsigned long addr	=3D siimage_selreg(hwif, 0);
=20
 	if (hwif->mmio)
 		stat_config =3D readl((void __iomem *)addr);
 	else
-		pci_read_config_dword(hwif->pci_dev, addr, &stat_config);
+		pci_read_config_dword(dev, addr, &stat_config);
=20
 	switch (state) {
 		case BUSSTATE_ON:
@@ -643,7 +647,7 @@ static unsigned int __devinit init_chipset_siimage(=
struct pci_dev *dev, const ch
=20
 static void __devinit init_mmio_iops_siimage(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	void *addr		=3D pci_get_drvdata(dev);
 	u8 ch			=3D hwif->channel;
 	hw_regs_t		hw;
@@ -756,12 +760,14 @@ static void __devinit sil_quirkproc(ide_drive_t *=
drive)
=20
 static void __devinit init_iops_siimage(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	hwif->hwif_data =3D NULL;
=20
 	/* Pessimal until we finish probing */
 	hwif->rqsize =3D 15;
=20
-	if (pci_get_drvdata(hwif->pci_dev) =3D=3D NULL)
+	if (pci_get_drvdata(dev) =3D=3D NULL)
 		return;
=20
 	init_mmio_iops_siimage(hwif);
@@ -777,11 +783,12 @@ static void __devinit init_iops_siimage(ide_hwif_=
t *hwif)
=20
 static u8 __devinit ata66_siimage(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned long addr =3D siimage_selreg(hwif, 0);
 	u8 ata66 =3D 0;
=20
-	if (pci_get_drvdata(hwif->pci_dev) =3D=3D NULL)
-		pci_read_config_byte(hwif->pci_dev, addr, &ata66);
+	if (pci_get_drvdata(dev) =3D=3D NULL)
+		pci_read_config_byte(dev, addr, &ata66);
 	else
 		ata66 =3D hwif->INB(addr);
=20
diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index 85d3699..2a461de 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.31	Aug 9, 2007
- *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintai=
ner
  * Copyright (C) 2003		Vojtech Pavlik <vojtech@suse.cz>
@@ -197,7 +195,7 @@ static char* chipset_capability[] =3D {
=20
 static u8 sis_ata133_get_base(ide_drive_t *drive)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 reg54 =3D 0;
=20
 	pci_read_config_dword(dev, 0x54, &reg54);
@@ -207,7 +205,7 @@ static u8 sis_ata133_get_base(ide_drive_t *drive)
=20
 static void sis_ata16_program_timings(ide_drive_t *drive, const u8 mod=
e)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u16 t1 =3D 0;
 	u8 drive_pci =3D 0x40 + drive->dn * 2;
=20
@@ -230,7 +228,7 @@ static void sis_ata16_program_timings(ide_drive_t *=
drive, const u8 mode)
=20
 static void sis_ata100_program_timings(ide_drive_t *drive, const u8 mo=
de)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u8 t1, drive_pci =3D 0x40 + drive->dn * 2;
=20
 	/* timing bits: 7:4 active 3:0 recovery */
@@ -253,7 +251,7 @@ static void sis_ata100_program_timings(ide_drive_t =
*drive, const u8 mode)
=20
 static void sis_ata133_program_timings(ide_drive_t *drive, const u8 mo=
de)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 t1 =3D 0;
 	u8 drive_pci =3D sis_ata133_get_base(drive), clk, idx;
=20
@@ -286,7 +284,7 @@ static void sis_program_timings(ide_drive_t *drive,=
 const u8 mode)
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 reg4bh		=3D 0;
 	u8 rw_prefetch		=3D 0;
=20
@@ -307,7 +305,7 @@ static void sis_set_pio_mode(ide_drive_t *drive, co=
nst u8 pio)
=20
 static void sis_ata133_program_udma_timings(ide_drive_t *drive, const =
u8 mode)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 regdw =3D 0;
 	u8 drive_pci =3D sis_ata133_get_base(drive), clk, idx;
=20
@@ -326,7 +324,7 @@ static void sis_ata133_program_udma_timings(ide_dri=
ve_t *drive, const u8 mode)
=20
 static void sis_ata33_program_udma_timings(ide_drive_t *drive, const u=
8 mode)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u8 drive_pci =3D 0x40 + drive->dn * 2, reg =3D 0, i =3D chipset_famil=
y;
=20
 	pci_read_config_byte(dev, drive_pci + 1, &reg);
@@ -359,7 +357,7 @@ static void sis_set_dma_mode(ide_drive_t *drive, co=
nst u8 speed)
=20
 static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
 {
-	struct pci_dev *dev =3D drive->hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 regdw =3D 0;
 	u8 drive_pci =3D sis_ata133_get_base(drive);
=20
@@ -530,7 +528,7 @@ static const struct sis_laptop sis_laptop[] =3D {
=20
 static u8 __devinit ata66_sis5513(ide_hwif_t *hwif)
 {
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	const struct sis_laptop *lap =3D &sis_laptop[0];
 	u8 ata66 =3D 0;
=20
@@ -545,12 +543,12 @@ static u8 __devinit ata66_sis5513(ide_hwif_t *hwi=
f)
 	if (chipset_family >=3D ATA_133) {
 		u16 regw =3D 0;
 		u16 reg_addr =3D hwif->channel ? 0x52: 0x50;
-		pci_read_config_word(hwif->pci_dev, reg_addr, &regw);
+		pci_read_config_word(pdev, reg_addr, &regw);
 		ata66 =3D (regw & 0x8000) ? 0 : 1;
 	} else if (chipset_family >=3D ATA_66) {
 		u8 reg48h =3D 0;
 		u8 mask =3D hwif->channel ? 0x20 : 0x10;
-		pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
+		pci_read_config_byte(pdev, 0x48, &reg48h);
 		ata66 =3D (reg48h & mask) ? 0 : 1;
 	}
=20
diff --git a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
index c7a125b..da13a12 100644
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -1,6 +1,4 @@
 /*
- * linux/drivers/ide/pci/sl82c105.c
- *
  * SL82C105/Winbond 553 IDE driver
  *
  * Maintainer unknown.
@@ -78,7 +76,7 @@ static unsigned int get_pio_timings(ide_drive_t *driv=
e, u8 pio)
  */
 static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
 	int reg			=3D 0x44 + drive->dn * 4;
 	u16 drv_ctrl;
=20
@@ -147,7 +145,7 @@ static inline void sl82c105_reset_host(struct pci_d=
ev *dev)
 static void sl82c105_dma_lost_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u32 val, mask		=3D hwif->channel ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
 	u8 dma_cmd;
=20
@@ -184,7 +182,7 @@ static void sl82c105_dma_lost_irq(ide_drive_t *driv=
e)
 static void sl82c105_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int reg 		=3D 0x44 + drive->dn * 4;
=20
 	DBG(("%s(drive:%s)\n", __FUNCTION__, drive->name));
@@ -197,15 +195,17 @@ static void sl82c105_dma_start(ide_drive_t *drive=
)
=20
 static void sl82c105_dma_timeout(ide_drive_t *drive)
 {
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
+
 	DBG(("sl82c105_dma_timeout(drive:%s)\n", drive->name));
=20
-	sl82c105_reset_host(HWIF(drive)->pci_dev);
+	sl82c105_reset_host(dev);
 	ide_dma_timeout(drive);
 }
=20
 static int sl82c105_dma_end(ide_drive_t *drive)
 {
-	struct pci_dev *dev	=3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
 	int reg 		=3D 0x44 + drive->dn * 4;
 	int ret;
=20
@@ -224,7 +224,7 @@ static int sl82c105_dma_end(ide_drive_t *drive)
  */
 static void sl82c105_resetproc(ide_drive_t *drive)
 {
-	struct pci_dev *dev =3D HWIF(drive)->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(drive->hwif->dev);
 	u32 val;
=20
 	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
@@ -293,6 +293,7 @@ static unsigned int __devinit init_chipset_sl82c105=
(struct pci_dev *dev, const c
  */
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	unsigned int rev;
=20
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
@@ -304,7 +305,7 @@ static void __devinit init_hwif_sl82c105(ide_hwif_t=
 *hwif)
 	if (!hwif->dma_base)
 		return;
=20
-	rev =3D sl82c105_bridge_revision(hwif->pci_dev);
+	rev =3D sl82c105_bridge_revision(dev);
 	if (rev <=3D 5) {
 		/*
 		 * Never ever EVER under any circumstances enable
diff --git a/drivers/ide/pci/slc90e66.c b/drivers/ide/pci/slc90e66.c
index dbbb468..a6cf810 100644
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.19	Sep 24, 2007
- *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.c=
om>
  *
@@ -26,7 +24,7 @@ static DEFINE_SPINLOCK(slc90e66_lock);
 static void slc90e66_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	int is_slave		=3D drive->dn & 1;
 	int master_port		=3D hwif->channel ? 0x42 : 0x40;
 	int slave_port		=3D 0x44;
@@ -79,7 +77,7 @@ static void slc90e66_set_pio_mode(ide_drive_t *drive,=
 const u8 pio)
 static void slc90e66_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
-	struct pci_dev *dev	=3D hwif->pci_dev;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	u8 maslave		=3D hwif->channel ? 0x42 : 0x40;
 	int sitre =3D 0, a_speed	=3D 7 << (drive->dn * 4);
 	int u_speed =3D 0, u_flag =3D 1 << drive->dn;
@@ -122,13 +120,14 @@ static void slc90e66_set_dma_mode(ide_drive_t *dr=
ive, const u8 speed)
=20
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 reg47 =3D 0;
 	u8 mask =3D hwif->channel ? 0x01 : 0x02;  /* bit0:Primary */
=20
 	hwif->set_pio_mode =3D &slc90e66_set_pio_mode;
 	hwif->set_dma_mode =3D &slc90e66_set_dma_mode;
=20
-	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
+	pci_read_config_byte(dev, 0x47, &reg47);
=20
 	if (hwif->dma_base =3D=3D 0)
 		return;
diff --git a/drivers/ide/pci/tc86c001.c b/drivers/ide/pci/tc86c001.c
index e1faf6c..9fbbb4f 100644
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -1,6 +1,4 @@
 /*
- * drivers/ide/pci/tc86c001.c	Version 1.01	Sep 5, 2007
- *
  * Copyright (C) 2002 Toshiba Corporation
  * Copyright (C) 2005-2006 MontaVista Software, Inc. <source@mvista.co=
m>
  *
@@ -164,7 +162,8 @@ static int tc86c001_busproc(ide_drive_t *drive, int=
 state)
=20
 static void __devinit init_hwif_tc86c001(ide_hwif_t *hwif)
 {
-	unsigned long sc_base	=3D pci_resource_start(hwif->pci_dev, 5);
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
+	unsigned long sc_base	=3D pci_resource_start(dev, 5);
 	u16 scr1		=3D inw(sc_base + 0x00);
=20
 	/* System Control 1 Register bit 15 (Soft Reset) set */
diff --git a/drivers/ide/pci/triflex.c b/drivers/ide/pci/triflex.c
index ae52a96..852b726 100644
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -1,6 +1,4 @@
 /*
- * triflex.c
- *=20
  * IDE Chipset driver for the Compaq TriFlex IDE controller.
  *=20
  * Known to work with the Compaq Workstation 5x00 series.
@@ -43,7 +41,7 @@
 static void triflex_set_mode(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	u8 channel_offset =3D hwif->channel ? 0x74 : 0x70;
 	u16 timing =3D 0;
 	u32 triflex_timings =3D 0;
diff --git a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
index 04cd893..d9ebb69 100644
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -1,8 +1,7 @@
 /*
- *  linux/drivers/ide/pci/trm290.c		Version 1.05	Dec. 26, 2007
- *
  *  Copyright (c) 1997-1998  Mark Lord
  *  Copyright (c) 2007       MontaVista Software, Inc. <source@mvista.=
com>
+ *
  *  May be copied or modified under the terms of the GNU General Publi=
c License
  *
  *  June 22, 2004 - get rid of check_region
@@ -209,10 +208,10 @@ static int trm290_dma_setup(ide_drive_t *drive)
 	}
 	/* select DMA xfer */
 	trm290_prepare_drive(drive, 1);
-	outl(hwif->dmatable_dma | rw, hwif->dma_command);
+	outl(hwif->dmatable_dma | rw, hwif->dma_base);
 	drive->waiting_for_dma =3D 1;
 	/* start DMA */
-	outw((count * 2) - 1, hwif->dma_status);
+	outw(count * 2 - 1, hwif->dma_base + 2);
 	return 0;
 }
=20
@@ -222,23 +221,21 @@ static void trm290_dma_start(ide_drive_t *drive)
=20
 static int trm290_ide_dma_end (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif =3D HWIF(drive);
-	u16 status =3D 0;
+	u16 status;
=20
 	drive->waiting_for_dma =3D 0;
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
-	status =3D inw(hwif->dma_status);
-	return (status !=3D 0x00ff);
+	status =3D inw(HWIF(drive)->dma_base + 2);
+	return status !=3D 0x00ff;
 }
=20
 static int trm290_ide_dma_test_irq (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif =3D HWIF(drive);
-	u16 status =3D 0;
+	u16 status;
=20
-	status =3D inw(hwif->dma_status);
-	return (status =3D=3D 0x00ff);
+	status =3D inw(HWIF(drive)->dma_base + 2);
+	return status =3D=3D 0x00ff;
 }
=20
 static void trm290_dma_host_set(ide_drive_t *drive, int on)
@@ -247,21 +244,37 @@ static void trm290_dma_host_set(ide_drive_t *driv=
e, int on)
=20
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
-	unsigned int cfgbase =3D 0;
+	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
+	unsigned int  cfg_base	=3D pci_resource_start(dev, 4);
 	unsigned long flags;
 	u8 reg =3D 0;
-	struct pci_dev *dev =3D hwif->pci_dev;
-
-	cfgbase =3D pci_resource_start(dev, 4);
-	if ((dev->class & 5) && cfgbase) {
-		hwif->config_data =3D cfgbase;
-		printk(KERN_INFO "TRM290: chip config base at 0x%04lx\n",
-			hwif->config_data);
-	} else {
-		hwif->config_data =3D 0x3df0;
-		printk(KERN_INFO "TRM290: using default config base at 0x%04lx\n",
-			hwif->config_data);
+
+	if ((dev->class & 5) && cfg_base)
+		printk(KERN_INFO "TRM290: chip");
+	else {
+		cfg_base =3D 0x3df0;
+		printk(KERN_INFO "TRM290: using default");
 	}
+	printk(KERN_CONT " config base at 0x%04x\n", cfg_base);
+	hwif->config_data =3D cfg_base;
+	hwif->dma_base =3D (cfg_base + 4) ^ (hwif->channel ? 0x80 : 0);
+
+	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+	       hwif->name, hwif->dma_base, hwif->dma_base + 3);
+
+	if (!request_region(hwif->dma_base, 4, hwif->name)) {
+		printk(KERN_CONT " -- Error, ports in use.\n");
+		return;
+	}
+
+	hwif->dmatable_cpu =3D pci_alloc_consistent(dev, PRD_ENTRIES * PRD_BY=
TES,
+						  &hwif->dmatable_dma);
+	if (!hwif->dmatable_cpu) {
+		printk(KERN_CONT " -- Error, unable to allocate DMA table.\n");
+		release_region(hwif->dma_base, 4);
+		return;
+	}
+	printk(KERN_CONT "\n");
=20
 	local_irq_save(flags);
 	/* put config reg into first byte of hwif->select_data */
@@ -276,15 +289,13 @@ static void __devinit init_hwif_trm290(ide_hwif_t=
 *hwif)
 	outb(reg, hwif->config_data + 3);
 	local_irq_restore(flags);
=20
-	if ((reg & 0x10))
+	if (reg & 0x10)
 		/* legacy mode */
 		hwif->irq =3D hwif->channel ? 15 : 14;
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		/* sharing IRQ with mate */
 		hwif->irq =3D hwif->mate->irq;
=20
-	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080=
 : 0x0000), 3);
-
 	hwif->dma_host_set	=3D &trm290_dma_host_set;
 	hwif->dma_setup 	=3D &trm290_dma_setup;
 	hwif->dma_exec_cmd	=3D &trm290_dma_exec_cmd;
diff --git a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
index 4b32c90..24cb904 100644
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -1,7 +1,4 @@
 /*
- *
- * Version 3.50
- *
  * VIA IDE driver for Linux. Supported southbridges:
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
@@ -121,8 +118,8 @@ struct via82cxxx_dev
=20
 static void via_set_speed(ide_hwif_t *hwif, u8 dn, struct ide_timing *=
timing)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
-	struct via82cxxx_dev *vdev =3D pci_get_drvdata(hwif->pci_dev);
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+	struct via82cxxx_dev *vdev =3D pci_get_drvdata(dev);
 	u8 t;
=20
 	if (~vdev->via_config->flags & VIA_BAD_AST) {
@@ -159,8 +156,10 @@ static void via_set_speed(ide_hwif_t *hwif, u8 dn,=
 struct ide_timing *timing)
=20
 static void via_set_drive(ide_drive_t *drive, const u8 speed)
 {
-	ide_drive_t *peer =3D HWIF(drive)->drives + (~drive->dn & 1);
-	struct via82cxxx_dev *vdev =3D pci_get_drvdata(drive->hwif->pci_dev);
+	ide_hwif_t *hwif =3D drive->hwif;
+	ide_drive_t *peer =3D hwif->drives + (~drive->dn & 1);
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+	struct via82cxxx_dev *vdev =3D pci_get_drvdata(dev);
 	struct ide_timing t, p;
 	unsigned int T, UT;
=20
@@ -408,7 +407,7 @@ static int via_cable_override(struct pci_dev *pdev)
=20
 static u8 __devinit via82cxxx_cable_detect(ide_hwif_t *hwif)
 {
-	struct pci_dev *pdev =3D hwif->pci_dev;
+	struct pci_dev *pdev =3D to_pci_dev(hwif->dev);
 	struct via82cxxx_dev *vdev =3D pci_get_drvdata(pdev);
=20
 	if (via_cable_override(pdev))
diff --git a/drivers/ide/ppc/mpc8xx.c b/drivers/ide/ppc/mpc8xx.c
index 3fd5d45..45c1d55 100644
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -1,6 +1,4 @@
 /*
- *  linux/drivers/ide/ppc/ide-m8xx.c
- *
  *  Copyright (C) 2000, 2001 Wolfgang Denk, wd@denx.de
  *  Modified for direct IDE interface
  *	by Thomas Lange, thomas@corelatus.com
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 736d12c..23112ef 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1,7 +1,6 @@
 /*
- * linux/drivers/ide/ppc/pmac.c
- *
  * Support for IDE interfaces on PowerMacs.
+ *
  * These IDE interfaces are memory-mapped and have a DBDMA channel
  * for doing DMA.
  *
@@ -1011,7 +1010,7 @@ pmac_ide_do_resume(ide_hwif_t *hwif)
  * (it is kept in 2.4). This introduce an interface numbering change o=
n some
  * rare machines unfortunately, but it's better this way.
  */
-static int
+static int __devinit
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs=
_t *hw)
 {
 	struct device_node *np =3D pmif->node;
@@ -1200,7 +1199,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, con=
st struct of_device_id *match)
 	base =3D ioremap(macio_resource_start(mdev, 0), 0x400);
 	regbase =3D (unsigned long) base;
=20
-	hwif->pci_dev =3D mdev->bus->pdev;
+	hwif->dev =3D &mdev->bus->pdev->dev;
=20
 	pmif->mdev =3D mdev;
 	pmif->node =3D mdev->ofdev.node;
@@ -1228,12 +1227,12 @@ pmac_ide_macio_attach(struct macio_dev *mdev, c=
onst struct of_device_id *match)
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
 		iounmap(base);
-		if (pmif->dma_regs)
+		if (pmif->dma_regs) {
 			iounmap(pmif->dma_regs);
+			macio_release_resource(mdev, 1);
+		}
 		memset(pmif, 0, sizeof(*pmif));
 		macio_release_resource(mdev, 0);
-		if (pmif->dma_regs)
-			macio_release_resource(mdev, 1);
 	}
=20
 	return rc;
@@ -1315,7 +1314,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 		return -ENXIO;
 	}
=20
-	hwif->pci_dev =3D pdev;
+	hwif->dev =3D &pdev->dev;
 	pmif->mdev =3D NULL;
 	pmif->node =3D np;
=20
@@ -1535,11 +1534,10 @@ pmac_ide_build_dmatable(ide_drive_t *drive, str=
uct request *rq)
 	}
=20
 	printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
- use_pio_instead:
-	pci_unmap_sg(hwif->pci_dev,
-		     hwif->sg_table,
-		     hwif->sg_nents,
-		     hwif->sg_dma_direction);
+
+use_pio_instead:
+	ide_destroy_dmatable(drive);
+
 	return 0; /* revert to PIO for this request */
 }
=20
@@ -1548,12 +1546,9 @@ static void
 pmac_ide_destroy_dmatable (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif =3D drive->hwif;
-	struct pci_dev *dev =3D HWIF(drive)->pci_dev;
-	struct scatterlist *sg =3D hwif->sg_table;
-	int nents =3D hwif->sg_nents;
=20
-	if (nents) {
-		pci_unmap_sg(dev, sg, nents, hwif->sg_dma_direction);
+	if (hwif->sg_nents) {
+		ide_destroy_dmatable(drive);
 		hwif->sg_nents =3D 0;
 	}
 }
@@ -1726,13 +1721,15 @@ pmac_ide_dma_lost_irq (ide_drive_t *drive)
  * Allocate the data structures needed for using DMA with an interface
  * and fill the proper list of functions pointers
  */
-static void __init=20
+static void __devinit
 pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 {
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+
 	/* We won't need pci_dev if we switch to generic consistent
 	 * DMA routines ...
 	 */
-	if (hwif->pci_dev =3D=3D NULL)
+	if (dev =3D=3D NULL)
 		return;
 	/*
 	 * Allocate space for the DBDMA commands.
@@ -1740,7 +1737,7 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwi=
f_t *hwif)
 	 * aligning the start address to a multiple of 16 bytes.
 	 */
 	pmif->dma_table_cpu =3D (struct dbdma_cmd*)pci_alloc_consistent(
-		hwif->pci_dev,
+		dev,
 		(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
 		&hwif->dmatable_dma);
 	if (pmif->dma_table_cpu =3D=3D NULL) {
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index 676c66e..8ff5a0e 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -1,9 +1,8 @@
 /*
- *  linux/drivers/ide/setup-pci.c		Version 1.10	2002/08/19
+ *  Copyright (C) 1998-2000  Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 1995-1998  Mark Lord
+ *  Copyright (C)      2007  Bartlomiej Zolnierkiewicz
  *
- *  Copyright (c) 1998-2000  Andre Hedrick <andre@linux-ide.org>
- *
- *  Copyright (c) 1995-1998  Mark Lord
  *  May be copied or modified under the terms of the GNU General Publi=
c License
  */
=20
@@ -140,6 +139,16 @@ static int ide_setup_pci_baseregs (struct pci_dev =
*dev, const char *name)
 }
=20
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
+static void ide_pci_clear_simplex(unsigned long dma_base, const char *=
name)
+{
+	u8 dma_stat =3D inb(dma_base + 2);
+
+	outb(dma_stat & 0x60, dma_base + 2);
+	dma_stat =3D inb(dma_base + 2);
+	if (dma_stat & 0x80)
+		printk(KERN_INFO "%s: simplex device: DMA forced\n", name);
+}
+
 /**
  *	ide_get_or_set_dma_base		-	setup BMIBA
  *	@d: IDE port info
@@ -152,8 +161,9 @@ static int ide_setup_pci_baseregs (struct pci_dev *=
dev, const char *name)
=20
 static unsigned long ide_get_or_set_dma_base(const struct ide_port_inf=
o *d, ide_hwif_t *hwif)
 {
-	unsigned long	dma_base =3D 0;
-	struct pci_dev	*dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
+	unsigned long dma_base =3D 0;
+	u8 dma_stat =3D 0;
=20
 	if (hwif->mmio)
 		return hwif->dma_base;
@@ -174,52 +184,30 @@ static unsigned long ide_get_or_set_dma_base(cons=
t struct ide_port_info *d, ide_
 	if (hwif->channel)
 		dma_base +=3D 8;
=20
-	if ((d->host_flags & IDE_HFLAG_CS5520) =3D=3D 0) {
-		u8 simplex_stat =3D 0;
-
-		switch(dev->device) {
-			case PCI_DEVICE_ID_AL_M5219:
-			case PCI_DEVICE_ID_AL_M5229:
-			case PCI_DEVICE_ID_AMD_VIPER_7409:
-			case PCI_DEVICE_ID_CMD_643:
-			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
-			case PCI_DEVICE_ID_REVOLUTION:
-				simplex_stat =3D inb(dma_base + 2);
-				outb(simplex_stat & 0x60, dma_base + 2);
-				simplex_stat =3D inb(dma_base + 2);
-				if (simplex_stat & 0x80) {
-					printk(KERN_INFO "%s: simplex device: "
-							 "DMA forced\n",
-							 d->name);
-				}
-				break;
-			default:
-				/*
-				 * If the device claims "simplex" DMA,
-				 * this means only one of the two interfaces
-				 * can be trusted with DMA at any point in time.
-				 * So we should enable DMA only on one of the
-				 * two interfaces.
-				 */
-				simplex_stat =3D hwif->INB(dma_base + 2);
-				if (simplex_stat & 0x80) {
-					/* simplex device? */
-/*
- *	At this point we haven't probed the drives so we can't make the
- *	appropriate decision. Really we should defer this problem
- *	until we tune the drive then try to grab DMA ownership if we want
- *	to be the DMA end. This has to be become dynamic to handle hot
- *	plug.
- */
-					if (hwif->mate && hwif->mate->dma_base) {
-						printk(KERN_INFO "%s: simplex device: "
-								 "DMA disabled\n",
-								 d->name);
-						dma_base =3D 0;
-					}
-				}
-		}
+	if (d->host_flags & IDE_HFLAG_CS5520)
+		goto out;
+
+	if (d->host_flags & IDE_HFLAG_CLEAR_SIMPLEX) {
+		ide_pci_clear_simplex(dma_base, d->name);
+		goto out;
+	}
+
+	/*
+	 * If the device claims "simplex" DMA, this means that only one of
+	 * the two interfaces can be trusted with DMA at any point in time
+	 * (so we should enable DMA only on one of the two interfaces).
+	 *
+	 * FIXME: At this point we haven't probed the drives so we can't make
+	 * the appropriate decision.  Really we should defer this problem unt=
il
+	 * we tune the drive then try to grab DMA ownership if we want to be
+	 * the DMA end.  This has to be become dynamic to handle hot-plug.
+	 */
+	dma_stat =3D hwif->INB(dma_base + 2);
+	if ((dma_stat & 0x80) && hwif->mate && hwif->mate->dma_base) {
+		printk(KERN_INFO "%s: simplex device: DMA disabled\n", d->name);
+		dma_base =3D 0;
 	}
+out:
 	return dma_base;
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
@@ -402,7 +390,7 @@ static ide_hwif_t *ide_hwif_configure(struct pci_de=
v *dev, const struct ide_port
=20
 	hwif->noprobe =3D oldnoprobe;
=20
-	hwif->pci_dev =3D dev;
+	hwif->dev =3D &dev->dev;
 	hwif->cds =3D d;
 	hwif->channel =3D port;
=20
@@ -451,7 +439,7 @@ static void ide_hwif_setup_dma(struct pci_dev *dev,=
 const struct ide_port_info *
 			if (d->init_dma) {
 				d->init_dma(hwif, dma_base);
 			} else {
-				ide_setup_dma(hwif, dma_base, 8);
+				ide_setup_dma(hwif, dma_base);
 			}
 		} else {
 			printk(KERN_INFO "%s: %s Bus-Master DMA disabled "
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index db8bc20..5ed0006 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -1,7 +1,6 @@
 /*
- * linux/drivers/scsi/ide-scsi.c	Version 0.9		Jul   4, 1999
- *
- * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 1996-1999  Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2004-2005  Bartlomiej Zolnierkiewicz
  */
=20
 /*
diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mi=
ps/mach-au1x00/au1xxx_ide.h
index aef0edb..e4fe26c 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -74,7 +74,6 @@ typedef struct
         struct dbdma_cmd        *dma_table_cpu;
         dma_addr_t              dma_table_dma;
 #endif
-        struct device           *dev;
 	int			irq;
 	u32			regbase;
 #ifdef CONFIG_PM
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index fcdc11b..a5cd204 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -1187,6 +1187,20 @@ struct media_event_desc {
=20
 extern int cdrom_get_media_event(struct cdrom_device_info *cdi, struct=
 media_event_desc *med);
=20
+static inline void lba_to_msf(int lba, u8 *m, u8 *s, u8 *f)
+{
+	lba +=3D CD_MSF_OFFSET;
+	lba &=3D 0xffffff;  /* negative lbas use only 24 bits */
+	*m =3D lba / (CD_SECS * CD_FRAMES);
+	lba %=3D (CD_SECS * CD_FRAMES);
+	*s =3D lba / CD_FRAMES;
+	*f =3D lba % CD_FRAMES;
+}
+
+static inline int msf_to_lba(u8 m, u8 s, u8 f)
+{
+	return (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
+}
 #endif  /* End of kernel only stuff */=20
=20
 #endif  /* _LINUX_CDROM_H */
diff --git a/include/linux/hdsmart.h b/include/linux/hdsmart.h
index 7974a47..e691921 100644
--- a/include/linux/hdsmart.h
+++ b/include/linux/hdsmart.h
@@ -17,6 +17,7 @@
 #ifndef _LINUX_HDSMART_H
 #define _LINUX_HDSMART_H
=20
+#ifndef __KERNEL
 #define OFFLINE_FULL_SCAN		0
 #define SHORT_SELF_TEST			1
 #define EXTEND_SELF_TEST		2
@@ -120,5 +121,6 @@ typedef struct ata_smart_selftestlog_s {
 	unsigned char			resevered[2];
 	unsigned char			chksum;
 } __attribute__ ((packed)) ata_smart_selftestlog_t;
+#endif /* __KERNEL__ *
=20
 #endif	/* _LINUX_HDSMART_H */
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 27cb39d..ec10b2a 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/hdreg.h>
-#include <linux/hdsmart.h>
 #include <linux/blkdev.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
@@ -503,7 +502,8 @@ typedef struct hwif_s {
=20
 	hwif_chipset_t chipset;	/* sub-module for tuning.. */
=20
-	struct pci_dev  *pci_dev;	/* for pci chipsets */
+	struct device *dev;
+
 	const struct ide_port_info *cds;	/* chipset device struct */
=20
 	ide_ack_intr_t *ack_intr;
@@ -628,8 +628,7 @@ typedef int (ide_expiry_t)(ide_drive_t *);
 typedef struct hwgroup_s {
 		/* irq handler, if active */
 	ide_startstop_t	(*handler)(ide_drive_t *);
-		/* irq handler, suspended if active */
-	ide_startstop_t	(*handler_save)(ide_drive_t *);
+
 		/* BOOL: protects all fields below */
 	volatile int busy;
 		/* BOOL: wake us up on timer expiry */
@@ -644,25 +643,18 @@ typedef struct hwgroup_s {
 		/* ptr to current hwif in linked-list */
 	ide_hwif_t *hwif;
=20
-		/* for pci chipsets */
-	struct pci_dev *pci_dev;
-
 		/* current request */
 	struct request *rq;
+
 		/* failsafe timer */
 	struct timer_list timer;
-		/* local copy of current write rq */
-	struct request wrq;
 		/* timeout value during long polls */
 	unsigned long poll_timeout;
 		/* queried upon timeouts */
 	int (*expiry)(ide_drive_t *);
-		/* ide_system_bus_speed */
-	int pio_clock;
+
 	int req_gen;
 	int req_gen_timer;
-
-	unsigned char cmd_buf[4];
 } ide_hwgroup_t;
=20
 typedef struct ide_driver_s ide_driver_t;
@@ -986,8 +978,6 @@ ide_startstop_t do_rw_taskfile(ide_drive_t *, ide_t=
ask_t *);
=20
 void task_end_request(ide_drive_t *, struct request *, u8);
=20
-u8 wait_drive_not_busy(ide_drive_t *);
-
 int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *, u16);
 int ide_no_data_taskfile(ide_drive_t *, ide_task_t *);
=20
@@ -1017,7 +1007,6 @@ void ide_init_disk(struct gendisk *, ide_drive_t =
*);
=20
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
 extern int ide_scan_direction;
-int __init ide_scan_pcibus(void);
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct=
 module *owner, const char *mod_name);
 #define ide_pci_register_driver(d) __ide_pci_register_driver(d, THIS_M=
ODULE, KBUILD_MODNAME)
 #else
@@ -1096,6 +1085,10 @@ enum {
 	IDE_HFLAG_ABUSE_SET_DMA_MODE	=3D (1 << 26),
 	/* host is CY82C693 */
 	IDE_HFLAG_CY82C693		=3D (1 << 27),
+	/* force host out of "simplex" mode */
+	IDE_HFLAG_CLEAR_SIMPLEX		=3D (1 << 28),
+	/* DSC overlap is unsupported */
+	IDE_HFLAG_NO_DSC		=3D (1 << 29),
 };
=20
 #ifdef CONFIG_BLK_DEV_OFFBOARD
@@ -1153,12 +1146,13 @@ void ide_dma_on(ide_drive_t *);
 int ide_set_dma(ide_drive_t *);
 ide_startstop_t ide_dma_intr(ide_drive_t *);
=20
+int ide_build_sglist(ide_drive_t *, struct request *);
+void ide_destroy_dmatable(ide_drive_t *);
+
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-extern int ide_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
-extern void ide_destroy_dmatable(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
-extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
+extern void ide_setup_dma(ide_hwif_t *, unsigned long);
=20
 void ide_dma_host_set(ide_drive_t *, int);
 extern int ide_dma_setup(ide_drive_t *);
@@ -1197,6 +1191,7 @@ static inline void ide_acpi_init(ide_hwif_t *hwif=
) { ; }
 static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 #endif
=20
+void ide_remove_port_from_hwgroup(ide_hwif_t *);
 extern int ide_hwif_request_regions(ide_hwif_t *hwif);
 extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);
@@ -1291,9 +1286,14 @@ extern struct bus_type ide_bus_type;
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) =3D=3D 0x2400)
=20
+static inline void ide_dump_identify(u8 *id)
+{
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 2, id, 512, 0);
+}
+
 static inline int hwif_to_node(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev =3D hwif->pci_dev;
+	struct pci_dev *dev =3D to_pci_dev(hwif->dev);
 	return dev ? pcibus_to_node(dev->bus) : -1;
 }
=20
