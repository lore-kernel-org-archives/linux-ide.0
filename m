From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 2/4] libata: implement ata_link, take 5
Date: Mon, 16 Jul 2007 18:34:38 +0900
Message-ID: <11845784783033-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:48774 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbXGPJeo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:34:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so782491nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:34:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello, all.

This is the fifth take of implement ata_link patchset.  This patchset
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

* ata_link_init_spd_limit() renamed to ata_link_init_spd()

This patchset is against

  libata-dev#upstream (d79eb6de54f180dc83b488b20747f0097fde3dea)
  + [1] misc-updates patchset

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20099
[1] http://thread.gmane.org/gmane.linux.ide/20824


