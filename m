From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: convert ata_piix to use new reset mechanism
Date: Wed, 15 Feb 2006 15:01:42 +0900
Message-ID: <11399833022059-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:9527 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422990AbWBOGBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 01:01:47 -0500
Received: by pproxy.gmail.com with SMTP id i49so1378326pyi
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 22:01:46 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

This patchset is re-spin of [1].  This patchset performs cable detection
before proceeding with probe reset as pointed out [2].  This patchset
contains three patches.  The first one fixes comment above std postreset
which indicated that setting cable type is the responsibility of
postreset.  The last two patches are the piix conversion patches.

Thanks.  :-)

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7968
[2] http://article.gmane.org/gmane.linux.ide/7986

