From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement new initialization model w/ iomap support
Date: Mon, 7 Aug 2006 12:03:59 +0900
Message-ID: <1154919839169-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:59204 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750955AbWHGDEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 23:04:16 -0400
Received: by py-out-1112.google.com with SMTP id z74so1855306pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 20:04:06 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the first take of new-init-model patchset.  This patchset
implements new init model for libata LLDs.  The new init model has the
following benefits.

* Consistency across different LLDs

  Provide helpers such that common codes live in one place and init
  sequence doesn't have to be creative.

* Flexibility and easy code sharing with suspend/resume

  Instead of using probe_ent, allocate host_set and initialize it
  directly.  This removes many restrictions of probe_ent and allows
  LLDs to share init/remove codes with suspend/resume easily as they
  use the same target data structure.

  IRQ management is also moved out of libata-core into libata-pci
  helpers which LLDs can use or override at will.

* More bookkeeping in libata-core, less in LLDDs

  Acquired resources are tracked by libata-core and helpers.  e.g. LLD
  doesn't have to remember which resources it has acquired, it can
  simply tell libata to release all resources on error path and driver
  detachments.  This simplies LLDs and fixes several dangling resource
  and double-free bugs.

* Support for iomap

  As with all other PCI resources, both PIO and mmio areas are managed
  by libata PCI helpers.  iomaps are automatically created on IO
  resource acqusition and destroyed on release.  LLDs can simply
  request which BARs it intends to use.  The rest is handled by
  libata PCI helpers.

This patchset has been tested on

* ata_piix	: ICH7R, most combinations and w/ induced resource
		  allocation errors
* ahci		: ICH7R
* sata_sil	: sil3112, sil3114
* sata_sil24	: sil3124, sil3132
* sata_via	: vt6420 (via C3)
* pdc_adma	: as broken as previous
* sata_promise	: PDC20375, tested w/ PATA port too (PATA bits not
		  included in this post)

If you have any controller which use one of the following drivers,
please test and report.

* sata_svw
* sata_sx4
* sata_uli
* sata_vsc
* sata_sis
* sata_qstor
* sata_nv (I can do this later)
* sata_mv

If this patchset is agreed upon, I'll update #pata-drivers
accordingly.

This patchset is against

[U] upstream
[1] + #upstream-fixes + several-fixes-against-upstream-fixes merged
[2] + improve-initialization-and-legacy-handling patchset, take #2
[3] + ahci-remove-irq-clearing-from-init_controller

[U] + [1] + [2] is #tj-upstream which is available at the following
URLs.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
  git://htj.dyndns.org/libata-tj tj-upstream 

Thanks.

--
tejun

[U] 236a686b56428a8967a057a2396f9be74e2ee652
[1] http://article.gmane.org/gmane.linux.ide/12393
[2] http://article.gmane.org/gmane.linux.ide/12422
[3] http://article.gmane.org/gmane.linux.ide/12423


