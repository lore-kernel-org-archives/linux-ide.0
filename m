From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement presence detection using polling IDENTIFY for ata_piix
Date: Sat, 30 Sep 2006 15:46:49 +0900
Message-ID: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:33490 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751086AbWI3Gq4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:46:56 -0400
Received: by py-out-1112.google.com with SMTP id n25so1581529pyg
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:46:56 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

I've been thinking about device misdetection and phantom device
problems on piix for some time now.  Various controllers show
different behaviors and even chips sharing the same PCI ID act
differently.  Some of the symptoms are intermittent making it
difficult to debug.

In addition, a few days ago, there was a new bug report from
a.bono@libero.it saying ICH4-M showed phantom device problem.  That's
an old old IDE controller which must have worked well for a very long
time.

I think that it's just best to do what IDE and old libata used to do -
ignore PCS (other than turning on enable bits) and honor reset
signature and TF r/w test while using polling PIO for IDENTIFY and
detect phantom devices.  This formula had been working for years and
there is no good reason to cause more pain to ICH users, which are a
LOT, to find reliable non-polling device detection mechanism, which
might not even exist.

So, this patchset.  It implements device detection via polling
IDENTIFY.  When no device present, !BSY && !DRQ status is seen while
trying to read the IDENTIFY block.  If a LLD specifies
ATA_FLAG_DETECT_POLLING, IDENTIFY command is issued using polling PIO
and the HSM marks AC_ERR_NODEV_HINT if !BSY && !DRQ is met.  Then the
probing logic marks the device non-existent silently and continues
probing.

This patchset contains 6 patches.

#01-03	: prep for ATA_FLAG_DETECT_POLLING implementation
#04	: implement ATA_DETECT_POLLING
#05	: apply ATA_DETECT_POLLING to ata_piix
#06	: kill unnecessary parts from ata_piix

This patchset is against

  upstream (2d2744fc8be620a2dc469cf48349e3e704119f1b)

This patchset collides with the following patch.

  [1] implement-ATA_FLAG_SETXFER_POLLING-and-use-it-in-pata_via

I'll reimplement the above patch to not impact qc_issue fast path and
thus can be put off.

Please test this patchset.  If you don't feel comfortable with handling
patch series, this patchset is also available as...

* Git tree

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=detect-polling
  git://htj.dyndns.org/libata-tj detect-polling

* Kernel source tarball

  http://htj.dyndns.org/linux-libata-dev-upstream-DETECT_POLLING.tar.bz2

Thanks.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/13248


