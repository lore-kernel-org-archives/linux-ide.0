From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: make some configurations per-dev
Date: Sun, 12 Feb 2006 23:32:58 +0900
Message-ID: <11397547782407-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:27538 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751118AbWBLOdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:33:02 -0500
Received: by pproxy.gmail.com with SMTP id f25so517498pyf
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:33:01 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

This patchset is another prep patchset for configuration reorganization,
concentrating on converting several configuration parameters per-dev
from being per-host.

This patchset is generated on top of

the current upstream[1]
+ misc preps for configuration reorganization[2]
+ 'don't do EDD handling if ->probe_reset is used' patch[3]

But should also play well with piix related patches[4].

Thanks.

--
tejun

[1] bef4a456b8dc8b3638f4d49a25a89e1467da9483
[2] http://article.gmane.org/gmane.linux.ide/7977
[3] http://article.gmane.org/gmane.linux.ide/7979
[4] http://article.gmane.org/gmane.linux.ide/7967
    http://article.gmane.org/gmane.linux.ide/7968
    http://article.gmane.org/gmane.linux.ide/7969
    http://article.gmane.org/gmane.linux.ide/7970
    http://article.gmane.org/gmane.linux.ide/7971
    http://article.gmane.org/gmane.linux.ide/7972

