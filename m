From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: [PATCHSET] libata: reorganize ata_dev_identify(), take 2
Date: Tue, 21 Feb 2006 02:12:11 +0900
Message-ID: <11404555312141-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:30865 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161051AbWBTRMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 12:12:14 -0500
Received: by pproxy.gmail.com with SMTP id s49so1154949pyc
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 09:12:13 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hello, Jeff.

This is the second take of ata_dev_identify() regorganization
patchset.  Changes from the previous take[1] are...

* separate-out-ata_dev_read_id and kill-ata_dev_reread_id patches are
  moved upward.

* WARN_ON(dev->id != NULL) is added before calling ata_dev_read_id()
  to make sure no IDENTIFY page is leaked.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8048


