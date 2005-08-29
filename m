From: Tejun Heo <htejun@gmail.com>
Subject: [RFC] libata new EH document
Date: Mon, 29 Aug 2005 15:11:24 +0900
Message-ID: <20050829061124.GA2725@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.194]:61324 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751031AbVH2GLc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2005 02:11:32 -0400
Received: by rproxy.gmail.com with SMTP id r35so952914rna
        for <linux-ide@vger.kernel.org>; Sun, 28 Aug 2005 23:11:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff, Albert & ATA developers.

 This is the final one of recent document series for libata EH - SCSI
EH, ATA exceptions, libata EH and, this one - libata new EH.

 This document tries to discuss how to implement new advanced EH.  It
also describes some proposed mechanisms in detail.  I'm aware that
things are vague without actual code, but I still think this document
alone can at least help discussion if nothing else.  As long as some
consensus is reached regarding general desing, I'll follow up with
patches.

 Jeff, a lot are from my previous new EH/NCQ patchset but also quite
a bit has changed (for better, I hope).

 Thanks.


libata new EH
======================================

 As discussed in the previous libata EH doc, the current libata EH
needs some improvements.  This document discusses goals of new libata
EH and how to reach them.  Please read SCSI EH, ATA exceptions and
libata EH documents first.

TABLE OF CONTENTS

[1] Goals & design choices
    [1-1] Use SCSI hostt->eh_strategy_handler()
    [1-2] Unified error path in an EH thread
    [1-3] Synchronization
    [1-4] Clean mechanism to hand off qc's to EH
    [1-5] Separate EH qc
    [1-6] SCSI/libata separation
[2] Designs
    [2-1] Handoff of failed qc's
    [2-2] Timed out scmd's and qc's
    [2-3] Summary of [2-1] and [2-2]
    [2-4] EH processing & completion
[3] Ideas
    [3-1] Using EH for non-error exceptions and dynamic reconfiguration
    [3-2] Using EH for host_set level exclusion
[4] Implementation plan


[1] Goals & design choices

 The final goal is implementing advanced error handling as described
in ATA exceptions document including NCQ EH, dynamic transport
reconfiguration and non-error exception handling for power management
and hot plugging.

 The followings are sub goals and design choices to reach the final
goal.


[1-1] Use SCSI hostt->eh_strategy_handler()

    We have two other alternatives here - one is using fine-grained
    SCSI EH callbacks and the other is implementing separate EH for
    libata.

    Using fine-grained SCSI EH callbacks is possible, but it has too
    much SCSI/SPI assumptions in it - ATA error handling can be quite
    different from SCSI error handling.  Also, as described in the
    SCSI EH doc, it issues several SCSI commands for recovery.  They
    can be translated but recovery through translation is a bit
    creepy, IMHO.

    The second option - private EH implementation - is attractive in
    that it will be better integrated into libata.  However,
    implementing a full EH when a generic framwork is already in place
    doesn't make a lot of people happy.  And, I think integration
    problems can be worked around without too much trouble.

    The basic semantics of eh_strategy_handler() are

    - Full context EH.

    - After EH is started, all normal command processing is suspended
      until EH is complete.

    - Once EH is determined to be necessary, active commands are
      drained by suppressing all command issuing and waiting for
      in-flight commands.  When EH is finally entered, all active
      commands are failed commands.

    IMO, above semantics are fairly fundamental to block device error
    handling and, in the future, to whatever framework libata
    migrates, assuming above semantics shouldn't hurt too much.


[1-2] Unified error path in an EH thread

    Currently EH is scattered around several places including the
    interrupt handler and polling tasks.  This is problemetic for the
    following reasons.

    a. Full EH context is required for error handling.

       Advanced recovery usually involves resetting, command issuing
       and other blocking operations.

    b. Simple errors may trigger complex error handling behavior.

       For example, when an ABRT error occurs, reporting to upper
       layer is sufficent for most cases; however, repeated ABRT
       errors for known-to-be-supported commands might indicate too
       high transmission speed.  In such cases, full EH context is
       required to perform error handling.

    c. Scattered complex EH is difficult to implement and maintain.

       EH logic can be somewhat complex and scattering won't help
       implementing and maintaining it.  Also, libata low level
       drivers are allowed to override callbacks where part of EH
       logic may reside making matters worse.


