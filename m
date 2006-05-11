From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 03/11] new EH implementation, take 3
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:34485 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751711AbWEKNVd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:33 -0400
Received: by nz-out-0102.google.com with SMTP id 13so189303nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:32 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is part of patchset series described in [T].

This is the third take of new-EH-implementation patchset.  Changes
from the last take[L] are

* (struct ata_eh_info) ap->eh_info and (struct ata_eh_context)
  ap->eh_context are added.  ehi contains all the information other
  parts of libata needs to communicate to EH, and ehc contains all the
  context EH needs to operate.  ehi is protected by host_set lock
  while ehc is owned by EH.  ehi/ehc act as standardized communication
  channel between LLDD and EH, and inside EH itself.  This simplifies
  EH implementation.

  ehc contains a struct eh_info and, on entry to EH, ap->eh_info is
  copied into ap->eh_context and cleared.  This allows LLDD to record
  exceptions detected during EH to ap->eh_info such that no exception
  info is lost (combined with ATA_FLAG_EH_PENDING) and EH to access
  ehc all it wants without bothering about synchronization.

  Another benefit of storing EH context into ap->eh_context is that it
  can easily be extended to handle multiple links.

* Due to above change, EH code are changed a lot, but basic behavior
  and function organization isn't changed too much.  One of the most
  visible change is EH interface.  As the information can be passed
  easily via ap->eh_info, the interface got simplified.  Currently,
  the only exported interface is ata_do_eh() and it seems enough for
  all the converted drivers - ata_piix, sata_sil, ahci and sata_sil24.
  EH is still done in clearly separated stages, so exporting more
  isn't difficult if needed.

* ahci and sata_sil24 now analyzes and records errors while handling
  the error IRQ.  This is more natural way (e.g. PM errors must be
  dealt with this way) and ehi makes it much easier to do.

* Single failed qc per device assumption is removed.  Multiple or no
  failed command cases are properly handled.  Also, report format is
  improved.  In general, EH is much more mature now.

* Frozen port handling in ata_interrupt() dropped.  Jeff was against
  it and I'm not very sure.

* AHCI PIO setup interrupts for multisector PIO commands don't trigger
  spurious interrupt wnarning anymore.

* Patches are in bigger lumps.  This applies to all other patchsets
  too.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[L] http://article.gmane.org/gmane.linux.ide/9540
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984


