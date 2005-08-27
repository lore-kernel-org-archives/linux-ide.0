From: Tejun Heo <htejun@gmail.com>
Subject: [RFC] ATA/ATAPI exceptions doc
Date: Sat, 27 Aug 2005 14:35:21 +0900
Message-ID: <20050827053521.GA13742@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:35258 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030313AbVH0Ff2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Aug 2005 01:35:28 -0400
Received: by wproxy.gmail.com with SMTP id 71so406785wra
        for <linux-ide@vger.kernel.org>; Fri, 26 Aug 2005 22:35:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

 Hello, ATA people.

 This is the first section of libata EH doc.  This section tries to
describe ATA/ATAPI errors and exceptions in driver-neutral way and is
intended to be used as reference when implementing new libata EH.

 The second section will be about current libata EH implementation and
the last will be how to implement new libata EH.

 Thanks.

libata EH
======================================

 This document first discusses what ATA/ATAPI error conditions exist
and how they should be handled.  Then, we move on to how libata
currently handles them and how it can be improved.  Where 'current'
represents ALL head of libata-dev-2.6 git tree as of 2005-08-26,
commit ab9b494f6aeab24eda2e6462e2fe73789c288e73.  References are made
to SCSI EH document.  Please read SCSI EH document first.

 A lot of EH ideas are from Jeff Garzik and others in the following
and other discussion threads on linux-ide.

 http://marc.theaimsgroup.com/?l=linux-ide&m=112451335416913&w=2


[1] ATA/ATAPI errors and exceptions

 This section tries to identify what error/exception conditions exist
for ATA/ATAPI devices and describe how they should be handled in
implementation-neutral way.

 The term 'error' is used to describe conditions where either an
explicit error condition is reported from device or a command has
timed out.

 The term 'exception' is either used to describe exceptional
conditions which are not errors (say, power or hotplug events), or to
describe both errors and non-error exceptional conditions.  Where
explicit distinction between error and exception is necessary, the
term 'non-error exception' is used.

 The following categories of exceptions exist for ATA/ATAPI devices.

 - HSM violation error
 - ATA command error (non-NCQ)
 - ATA command timeout (non-NCQ)
 - ATAPI command error
 - ATAPI command timeout
 - NCQ command error
 - NCQ command timeout
 - other errors
 - non-error exceptions


[1-1] Exception categories

 All error indications are described according to legacy taskfile +
bus master IDE interface.  If a controller provides other (better)
mechanism for error reporting, mapping those into categories described
here shouldn't be difficult.

 In the following sections, two recovery actions - reset and
reconfiguring transport - are mentioned.  These are described in
further detail in [1-2].


[1-1-1] HSM (host state machine) violation error

 This error is indicated when STATUS value doesn't match HSM
requirement during issuing or excution any ATA/ATAPI command.

ex) ATA_STATUS doesn't contain !BSY && DRDY && !DRQ while trying to
    issue a command.

ex) !BSY && !DRQ during PIO data transfer.

ex) DRQ on command completion.

 In this case, HSM is violated and not much information regarding the
error can be acquired from STATUS or ERROR register.  IOW, this error
can be anything - software error, faulty device, controller or cable.

 As HSM is violated, reset is necessary to bring it back to known
state.  Reconfiguring transport for lower speed might be a good idea
too as transmission errors do cause this behavior.


[1-1-2] ATA command error (non-NCQ)

 This error is indicated by set ERR bit on ATA command completion.
STATUS and ERROR registers indicate what kind of error has occurred.
Interpretation of STATUS and ERROR may differ depending on command.

 This type of errors can be further categorized.

 a. CRC error during transmission

    This is indicated by ICRC bit in the ERROR register.  Reset is not
    necessary as HSM is not violated but reconfiguring transport speed
    would help.

 b. Media errors

    This is indicated by UNC bit in the ERROR register.  ATA devices
    reports UNC error only after certain number of retries cannot
    recover the data, so there's nothing much else to do other than
    notifying upper layer.  Note that READ and WRITE commands report
    CHS or LBA of the first failed sector.  This could be used to
    complete successfully sectors in the request preceding the address
    although it's doubtful if it would actually help.

 c. Media changed / media change requested error

    Is there any SATA device with removable media?

 d. Other errors

    This can be invalid command or parameter indicated by ABRT ERROR
    bit or some other error condition.  Report to upper layer.

*TODO* Describe how STATUS and ERROR bits can be mapped to error
       categories.

*QUESTION* Do we have to ignore command-specific 'not applicable' bits
           when interpreting register values?


[1-1-3] ATA command timeout (non-NCQ)

 ATA command timeout occurs if a ATA command fails to complete in some
specified time.  When timeout occurs, HSM could be in any valid or
invalid state.  To bring the device to known state and make it forget
about the command, resetting is necessary.  The timed out command can
be retried.

 Timeouts can also be caused by transmission errors.  Reconfiguring
transport might help.


[1-1-4] ATAPI command error

 ATAPI command error is indicated by set CHK bit (ERR bit) in the
STATUS register on ATAPI command completion.  CHK bit indicates SAM
CHECK CONDITION status.  Sense data is needed to determine why the
error occurred and what actions to take.  As ATAPI doesn't do
autosensing, explicit REQUEST SENSE command should be issued to the
device.  Once sense data is acquired, the error can be handled
similary to other SCSI errors.