[1-3] Synchronization

    A simple & concrete qc synchronization model to make sure that EH
    and any other processing don't occur concurrently is needed.


[1-4] Clean mechanism to hand off qc's to EH

    For EH to handle errors and timeouts, letting EH deal with and
    complete both errored and timed out qc's is good for simplicity
    and consistency.  To achieve this, we need a mechanism to hand off
    a qc to EH.

    Currently, libata EH has a similar mechanism to hand off a failed
    ATAPI qc to EH.  As described in libata EH doc, such qc is
    half-completed and used as place holder until EH is kicked in and
    handles it.

    This half-completion isn't very clean semantically and requires
    calling splitted internal completion routines directly.  Also, as
    such qc's are not explicitly marked as failed, not-very-intuitive
    stuff has to be done to avoid spurious interrupts or other events
    from messing with it after error has occurred.


[1-5] Separate EH qc

    EH needs to issue qc's for recovery.  There can be several ways to
    allocate EH qc.

    a. reserve one extra qc for internal/EH commands
    b. reserve one of normal qc's
    c. use failed qc
    d. complete failed qc first and reuse it

    The preferred choice is #a for the following reasons.

    - Allowing only one concurrent internal command is okay as long as
      proper allocation mechanism is implemented or only one user is
      guaranteed.

    - EH commands are restricted to non-NCQ commands, so reserving an
      extra qc won't break qc to tag mapping.

    - #b is impossible for non-NCQ devices because only one qc is
      available.

    - #c requires dancing with qc's internals.  No real nerd likes
       dancing.

    - It may be necessary to issue commands to determine whether to
      finish or retry a qc, so #d is out.


[1-6] SCSI/libata separation

    Internal libata EH logic implementation should be free from SCSI
    considerations.  All glueing work should be localized to EH
    frontend and once in the actual error handling EH should only deal
    with qc's.


[2] Designs

 This section proposes detailed design of several important mechanisms
to help discussion and verification.


[2-1] Handoff of failed qc's

 As described above, when normal command processing determines that a
qc has failed, those qc's have to be handed off to EH without being
lost.

 A new qc flag ATA_QCFLAG_ERROR is defined to mark qc's which have
failed and ata_qc_error() is defined to be used by command processing
to mark failed qc and schedule EH.  ata_qc_error() has to be called
under the same condition as ata_qc_complete() - under host_lock - and
performs the following.

 1. First check if the command is already marked with
    ATA_QCFLAG_ERROR.  If so, this isn't the first error completion
    attempt, just return.

 2. Mark the qc with ATA_QCFLAG_ERROR.

 3. As, currently, SCSI command issuing is not atomic with respect to
    SHOST_RECOVERY flag, we need a separate atomic mechanism to plug
    command issuing.  Per-port flag ATA_FLAG_ERROR is set here to
    prevent further command issuing.

 4. Corresponding scmd's result code is set to
    SAM_STAT_CHECK_CONDITION and qc->scsidone() callback is called
    directly.  As we haven't filled sense data,
    scsi_determine_disposition() will return FAILED and SCSI EH will
    be scheduled.  Note that as we directly call qc->scsidone(), qc is
    left intact.

 After above function is complete, the following conditions are true.

 a. The qc has ATA_QCFLAG_ERROR set and no further normal qc
    processing will happen for the command.

 b. No new qc will be issued for the port.

 c. EH is scheduled.

 d. Corresponding scmd and qc are left alone until EH processes them.

 Note that to achieve above behavior, we need to modify other places
too.  e.g. ata_qc_complete() needs to be modified to ignore failed
qc's and command issuing part to fail issuing if ATA_FLAG_ERROR is
set.


[2-2] Timed out scmd's and qc's

 Because libata keeps separate command list as qc array, there can be
disagreement regarding which commands have timed out between SCSI and
libata.  Consider the following scenario.

 1. A scmd is issued.

 2. Corresponding qc is allocated, initialized & issued.

 3. SCSI timeout occurs & EH scheduled.

 4. The qc completes successfully.  Because timer already has expired,
    scsi_done() will return without doing anything.

 5. EH starts.

 In above case, we have a timed out scmd but the corresponding qc has
