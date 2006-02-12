From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: misc preps for configuration reorganization
Date: Sun, 12 Feb 2006 22:47:04 +0900
Message-ID: <11397520242602-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:22123 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWBLNrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 08:47:08 -0500
Received: by pproxy.gmail.com with SMTP id z59so553231pyg
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 05:47:07 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

This patchset is miscellaneous preparations for configuration
regorganization, mostly implementing/separating out small helper
functions.  This is part of previously posted 'reorganize configuration
and implement revalidation' patchset[1].  As the patchset was too large,
I've broken it down to four patchsets and this is the first one.

These patches are against the current upstream[2] but should apply over
last few yet uncommitted patches from me[3].

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7632
[2] bef4a456b8dc8b3638f4d49a25a89e1467da9483
[3] http://article.gmane.org/gmane.linux.ide/7967
    http://article.gmane.org/gmane.linux.ide/7968
    http://article.gmane.org/gmane.linux.ide/7969
    http://article.gmane.org/gmane.linux.ide/7970
    http://article.gmane.org/gmane.linux.ide/7971
    http://article.gmane.org/gmane.linux.ide/7972