[1-1-5] ATAPI command timeout

 ATAPI command timeout occurs if a ATAPI command fails to complete in
some specified time.  It can be handled in the same way as ATA command
timeouts described in [1-2].


[1-1-6] NCQ command error

 NCQ command error is indicated by cleared BSY and set ERR bit during
NCQ command phase (one or more NCQ commands outstanding).  Although
STATUS and ERROR registers will contain valid values describing the
error, READ LOG EXT is required to clear the error condition,
determine which command has failed and acquire more information.

 READ LOG EXT Log Page 10h reports which tag has failed and TF
register values describing the error.  With this information the
failed command can be handled as a normal ATA command error as in
[1-1] and all other in-flight commands should be retried.  Note that
this retry should not be counted - it's likely that commands retried
this way would have completed normally without the failed command.

 If READ LOG EXT Log Page 10h fails or reports NQ, we're thoroughly
screwed.  This condition should be treated as a HSM violation.


[1-1-7] NCQ command timeout

 NCQ command timeout occurs if a NCQ command fails to complete in some
specified time.  Sane recovery action seems to be waiting for all
other commands to finish and take the same action as for ATA command
timeout [1-2].


[1-1-8] Other errors

 a. (PCI) bus error

    This is indicated by Error bit in BMDMA Status register.  The
    following is an excerpt from Jeff's mail regarding this error.

    "PCI bus errors should be handled by resetting the host controller
    (if possible), and then retrying the command [NOTE: better
    suggestions welcome]"

 b. Other controller specific errors

    Most errors should fit into one of above described categories and
    handled accordingly.


[1-1-9] Non-error exceptions

 *TODO* Write about PM and hot plugging.


[1-2] EH recovery actions

 This section discusses two important recovery actions mentioned
previously - resetting device/HBA and reconfiguring transport speed.


[1-2-1] Reset

 During EH, resetting is necessary in the following cases.

 - HSM is in unknown or invalid state
 - HBA is in unknown or invalid state
 - EH needs to make HBA/device forget about in-flight commands
 - HBA/device behaves weirdly.

 Resetting during EH might be a good idea regardless of error
condition to improve EH robustness.

 HBA resetting is implementation specific and even controllers
complying to taskfile/BMDMA PCI IDE interface are likely to have
implementation-specific ways to reset whole HBA.  So, this probably
should be addressed by specific drivers.

 OTOH, ATA/ATAPI standard describes in detail ways to reset ATA/ATAPI
devices.

 a. PATA hardware reset

    This is hardware initiated device reset signalled with asserted
    RESET- signal.  In PATA, there is no way to initiate hardware
    reset from software.

 b. Software reset

    This is achieved by turning CONTROL SRST bit on for at least 5us.
    Both PATA and SATA support it but, in case of SATA, this may
    require controller-specific support as the second Register FIS to
    clear FIS should be transmitted while BSY bit is still set.  Note
    that on PATA, this resets both master and slave devices on a
    channel.

 c. ATAPI DEVICE RESET command

    This is very similar to software reset except that reset can be
    restricted to the selected device without affecting the other
    device sharing the cable.

 d. SATA phy reset

    This is the preferred way of resetting a SATA device.  In effect
    it's identical to PATA hardware reset.  Note that this can be done
    with the standard SCR Control register.  As such, it's usually
    easier to implement than software reset too.

 Although above reset methods are standard, different HBA
implementations may have different requirements for resetting devices.
For standard BMDMA implementation, BMDMA state is the only context and
stopping active DMA transaction suffices.  For other types of HBAs,
there are different requirements to put them in consistent state.

 One more thing to consider when resetting devices is that resetting
clears certain configuration parameters and they need to be set to
their previous or newly adjusted values after reset.

 Parameters affected are.

 - CHS set up with INITIALIZE DEVICE PARAMETERS (seldomly used)
 - Parameters set with SET FEATURES including transfer mode setting.
 - Block count set with SET MULTIPLE MODE
 - Other parameters (SET MAX, MEDIA LOCK...)

 ATA/ATAPI standard specifies that some parameters should be kept
across hardware reset or software reset, but doesn't strictly specify
all of them.  IMHO, always reconfiguring needed parameters after reset
would be a good idea for robustness.

 Also, ATA/ATAPI standard requires that IDENTIFY DEVICE / IDENTIFY
PACKET DEVICE is issued after a hardware reset and the result is used
for further operation.  *QUESTION* Would this be necessary?  If so,
revalidation mechanism needs to be implemented.


[1-2-2] Reconfigure transport

 For both PATA and SATA, a lot of corners are cut for cheap
connectors, cables or controllers and it's quite common to see high
transmission error rate.  This can be mitigated by lowering
transmission speed.

 The following scheme can be applied.  (from Jeff's comment)

 If more than $N (3?) transmission errors happen in 15 minutes,

- if SATA, decrease SATA PHY speed.  if speed cannot be decreased,
- decrease UDMA xfer speed.  if at UDMA0, switch to PIO4,
- decrease PIO xfer speed.  if at PIO3, complain, but continue