already completed and been deallocated, and this is the only case
where a failed or timed out scmd doesn't have its corresponding qc.
Note that if the qc failed in step #4, ata_qc_error() would have been
called, the qc tagged with ATA_QCFLAG_ERROR and EH would take steps in
[2-1].

 This can be easily worked around by scanning scmds on shost->eh_cmd_q
and complete scmds which don't have corresponding qc's with success
code.  This way, internal libata EH can be insulated from SCSI details
and can only deal with qc's.

 qc's which are determined to have timed out are marked with
ATA_QCFLAG_ERROR | ATA_QCFLAG_TIMEDOUT.  Note that all above should
happen atomically as we don't wanna race with interrupt handler or
polling tasks.


[2-3] Summary of [2-1] and [2-2]

 - All failed qc's will have ATA_QCFLAG_ERROR set.

 - All timed out qc's will have ATA_QCFLAG_ERROR and
   ATA_QCFLAG_TIMEDOUT set.

 - Whenever ATA_QCFLAG_EROR bit is set, ATA_FLAG_ERROR should also be
   set.

 - All of above three should be done while holding host_set lock.

 - ata_qc_complete() and ata_qc_error() should not perform any
   operation on qc's which have ATA_QCFLAG_ERROR set.

 - No non-internal commands should be allowed on ports which have
   ATA_FLAG_ERROR set.


[2-4] EH processing & completion

 After entered, EH can issue internal qc's for recovery.  Note that we
need to implement separate mechanisms for error handling and timeout
as we can't call into EH recursively.

 For errors, just reporting failure should be enough and this can be
easily implemented by calling ata_qc_complete() from ata_qc_error()
for internal commands.

 Separate timer should be used for internal commands.  When this timer
expires, the best we can do is completing the qc with failed status.

 EH code should be prepared to take appropriate actions to handle both
errors and timeouts such as resetting device on timeout.

 After necessary steps are taken for recovery and disposition is
determined for each failed qc, EH should retry or finish each failed
qc.  As noted in SCSI EH doc, eh_strategy_handler() should call either
scsi_finish_command() or scsi_queue_insert().  Because the failed qc's
are still active, overriding their ->scsidone callbacks appropriately
and performing ata_qc_complete() on those will do the job.  Note that
ATA_QCFLAG_ERROR checking should be bypassed when finishing off failed
qc's from EH.

 After all failed qc's are taken care of, libata EH should make sure
that all integrity constraints described in SCSH EH doc is met and
clear ATA_FLAG_ERROR on the port.  Returning from
hostt->eh_strategy_handler() will make SCSI midlayer resume normal
processing.


[3] Ideas

[3-1] Using EH for non-error exceptions and dynamic reconfiguration

 Handling non-error exceptions like hot plugging and dynamic
reconfigurations such as transfer speed lowering are best done inside
EH, but currently there is no way to invoke EH without failed or
timedout scmds.  IMHO, a mechanism to allow EH invocation without
failed scmd should be simple to implement in SCSI midlayer and can
solve this issue nicely.


[3-2] Using EH for host_set level exclusion

 Some EH / configuration actions require host_set level exclusion.
This also can be solved by adding the mechanism described in [3-1].
Before starting such an operation, EH's can be invoked on all other
ports.  After all ports are safely parked inside EH, the operation can
be performed.  After the operation is complete, other ports can be
released from EH.


[4] Implementation plan

 Implementation of new EH can be separated into two stages.  The first
is implementing EH framework.  i.e. qc handoff, EH invocation, qc
completion in EH and resuming normal operation.  The latter part is
implementing actual error handling logic according to ATA exceptions
doc.

 After completing the first step, the current error handling logic can
be moved onto the new framework.  As this won't change libata's
behavior viewed from controllers and devices, we only have to verify
the framework itself and can continue to use the current logic until
the second part is complete.

 As getting error handling logic right would take some time for
testing if not for development and there are some high-on-wishlist
features delayed due to EH - NCQ and hot plugging.  Once the new EH
framework is complete, fitting those in first and implementing unified
EH logic later might be a good idea.  NCQ can be easily integrated
once the framework is in place, but I'm not sure about hotplugging.
