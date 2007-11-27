From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve timing code and fix pata_amd transfer mode selection, take #2
Date: Tue, 27 Nov 2007 19:43:37 +0900
Message-ID: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.181]:7264 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXK0KoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:00 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1613025roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:43:59 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


Hello,

This is the second take of improve-timing-code-and-fix-pata_amd
patchset.

Changes from the last take [L] are...

* 0005-libata-xfer_mask-is-unsigned-int-not-unsigned-long.patch is
  reversed such that xfer_mask is consistently unsigned long.

This patchset is against

   #upstream (51a7ee37eaa85b8c35fe6090618e34ed4ce1d316)
 + improve-speed-down patchset, take #3  [1]

This patchset is also available as the following git tree.

master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-timing-code-and-fix-pata_amd

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/24524
[1] http://thread.gmane.org/gmane.linux.ide/25406
