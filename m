From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 1/4] libata: misc updates in preparation of PMP support, take #2
Date: Mon, 16 Jul 2007 14:29:38 +0900
Message-ID: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11877 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763113AbXGPF3o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736627nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello,

This is the second take of misc-updates patchset which updates various
aspects of libata in preparation of PMP support.

#01 ahci: build fix for !CONFIG_PM
#02 libata: add @is_cmd to ata_tf_to_fis()
#03 ahci: use deadline instead of fixed timeout for 1st FIS for SRST
#04 ahci: separate out ahci_kick_engine()
#05 ahci: separate out ahci_exec_polled_cmd()
#06 ahci: separate out ahci_do_softreset()
#07 sata_sil24: replace sil24_update_tf() with sil24_read_tf()
#08 sata_sil24: separate out sil24_exec_polled_cmd()
#09 sata_sil24: separate out sil24_do_softreset()
#10 libata: improve EH report formatting
#11 libata: implement AC_ERR_NCQ
#12 libata: make ->scr_read/write callbacks return error code
#13 ahci: make NO_NCQ handling more consistent
#14 ahci: implement SCR_NOTIFICATION r/w
#15 libata: improve SATA PHY speed down logic
#16 libata: quickly trigger SATA SPD down after debouncing failed
#17 libata: improve SCSI scan failure handling
#18 libata: reorganize ata_ehi_hotplugged()
#19 libata: clear HOTPLUG flag after a reset
#20 libata: schedule probing after SError access failure during autopsy
#21 libata: implement EH fast drain

#01 fixes build breakge.  #02-09 separate out polled command execution
from softreset routines of ahci and sata_sil24.  These will be later
used to implement PMP r/w callbacks.  #10-14 are mostly trivial.
#15-21 improve EH behavior to prepare for PMP support.

Changes from the last take are...

* #01 added
* #02-#09 moved here from pmp patchset as Jeff requested
* #10 updated as Jeff requested

This patchset is on top of

  libata-dev#upstream (d79eb6de54f180dc83b488b20747f0097fde3dea)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20081

