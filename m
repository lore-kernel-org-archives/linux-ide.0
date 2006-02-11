From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ahci: convert to new reset mechanism
Date: Sat, 11 Feb 2006 16:26:02 +0900
Message-ID: <11396427621534-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:25992 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932255AbWBKH0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 02:26:07 -0500
Received: by zproxy.gmail.com with SMTP id j2so578256nzf
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 23:26:05 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Hello, Jeff.

This is respin of ahci part of new reset mechanism patchset take #4[1].
I've prepended a patch to convert ahci_fill_cmd_slot() to take *pp
instead of *ap.  This should have been done when posting the reset
patchset.  Sorry about the mess.  Was way too tired, I guess.

This patchset is against the current upstream[2], but will apply fine
over the inline-ata_qc_complete patch[3] I've just posted.

BTW, something wrong about ata_piix patches in the reset patchset?

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7935
[2] 489ff4c7d167be954f715128790bd80d3c888322
[3] http://article.gmane.org/gmane.linux.ide/7948

