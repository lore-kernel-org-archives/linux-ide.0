From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] prep for PMP support, take 3
Date: Mon, 16 Oct 2006 08:17:47 +0900
Message-ID: <11609542672061-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:51737 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750984AbWJOXRz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:17:55 -0400
Received: by nf-out-0910.google.com with SMTP id l35so1907762nfa
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:17:54 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of libata-pmp-prep patchset.  This patchset
contains 5 patches and implements various stuff needed for PMP.

Changes from the last take[L] are.

* rebased
* sata_link_hardreset() separation is done earlier by vt8251-ahci
  patchset and thus dropped from this patchset.

This patchset is against

  upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
  + [1] hp-poll patchset, take #5
  + [2] vt8251-ahci patchset, take #2
  + [3] libata-link patchset, take #3

Git tree can be accessed at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp-prep
  git://htj.dyndns.org/libata-tj pmp-prep

Jeff, I couldn't merge ->qc_defer() into ->qc_prep() or ->qc_issue().
The problem is that ->qc_prep() is done after sg mapping is done which
is a bit costly to throw away if the qc has to be deferred.
->qc_defer() is called right after qc is allocated and translated but
before any resource for qc execution is acuquired.

Another way would be to let ->qc_issue() determine whether deferring
is needed and cache prepared qc while deferred.  This has the
following problems.

* qc and related resources are held by deferred command.  Currently,
  qc directly maps to hardware command slots and w/ PMP this can get
  messy.

* Separate requeueing/restarting mechanism must be implemented.  ATM,
  libata depends on SCSI for retrying deferred commands with
  reasonable fairness.  To hold prepared qc, libata needs to implement
  its own mechanism and I don't think the added benefits justify the
  complexity.

So, I think it's better to keep ->qc_defer().

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/11928
[1] http://article.gmane.org/gmane.linux.ide/13467
[2] http://article.gmane.org/gmane.linux.ide/13471
[3] http://article.gmane.org/gmane.linux.ide/13478


