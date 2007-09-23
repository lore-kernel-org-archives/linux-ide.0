From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 2/2] implement PMP support, take 6
Date: Sun, 23 Sep 2007 13:19:53 +0900
Message-ID: <1190521193410-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:56265 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbXIWEUA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:20:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1141415rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:19:59 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

his is the sixth take of libata-pmp patchset.  This patchset contains
10 patches and implements PMP support.

Changes from the last take[L] are.

* Better AN handling.  All AHCI now can do hotplug on downstream ports
  whether it has SNTF or not - patch #6 and #8 updated.

* Blacklisting of controllers which falsely claim PMP support - new
  patches #9 and #10.

This patchset is against

  libata-dev#upstream (b56feca2ede0dd11a8409743ff14cf14cbcf5062)
  + [1] sata_sil24-fix-IRQ-clearing-race-when-PCIX_IRQ_WOC-is-used
  + [2] libata-pmp patchset, take #6

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20870
[1] http://article.gmane.org/gmane.linux.ide/22918 
[2] http://thread.gmane.org/gmane.linux.ide/22921


