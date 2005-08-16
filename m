From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: ata_scsi_queuecmd locking question
Date: Tue, 16 Aug 2005 16:21:53 -0600
Message-ID: <4789af9e05081615216c1de2be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:45853 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751015AbVHPWV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 18:21:57 -0400
Received: by zproxy.gmail.com with SMTP id r28so42200nza
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 15:21:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

I'm just looking into libata-scsi.c, and noticed that the comments for
ata_scs_queuecmd note that it is supposed to obtain host_set->lock. 
It doesn't seem to do so.

Should it?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
