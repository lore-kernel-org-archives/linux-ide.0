From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: reorganize ata_dev_identify()
Date: Wed, 15 Feb 2006 18:24:09 +0900
Message-ID: <11399954493467-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:37558 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945908AbWBOJYO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 04:24:14 -0500
Received: by pproxy.gmail.com with SMTP id f25so1427413pyf
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 01:24:13 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.  Hello, Albert.

This patchset is the third part of divided 'reorganize configuration
and implement revalidation' patchset[1].  The first[2] and second[3]
parts made into #upstream lately.

This patchset is against
  the current upstream (254a5c45f8e53775a1e1dd7498a8dcd665341f1e)
  + rename ata_dev_id_[c_]string() patch [4]

Note: Jeff, I generated patches over the rename patch as the patch
      make naming not only shorter but also more consistent.  If you
      don't like the rename, I'll regenerate this patchset without it.

This patchset concentrates on reorganizing ata_dev_identify() into
ata_dev_read_id() and ata_dev_configure() such that those functions
can be also be used for revalidation and other purposes.

Also, both functions don't directly take devices or ports offline.
They just report failures to upper layers and determining whether to
take devices/ports offline is the responsibility of upper layer
driving logic.

Other than failure case handling, reorganized configuration code
should be functionality-wise identical to ata_dev_identify().

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7632
[2] http://article.gmane.org/gmane.linux.ide/7977
[3] http://article.gmane.org/gmane.linux.ide/7981
[4] http://article.gmane.org/gmane.linux.ide/7997


