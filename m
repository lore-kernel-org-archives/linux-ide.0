From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement and use ata_dev_revalidate()
Date: Wed, 15 Feb 2006 19:02:45 +0900
Message-ID: <11399977652752-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:1291 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbWBOKCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 05:02:50 -0500
Received: by pproxy.gmail.com with SMTP id e30so1495847pya
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 02:02:49 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Hello, Jeff.  Hello, Albert.

This patchset is the fourth and last part of divided 'reorganize
configuration and implement revalidation' patchset[1].  The third part
was posted about half an hour ago[2].

This patchset is against
  the current upstream (254a5c45f8e53775a1e1dd7498a8dcd665341f1e)
  + rename ata_dev_id_[c_]string() patch [3]
  + reorganize ata_dev_identify() patchset [2]

Note: Jeff, I generated patches over the rename patch as the patch
      make naming not only shorter but also more consistent.  If you
      don't like the rename, I'll regenerate this patchset without it.

This patchset implements ata_dev_revalidate() and use it after
configuring transfer mode.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7632
[2] http://article.gmane.org/gmane.linux.ide/8048
[3] http://article.gmane.org/gmane.linux.ide/7997


