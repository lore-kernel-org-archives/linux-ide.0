From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] new EH implementation
Date: Mon, 3 Apr 2006 12:44:38 +0900
Message-ID: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:64516 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWDCDoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:44 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665772nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second half of new EH - actual EH implementation.  This
patchset contains thirteen patches and against.

  upstream [1]
  + scsi_eh_schedule patchset, take 2 [2][3]
  + ahci softreset presence detection patch [4]
  + eh-framework patchset [5]

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


