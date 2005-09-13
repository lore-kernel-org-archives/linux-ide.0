From: Tejun Heo <htejun@gmail.com>
Subject: [RFC PATCH] Documentation/ata/ata_exceptions.txt
Date: Tue, 13 Sep 2005 10:53:52 +0900
Message-ID: <20050913015352.GA400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:4224 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932302AbVIMByC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Sep 2005 21:54:02 -0400
Received: by zproxy.gmail.com with SMTP id i11so1755086nzi
        for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2005 18:54:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

 Hello, guys.

 This document is an updated version of the following as per Jeff's
comments.

 http://marc.theaimsgroup.com/?l=linux-ide&m=112512101431858&w=2

 Changes are.

 - Reorganized error categories as Jeff suggested.
 - Media error handling updated (ATA cannot do partial completion)
 - Other misc updates

 IMHO, it would be helpful to include this document under
Documentation, so the patch form.  Note that new subdirectory ata is
created.  I'm planning on putting libata_eh doc under this directory
too.  I've chosen to keep plain text format over DocBook as it's more
accessible and easier to update.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/Documentation/ata/ata_exceptions.txt b/Documentation/ata/ata_exceptions.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/ata/ata_exceptions.txt
@@ -0,0 +1,419 @@
+ATA errors & exceptions
+======================================
+
+ This document tries to identify what error/exception conditions exist
+for ATA/ATAPI devices and describe how they should be handled in
+implementation-neutral way.
+
+TABLE OF CONTENTS
+
+[1] Overview
+[2] Exception categories
+    [2-1] HSM violation
+    [2-2] ATA/ATAPI device error (non-NCQ / non-CHECK CONDITION)
+    [2-3] ATAPI device CHECK CONDITION
+    [2-4] ATA device error (NCQ)
+    [2-5] ATA bus error
+    [2-6] PCI bus error
+    [2-7] Late completion
+    [2-8] Unknown error (timeout)
+    [2-9] Hotplug and power management exceptions
+[3] EH recovery actions
+    [3-1] Clearing error condition
+    [3-2] Reset
+    [3-3] Reconfigure transport
+[4] History / Credits
+
+
+[1] Overview
+
+ The term 'error' is used to describe conditions where either an
+explicit error condition is reported from device or a command has
+timed out.
+
+ The term 'exception' is either used to describe exceptional
+conditions which are not errors (say, power or hotplug events), or to
+describe both errors and non-error exceptional conditions.  Where
+explicit distinction between error and exception is necessary, the
+term 'non-error exception' is used.
+
+
+[2] Exception categories
+
+ Exceptions are described primarily with respect to legacy taskfile +
+bus master IDE interface.  If a controller provides other better
+mechanism for error reporting, mapping those into categories described
+below shouldn't be difficult.
+
+ In the following sections, two recovery actions - reset and
+reconfiguring transport - are mentioned.  These are described further
+in [3].
+
+
+[2-1] HSM violation
+
+ This error is indicated when STATUS value doesn't match HSM
+requirement during issuing or excution any ATA/ATAPI command.
+
+ex) ATA_STATUS doesn't contain !BSY && DRDY && !DRQ while trying to
+    issue a command.
+
+ex) !BSY && !DRQ during PIO data transfer.
+
+ex) DRQ on command completion.
+
+ex) !BSY && ERR after CDB tranfer starts but before the last byte of
+    CDB is transferred.  ATA/ATAPI standard states that "The device
+    shall not terminate the PACKET command with an error before the
+    last byte of the command packet has been written" in the error
+    outputs description of PACKET command and the state diagram
+    doesn't include such transitions.
+
+ In these cases, HSM is violated and not much information regarding
+the error can be acquired from STATUS or ERROR register.  IOW, this
+error can be anything - driver bug, faulty device, controller and/or
+cable.
+
+ As HSM is violated, reset is necessary to restore known state.
+Reconfiguring transport for lower speed might be helpful too as
+transmission errors sometimes cause this kind of errors.
+
+
+[2-2] ATA/ATAPI device error (non-NCQ / non-CHECK CONDITION)
+
+ These are errors detected and reported by ATA/ATAPI devices
+indicating device problems.  For this type of errors, STATUS and ERROR
+register values are valid and describe error condition.  Note that
+some of ATA bus errors are detected by ATA/ATAPI devices and reported
+using the same mechanism as device errors.  Those cases are described
+later in this section.
+
+ For ATA commands, this type of errors are indicated by !BSY && ERR
+during command execution and on completion.
+
+ For ATAPI commands,
+
+ a. !BSY && ERR && ABRT right after issuing PACKET indicates that
+    PACKET command is not supported and falls in this category.
+
+ b. !BSY && ERR(==CHK) && !ABRT after the last byte of CDB is
+    transferred indicates CHECK CONDITION and doesn't fall in this
+    category.
+
+ c. !BSY && ERR(==CHK) && ABRT after the last byte of CDB is
+    transferred *probably* indicates CHECK CONDITION and doesn't fall
+    in this category.
+
+ Of errors detected as above, the followings are not ATA/ATAPI device
+errors but ATA bus errors and should be handled according to [2-5] ATA
+bus error.
+
+ a. CRC error during data transfer
+
+    This is indicated by ICRC bit in the ERROR register and means that
+    corruption occurred during data transfer.  Upto ATA/ATAPI-7, the
+    standard specifies that this bit is only applicable to UDMA
+    transfers but ATA/ATAPI-8 draft revision 1f says that the bit may
+    be applicable to multiword DMA and PIO.
+
+ b. ABRT error during data transfer or on completion
+
+    Upto ATA/ATAPI-7, the standard specifies that ABRT could be set on
+    ICRC errors and on cases where a device is not able to complete a
+    command.  Combined with the fact that MWDMA and PIO transfer
+    errors aren't allowed to use ICRC bit upto ATA/ATAPI-7, it seems
+    to imply that ABRT bit alone could indicate tranfer errors.
+
+    However, ATA/ATAPI-8 draft revision 1f removes the part that ICRC
+    errors can turn on ABRT.  So, this is kind of gray area.  Some
+    heuristics are needed here.
+
+ ATA/ATAPI device errors can be further categorized as follows.
+
+ a. Media errors
+
+    This is indicated by UNC bit in the ERROR register.  ATA devices
+    reports UNC error only after certain number of retries cannot
+    recover the data, so there's nothing much else to do other than
+    notifying upper layer.
+
+    READ and WRITE commands report CHS or LBA of the first failed
+    sector but ATA/ATAPI standard specifies that the amount of
+    transferred data on error completion is indeterminate, so we
+    cannot assume that sectors preceding the failed sector have been
+    transferred and thus cannot complete those sectors successfully as
+    SCSI does.
+
+ b. Media changed / media change requested error
+
+    <<TODO: fill here>>
+
+ c. Address error
+
+    This is indicated by IDNF bit in the ERROR register.  Report to
+    upper layer.
+
+ d. Other errors
+
+    This can be invalid command or parameter indicated by ABRT ERROR
+    bit or some other error condition.  Note that ABRT bit can
+    indicate a lot of things including ICRC and Address errors.
+    Heuristics needed.
+
+ Depending on commands, not all STATUS/ERROR bits are applicable.
+These non-applicable bits are marked with "na" in the output
+descriptions but upto ATA/ATAPI-7 no definition of "na" can be found.
+However, ATA/ATAPI-8 draft revision 1f describes "N/A" as follows.
+
+ 3.2.3.3a N/A: A keyword the indicates a field has no defined value in
+               this standard and should not be checked by the host or
+               device. N/A fields should be cleared to zero.
+
+ So, it seems reasonable to assume that "na" bits are cleared to zero
+by devices and thus need no explicit masking.
+
+
+[2-3] ATAPI device CHECK CONDITION
+
+ ATAPI device CHECK CONDITION error is indicated by set CHK bit (ERR
+bit) in the STATUS register after the last byte of CDB is transferred
+for a PACKET command.  For this kind of errors, sense data should be
+acquired to gather information regarding the errors.  REQUEST SENSE
+packet command should be used to acquire sense data.
+
+ Once sense data is acquired, this type of errors can be handled
+similary to other SCSI errors.  Note that sense data may indicate ATA
+bus error (e.g. Sense Key 04h HARDWARE ERROR && ASC/ASCQ 47h/00h SCSI
+PARITY ERROR).  In such cases, the error should be considered as an
+ATA bus error and handled according to [2-5] ATA bus error.
+
+
+[2-4] ATA device error (NCQ)
+
+  NCQ command error is indicated by cleared BSY and set ERR bit during
+NCQ command phase (one or more NCQ commands outstanding).  Although
+STATUS and ERROR registers will contain valid values describing the
+error, READ LOG EXT is required to clear the error condition,
+determine which command has failed and acquire more information.
+
+ READ LOG EXT Log Page 10h reports which tag has failed and taskfile
+register values describing the error.  With this information the
+failed command can be handled as a normal ATA command error as in
+[2-2] and all other in-flight commands must be retried.  Note that
+this retry should not be counted - it's likely that commands retried
+this way would have completed normally if it were not for the failed
+command.
+
+ Note that ATA bus errors can be reported as ATA device NCQ errors.
+This also should be handled as described in [2-2].
+
+ If READ LOG EXT Log Page 10h fails or reports NQ, we're thoroughly
+screwed.  This condition should be treated as a HSM violation.
+
+
+[2-5] ATA bus error
+
+ ATA bus error means that data corruption occurred during transmission
+over ATA bus (SATA or PATA).  This type of errors can be indicated by
+
+ a. ICRC or ABRT error as described in [2-2]
+
+ b. Controller-specific error completion with error information
+    indicating transmission error.
+
+ c. On some controllers, command timeout.  In this case, there may be
+    a mechanism to determine that the timeout is due to transmission
+    error.
+
+ d. Unknown/random errors, timeouts and all sorts of weirdities.
+
+ As described above, transmission errors can cause wide variety of
+symptoms ranging from device ICRC error to random device lockup, and,
+for many cases, there is no way to tell if an error condition is due
+to transmission error or not; therefore, it's necessary to employ some
+kind of heuristic when dealing with errors and timeouts.  For example,
+encountering repetitive ABRT errors for known supported command is
+likely to indicate ATA bus error.
+
+ Once it's determined that ATA bus errors have possibly occurred,
+lowering ATA bus transmission speed is one of actions which may
+alleviate the problem.  See [3-3] for more information.
+
+
+[2-6] PCI bus error
+
+ Data corruption or other failures during transmission over PCI (or
+other system bus).  For standard BMDMA, this is indicated by Error bit
+in the BMDMA Status register.  This type of errors must be logged as
+it indicates something is very wrong with the system.  Resetting host
+controller is recommended.
+
+
+[2-7] Late completion
+
+ This occurs when timeout occurs and the timeout handler finds out
+that the timed out command has completed successfully or with error.
+This is usually caused by lost interrupts.  This type of errors must
+be logged.  Resetting host controller is recommended.
+
+
+[2-8] Unknown error (timeout)
+
+ This is when timeout occurs and the command is still processing or
+the host and device are in unknown state.  When this occurs, HSM could
+be in any valid or invalid state.  To bring the device to known state
+and make it forget about the timed out command, resetting is
+necessary.  The timed out command may be retried.
+
+ Timeouts can also be caused by transmission errors.  Refer to [2-5]
+for more details.
+
+
+[2-9] Hotplug and power management exceptions
+
+ <<TODO: fill here>>
+
+
+[3] EH recovery actions
+
+This section discusses several important recovery actions.
+
+
+[3-1] Clearing error condition
+
+ Many controllers require its error registers to be cleared by error
+handler.  Different controllers may have different requirements.
+
+ For SATA, it's strongly recommended to clear at least SError register
+during error handling.
+
+
+[3-2] Reset
+
+ During EH, resetting is necessary in the following cases.
+
+ - HSM is in unknown or invalid state
+ - HBA is in unknown or invalid state
+ - EH needs to make HBA/device forget about in-flight commands
+ - HBA/device behaves weirdly
+
+ Resetting during EH might be a good idea regardless of error
+condition to improve EH robustness.  Whether to reset both or either
+one of HBA and device depends on situation but the following scheme is
+recommended.
+
+ a. When it's known that HBA is in ready state but ATA/ATAPI device in
+    in unknown state, reset only device.
+
+ b. If HBA is in unknown state, reset both HBA and device.
+
+ HBA resetting is implementation specific.  For a controller complying
+to taskfile/BMDMA PCI IDE, stopping active DMA transaction may be
+sufficient iff BMDMA state is the only HBA context.  But even mostly
+taskfile/BMDMA PCI IDE complying controllers may have implementation
+specific requirements and mechanism to reset themselves.  This must be
+addressed by specific drivers.
+
+ OTOH, ATA/ATAPI standard describes in detail ways to reset ATA/ATAPI
+devices.
+
+ a. PATA hardware reset
+
+    This is hardware initiated device reset signalled with asserted
+    PATA RESET- signal.  There is no standard way to initiate hardware
+    reset from software although some hardware provides registers that
+    allow driver to directly tweak the RESET- signal.
+
+ b. Software reset
+
+    This is achieved by turning CONTROL SRST bit on for at least 5us.
+    Both PATA and SATA support it but, in case of SATA, this may
+    require controller-specific support as the second Register FIS to
+    clear SRST should be transmitted while BSY bit is still set.  Note
+    that on PATA, this resets both master and slave devices on a
+    channel.
+
+ c. EXECUTE DEVICE DIAGNOSTIC command
+
+    Although ATA/ATAPI standard doesn't describe exactly, EDD implies
+    some level of resetting, possibly similar level with software
+    reset.  Host-side EDD protocol can be handled with normal command
+    processing and most SATA controllers should be able to handle
+    EDD's just like other commands.  As in software reset, EDD affects
+    both devices on a PATA bus.
+
+    Although EDD does reset devices, this doesn't suit error handling
+    as EDD cannot be issued while BSY is set and it's unclear how it
+    will act when device is in unknown/weird state.
+
+ d. ATAPI DEVICE RESET command
+
+    This is very similar to software reset except that reset can be
+    restricted to the selected device without affecting the other
+    device sharing the cable.
+
+ e. SATA phy reset
+
+    This is the preferred way of resetting a SATA device.  In effect,
+    it's identical to PATA hardware reset.  Note that this can be done
+    with the standard SCR Control register.  As such, it's usually
+    easier to implement than software reset.
+
+ One more thing to consider when resetting devices is that resetting
+clears certain configuration parameters and they need to be set to
+their previous or newly adjusted values after reset.
+
+ Parameters affected are.
+
+ - CHS set up with INITIALIZE DEVICE PARAMETERS (seldomly used)
+ - Parameters set with SET FEATURES including transfer mode setting.
+ - Block count set with SET MULTIPLE MODE
+ - Other parameters (SET MAX, MEDIA LOCK...)
+
+ ATA/ATAPI standard specifies that some parameters must be maintained
+across hardware or software reset, but doesn't strictly specify all of
+them.  Always reconfiguring needed parameters after reset is required
+for robustness.  Note that this also applies when resuming from deep
+sleep (power-off).
+
+ Also, ATA/ATAPI standard requires that IDENTIFY DEVICE / IDENTIFY
+PACKET DEVICE is issued after any configuration parameter is updated
+or a hardware reset and the result used for further operation.  OS
+driver is required to implement revalidation mechanism to support
+this.
+
+
+[3-3] Reconfigure transport
+
+ For both PATA and SATA, a lot of corners are cut for cheap
+connectors, cables or controllers and it's quite common to see high
+transmission error rate.  This can be mitigated by lowering
+transmission speed.
+
+ The following is a possible scheme Jeff Garzik suggested.
+
+ If more than $N (3?) transmission errors happen in 15 minutes,
+
+- if SATA, decrease SATA PHY speed.  if speed cannot be decreased,
+- decrease UDMA xfer speed.  if at UDMA0, switch to PIO4,
+- decrease PIO xfer speed.  if at PIO3, complain, but continue
+
+
+[4] History / Credtis
+
+20050827 Tejun Heo <htejun@gmail.com>
+
+	Wrote initial draft based on the following and other
+	discussions with Jeff Garzik and other ATA developers on
+	linux-ide mailing list.
+
+	http://marc.theaimsgroup.com/?l=linux-ide&m=112451335416913&w=2
+
+20050907 Jeff Garzik
+
+	Suggested reorganization of error categories and various other
+	corrections & improvements.
+
+20050913 Tejun Heo <htejun@gmail.com>
+
+	Updated as per Jeff Garzik's suggestion.
