From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: reorganize ata_dev_identify(), take 3
Date: Wed, 1 Mar 2006 16:09:35 +0900
Message-ID: <11411969752304-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:24637 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbWCAHJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 02:09:41 -0500
Received: by zproxy.gmail.com with SMTP id z6so69861nzd
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 23:09:40 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This is the third take of reorganize-ata_dev_identify patchset.  In
the last take[1], two patches (%1 and %2) made into #upstream out of
six patches.  %2 contained an illegal kfree in ata_dev_read_id() which
is left over of patch reordering.  The bug was spotted by Randy Dunlap
and patch was submitted[2].

This patchset contains the remaining four patches regenerated against
the current #upstream[3] + fix-illegal-kfree patch[2].

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8176
[2] http://article.gmane.org/gmane.linux.ide/8324
[3] cccc65a3b60edaf721cdee5a14f68ba009341822


