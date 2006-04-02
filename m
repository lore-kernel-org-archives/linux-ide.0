From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] new EH framework
Date: Mon, 3 Apr 2006 03:31:08 +0900
Message-ID: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:52805 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750856AbWDBSbO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550552nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:14 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

New EH, finally.  New EH will be posted as two patchsets -
eh-framework and eh.  As the name suggests, the first one implements
EH framework in libata core layer and the second one implements
helpers, drivers, stock routines for bmdma controllers and converts
several drivers (ata_piix, ahci, sata_sil) to new EH.

This is the first take of eh-framework patchset.  This patchset
contains 13 patches and against

  upstream [1]
  + scsi_eh_schedule patchset, take 2 [2][3]
  + ahci softreset presence detection patch [4]

Brief description of new EH framework follows.


1. Introduction
---------------

In the old EH, there is only one way a qc gets EH'd - timeout, so
LLDDs handled errors which are not timeout either directly from
interrupt handler or by letting it timeout, which is at best
inefficient.  Worse than that, normal execution (irq handler) <-> EH
synchronization wasn't taken into account.  New EH tries to acheive
the following goals.

 a. Clear ownership of qc.  If normal execution path owns a qc, it
    owns it.  Once a qc is taken over by EH, EH owns it.  No one but
    owner can access the qc.

 b. Resistant against weird hardware behavior.  Some controllers
    and/or devices can enter states where they violate a lot of driver
    assumptions.  In new EH, whenever a controller or device acts in
    unexpected manner (HSM violation), the port gets frozen and no
    access is allowed it gets successfully reset.

 c. Threaded/unified implementation.  Recovery actions involve a lot
    of waiting and retries in nature and doesn't have to be super
    efficient.  Do most stuff in EH context.  This also allows EH
    implementation to be implemented as unified executon flow making
    it easier to implement and maintain.

 d. Have to co-exist with old EH till all LLDDs get converted.


2. Who owns qc and how it gets transferred
------------------------------------------

All qc's start owned by normal execution path.  Depending on protocol,
it can be the interrupt handler or PIO task.  There are several ways
the ownership can be transferred to EH.

 a. Completing with an error.  If a qc gets completed with non-zero
    err_mask, ata_qc_complete() automatically schedules the qc for EH.
    After ata_qc_complete() completes, the qc is owned by EH.  Normal
    execution path is not allowed to access it.

 b. Timing out.  When a qc times out, the qc is secheduled for EH.
    Also, timeout condition is considered as HSM violation as we don't
    really know in what state the controller and device are in.  So,
    timeout triggers mass abortion and freezes the port.

 c. Mass abortion.  This schedules all active qc's for EH.  This is
    used when an exception which affects all commands occur.  e.g.
    NCQ command failure or HSM violation.  Freezing a port implies
    mass abortion.

When a qc gets scheduled for EH, ATA_QCFLAG_EH is set atomically.
libata core layer enforces EH ownership by returning NULL from
ata_qc_from_tag() for the qc.


3. EH execution
---------------

EH starts execution when there is no qc left executing in normal path.
ie. On entry to EH, all qc's are owned by EH and normal execution path
is not allowed to / cannot access those qc's.  Because PIO task is not
synchronized with host_set lock, synchronization with PIO task is
achieved by flushing the port task prior to entering ->error_handler,
but the end result is the same.

If EH got invoked due to exceptions which are not HSM violation, the
port should be quiescent at this point.  If HSM violation occurred,
the ports must have been frozen, so, again, the port is quiescent.

EH examines the situation and perform recovery actions.  Frozen port
is thawed by resetting it, ATAPI sense is requested, so on.  EH issues
all recovery commands using ata_exec_internal() which uses separate
reserved qc such that it can be executed without cannibalising failed
qc's.

Failed qc's are completed or retries only after all EH actions are
complete when EH knows that the port is in known state and sg table,
data buffers and such are safe to deallocate.


4. Frozen
---------

A port is frozen whenever libata cannot determine in what state the
port is in.  While frozen, no one should access the controller and
attached devices.  Ideally this can be implemented by masking
interrupt from the port.  If that is not possible, the LLDD's
interrupt handler is responsible for unconditionally acking and
clearing all interrupts which occur while the port is frozen.

All resets are done while the target port is frozen including resets
performed during probing.  A port starts frozen and gets thawed after
the first probing reset is complete.


5. Notes
--------

* ata_down_xfermask_limit()

  As said above, during EH, no normal execution occurs.  There is no
  active qc during EH except for internal command which is issued only
  after the device is put into known state.  So, altering
  dev->*_mask's during EH is safe.


Thanks.

--
tejun

[1] 6d5f9732a16a74d75f8cdba5b00557662e83f466
[2] http://marc.theaimsgroup.com/?l=linux-scsi&m=114399387517874&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=114399407718154&w=2
[4] http://marc.theaimsgroup.com/?l=linux-ide&m=114399712126232&w=2


