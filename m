From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve initialization and legacy handling, take#2
Date: Sat, 5 Aug 2006 06:01:32 +0900
Message-ID: <11547252923301-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:29803 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161448AbWHDVBk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:40 -0400
Received: by nz-out-0102.google.com with SMTP id n1so109138nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 14:01:39 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, davej@redhat.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of improve-init-and-legacy patchset.  This
patchset contains patches from Jeff Garzik, Alan Cox, Dave Jones and
me to fix/clean up initializaton and legacy handling.  Changes from
the last take[L] are

* fix patches moved out to fixes-to-upstream-fixes patchset[1].

* per-dev xfermask separated out from rework-legacy-handling patch,
  fixed to choose safe PIO mode and warning message added when DMA is
  disabled due to simplex.

This patchset is against

  libata-dev#upstream [U] 
  + fixes-to-upstream-fixes patchset [1]

This patchset is available in the following git tree (updates to
#upstream-fixes properly merged).

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
  git://htj.dyndns.org/libata-tj tj-upstream

PATA drivers have been updated accordingly and available at (again,
properly merged)

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers
  git://htj.dyndns.org/libata-tj tj-pata-drivers

Updated ALL branch is available at (ditto)

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL
  git://htj.dyndns.org/libata-tj tj-ALL

PATA patch hasn't been changed other than being rebased.

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/12347
[U] 236a686b56428a8967a057a2396f9be74e2ee652
[1] http://article.gmane.org/gmane.linux.ide/12393


