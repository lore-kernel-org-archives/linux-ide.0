From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement ata_link, take 6
Date: Sat, 4 Aug 2007 17:42:40 +0900
Message-ID: <11862169601938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:25774 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXHDImo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 04:42:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1106593wah
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 01:42:44 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the sixth take of implement ata_link patchset.  This patchset
contains 14 patches which can be categorized as follows.

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

This patchset is against

  libata-dev#upstream (80c51b13d8a73b9346ebe849cdeac6f539066fc2)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20842


