From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 2/4] libata: implement ata_link, take 7
Date: Mon, 6 Aug 2007 18:36:22 +0900
Message-ID: <11863929823677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:39413 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760752AbXHFJg2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 05:36:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1724839wah
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 02:36:27 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the seventh take of implement ata_link patchset.  This
patchset contains 14 patches which can be categorized as follows.

#01-02: implement ata_link
#03-06: make libata deal with link instead of port
#07-09: misc link stuff (link init, reset_tries, ata_link_abort())
#10-14: add ap->pmp_link[] and update libata to deal with multiple
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

* adapted to the current upstream
* drivers/scsi/libsas/sas_ata.c updated

This patchset is against

  libata-dev#upstream (5ee30f070f467aaae027f03ef6772128a887b1a3)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/21510


