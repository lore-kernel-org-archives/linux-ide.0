From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve initialization and legacy handling, take#3
Date: Thu, 10 Aug 2006 17:16:28 +0900
Message-ID: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:32301 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751452AbWHJIQe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:34 -0400
Received: by py-out-1112.google.com with SMTP id z74so730391pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:34 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of improve-init-and-legacy patchset.  This
patchset contains patches from Jeff Garzik, Alan Cox and me to
fix/clean up initializaton and legacy handling.  Changes from the last
take[L] are

* adapted to Brian King's sas port alloc/init stuff (new patch added
  #01-update-ata_host_init-and-rename-it-to-ata_port_init_shost)

* fix-new-legacy-handling patch merged into rework-legacy-handling as
  Jeff suggested.

This patchset is against

  libata-dev#upstream [U] 

This patchset is available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
  git://htj.dyndns.org/libata-tj tj-upstream

PATA drivers have been updated accordingly and available at (properly
merged)

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers
  git://htj.dyndns.org/libata-tj tj-pata-drivers

Updated ALL branch is available at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL
  git://htj.dyndns.org/libata-tj tj-ALL

PATA patch[1] hasn't been changed other than being rebased.

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/12401
[U] 3f066887595de490c411762ce58a31412b09e939
[1] http://article.gmane.org/gmane.linux.ide/12355


