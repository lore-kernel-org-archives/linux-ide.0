From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 1/4] libata: misc updates in preparation of PMP support
Date: Sun, 1 Jul 2007 18:53:36 +0900
Message-ID: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:29288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbXGAJxo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876601wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello,

This patchset contains the following 12 patches updating various
aspects of libata in preparation of PMP support.

#01 [PATCH] libata: update EH report formatting
#02 [PATCH] libata: implement AC_ERR_NCQ
#03 [PATCH] libata: make ->scr_read/write callbacks return error code
#04 [PATCH] ahci: make NO_NCQ handling more consistent
#05 [PATCH] ahci: implement SCR_NOTIFICATION r/w
#06 [PATCH] libata: improve SATA PHY speed down logic
#07 [PATCH] libata: quickly trigger SATA SPD down after debouncing failed
#08 [PATCH] libata: improve SCSI scan failure handling
#09 [PATCH] libata: reorganize ata_ehi_hotplugged()
#10 [PATCH] libata: clear HOTPLUG flag after a reset
#11 [PATCH] libata: schedule probing after SError access failure during autopsy
#12 [PATCH] libata: implement EH fast drain

#01-03 are mostly trivial.  #04-05 are minor updates to ahci.  #06-#12
improves EH behaviors including SATA speed down, hotplug handling and
fast draining if EH is pending.  Please refer to individual commit
messages for more info.

This patchset is on top of

  libata-dev#upstream (4e1ae96828f6cee7b89ab8ca474c150fe211afd8)

Thanks.

--
tejun


