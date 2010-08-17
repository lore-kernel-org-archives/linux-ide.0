From: Jeff Garzik <jeff@garzik.org>
Subject: libata git update
Date: Tue, 17 Aug 2010 18:14:25 -0400
Message-ID: <4C6B09C1.7070901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46309 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0HQWO2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 18:14:28 -0400
Received: by vws3 with SMTP id 3so5064897vws.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2010 15:14:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Dan Carpenter <error27@gmail.com>, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

upstream-fixes (2.6.36-rc) branch now contains,

Bartlomiej Zolnierkiewicz (1):
       libata: remove no longer needed pata_winbond driver

Tejun Heo (2):
       pata_cmd64x: revert commit d62f5576
       ahci: add HFLAG_YES_FBS and apply it to 88SE9128


upstream branch (2.6.37) now contains,

Grant Grundler (1):
       [libata] support for > 512 byte sectors (e.g. 4K Native)

Gwendal Grignou (1):
       [libata] Add ATA transport class

Tejun Heo (1):
       libata: always use ata_qc_complete_multiple() for NCQ command 
completions

