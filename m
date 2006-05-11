From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 05/11] add NCQ support, take 3
Date: Thu, 11 May 2006 23:44:42 +0900
Message-ID: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.192]:15783 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751800AbWEKOot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:49 -0400
Received: by wx-out-0102.google.com with SMTP id i29so11340wxd
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:49 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

An-Nyoung.

This is part of patchset series described in [T].

This is the third take of add-NCQ-support patchset.  Changes from the
last take [L] are

* ap->qactive is renamed to ap->qc_allocated and ap->qc_active is
  added.  ap->qc_active records currently active qcs NCQ or not.
  A helper function ata_qc_complete_multipl() is added.  This function
  completes multiple qcs according to ap->qc_active and new @qc_active
  value.  These are used to implement NCQ qc completion and will also
  be used by PM support.

* EH reads log page 10h if ehi is marked with device error but no qc
  is marked with error, which indicates that LLDD detected device
  error but doesn't know which qc has caused it.  This exactly
  corresponds to NCQ device error condition and thus implementation
  becomes much simpler.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[L] http://article.gmane.org/gmane.linux.ide/9555
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005


