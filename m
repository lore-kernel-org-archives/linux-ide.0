From: Joilnen Leite <pidhash@yahoo.com>
Subject: (unknown)
Date: Thu, 19 Feb 2004 05:52:12 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web12607.mail.yahoo.com ([216.136.173.230]:45580 "HELO
	web12607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267256AbUBSNwO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 08:52:14 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

excuse me friends shcedule_timeout(1) is not a problem
for spin_lock_irqsave ?



drivers/scsi/ide-scsi.c:897

spin_lock_irqsave(&ide_lock, flags);
while (HWGROUP(drive)->handler) {
       HWGROUP(drive)->handler = NULL;
       schedule_timeout(1);
}

pub 1024D/5139533E Joilnen Batista Leite 
F565 BD0B 1A39 390D 827E 03E5 0CD4 0F20 5139 533E


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
