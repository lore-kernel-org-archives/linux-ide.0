From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: prep for new EH
Date: Sat, 1 Apr 2006 19:48:36 +0900
Message-ID: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:25460 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbWDAKsl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:41 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210250nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:41 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff, Alan and Albert.

This patchset contains various fixes and updates in preparation for
new EH.  Most patches are straight-forward and even trivial.

This patchset has 15 patches and is against
  #upstream [1]
  + improve-ata_bus_probe-failure-handling patchset[2]

Thanks.

--
tejun

[1] 8b316a3973f05e572b4edeeda9072987f6bbaa44
[2] http://article.gmane.org/gmane.linux.ide/9170


