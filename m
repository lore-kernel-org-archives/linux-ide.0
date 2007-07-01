From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 2/4] libata: implement ata_link, take 4
Date: Sun, 1 Jul 2007 19:05:58 +0900
Message-ID: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:52809 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbXGAKGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879662wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:03 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Subject: [PATCHSET 2/4] libata: implement ata_link, take 4

Hello, all.

This is the fourth take of implement ata_link patchset.  This patchset
contains 16 patches which can be categorized as follows.

#01-02: prep
#03-04: implement ata_link
#05-08: make libata deal with link instead of port
#09-11: misc link stuff (link init, reset_tries, ata_link_abort())
#12-16: add ap->pmp_link[] and update libata to deal with multiple
	links

ata_link abstracts PHY and sits between ata_port and ata_device.  The
following attributes are moved to ata_link from ata_port.

- active command state (active_tag, sactive)
- [hw_]sata_spd_limit
- eh_info and eh_context
- device array

With above and a few extra fields, a link can handle attached devices
including qc management and EH/hotplug.  This patchset makes libata
ready to handle PMP links.

Changes from the last take[L] are.

* updated to fit new #upstream
* SError failure handling updated and moved to misc-updates patchset
* ata_dev_configure() update is unnecessary now and dropped

This patchset is against

  libata-dev#upstream (4e1ae96828f6cee7b89ab8ca474c150fe211afd8)
  + [1] misc-updates patchset

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/13478
[1] http://thread.gmane.org/gmane.linux.ide/20081


