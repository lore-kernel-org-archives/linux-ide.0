From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 15/63] ide-cd: move historical changelog to Documentation/ide/ChangeLog.ide-cd.1994-2004
Date: Thu, 20 Dec 2007 02:03:42 +0100
Message-ID: <200712200203.42421.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:12147 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbXLTBeR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389253ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ide/ChangeLog.ide-cd.1994-2004 |  268 ++++++++++++++++++=
++++++++
 drivers/ide/ide-cd.c                         |  274 ------------------=
---------
 2 files changed, 272 insertions(+), 270 deletions(-)

Index: b/Documentation/ide/ChangeLog.ide-cd.1994-2004
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
Index: b/drivers/ide/ide-cd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -28,276 +28,10 @@
  * -Make it so that Pioneer CD DR-A24X and friends don't get screwed u=
p on
  *   boot
  *
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
- *                        from Ben Galliart <bgallia@luc.edu> with
- *                        special help from Jeff Lightfoot
- *                        <jeffml@pobox.com>
- * 3.15a July 9, 1996 -- Improved Sanyo 3 CD changer identification
- * 3.16  Jul 28, 1996 -- Fix from Gadi to reduce kernel stack usage fo=
r ioctl.
- * 3.17  Sep 17, 1996 -- Tweak audio reads for some drives.
- *                       Start changing CDROMLOADFROMSLOT to CDROM_SEL=
ECT_DISC.
- * 3.18  Oct 31, 1996 -- Added module and DMA support.
- *
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
BLE
- *                          ioctls in favor of a generalized approach
- *                          using the generic cdrom driver.
- *                     -- Fully integrated with the 2.1.X kernel.
- *                     -- Other stuff that I forgot (lots of changes)
- *
- * 4.02  Dec 01, 1996  -- Applied patch from Gadi Oxman <gadio@netvisi=
on.net.il>
- *                          to fix the drive door locking problems.
- *
- * 4.03  Dec 04, 1996  -- Added DSC overlap support.
- * 4.04  Dec 29, 1996  -- Added CDROMREADRAW ioclt based on patch
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
- *                         based on a patch for 2.0.33 by Jelle Foks
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
ed is
- *                         now set ionly for CD-R and CD-RW drives.  I=
 had
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
s,
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
- *			  failed the capabilities
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
+ * For historical changelog please see:
+ *	Documentation/ide/ChangeLog.ide-cd.1994-2004
+ */
+
 #define IDECD_VERSION "4.61"
=20
 #include <linux/module.h>
