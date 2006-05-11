From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 02/11] new EH framework, take 3
Date: Thu, 11 May 2006 21:27:23 +0900
Message-ID: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:9236 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751645AbWEKM1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:30 -0400
Received: by py-out-1112.google.com with SMTP id f28so217988pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:30 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, again.

This is part of patchset series described in [T].

This is the third take of new-EH-framework patchset.  This patchset
contains 11 patches.  Changes from the last take[L] are

* ata_eh_schedule_port() is replaced with ata_port_schedule_eh(),
  ata_port_abort() and ata_port_freeze().  This is cleaner and makes
  adding link level abort easier.

* abort now uses ATA_QCFLAG_FAILED to tag a qc as failed and simply
  call ata_qc_complete().  This simplifies abortion.

* ATA_EH_PENDING is set when EH is requested and cleared right before
  beginning EH.  After completing EH, if the flag is still set, EH is
  repeated.  This way no EH request is lost.  Later EH implementation
  also includes a mechanism to avoid repeating EH actions
  unnecessarily in such cases.

* ATA_DFLAG_FAILED removed.  It's replaced with ehi->dev implemented
  in the EH patchset.

* Port can be in FROZEN state after EH.  Previously, EH framework
  repeated EH automatically in such cases.  Now whether to leave the
  port frozen or not is the EH's call.  (Note that user can request
  another shot at recovery or detection with warm plug request)

* ops->thaw() added.  Reset or postreset methods now don't
  automatically thaw the port.  This change is necessary for later PM
  support where multiple resets are performed while frozen.  It also
  cleans code up a bit.

* Timedout qcs are now handled by ata_scsi_error() after EH kicks in.
  ata_scsi_timed_out() path is used only for old EH.  To transfer a
  timedout qc's ownership to EH, it's necessary to freeze the port.
  Previously, the transfer happened on timeout detection in
  ata_scsi_timed_out() forcing other active commands to get aborted.
  With this change, the transfer is done after all other commands are
  drained.

* ata_exec_internal() EH fixed/improved.  As commands can be aborted
  during PIO, PIO task needs to be flushed whether it timed out or
  not.

* Error messages from SCSI qc completion path is suppressed if new EH
  is in use.  New EH itself reports better.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[L] http://article.gmane.org/gmane.linux.ide/9524
[1] http://article.gmane.org/gmane.linux.ide/9959


