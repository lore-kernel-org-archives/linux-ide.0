From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: add NCQ support
Date: Mon, 3 Apr 2006 17:32:38 +0900
Message-ID: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:59876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751547AbWDCIct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:49 -0400
Received: by wproxy.gmail.com with SMTP id i22so1247732wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:48 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset implements NCQ support to libata and update ahci such
that it supports NCQ.  It contains 14 patches.

#01-03	prep for NCQ support
#04-10	implement NCQ support
#11-14	update ahci to support NCQ

This patchset is against

  upstream [1]
  + scsi_eh_schedule patchset, take 2 [2][3]
  + ahci softreset presence detection patch [4]
  + eh-framework patchset [5]
  + eh patchset [6]

#01-04	Prep for EH.  Add constants, implement ering and utility functions
#05-09	Implement EH helpers.  These are the backbones of new EH.
#10	Implement stock BMDMA EH using EH helpers.
#11-13	Convert ata_piix, sata_sil and ahci to new EH

Thanks.

--
tejun

[1] 6d5f9732a16a74d75f8cdba5b00557662e83f466
[2] http://marc.theaimsgroup.com/?l=linux-scsi&m=114399387517874&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=114399407718154&w=2
[4] http://marc.theaimsgroup.com/?l=linux-ide&m=114399712126232&w=2
[5] http://article.gmane.org/gmane.linux.ide/9311
[6] http://article.gmane.org/gmane.linux.ide/9343


