From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: fixes regarding configuration
Date: Fri, 27 Jan 2006 00:24:02 +0900
Message-ID: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:60563 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWAZPYJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:09 -0500
Received: by zproxy.gmail.com with SMTP id 34so368593nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:08 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: htejun@gmail.com

Hello, guys.

These are five small fix / cleanup patches regarding device
configuration.  These are against

upstream-2.6.17 (7db74a4780cf9cc6b2ea97582cdc8031d5f22ccd)
 + various fixes related to EH patchset [1]
 + three AHCI updates [2][3][4]
 + new reset mechanism patchset [5]

Except for #2, all deal with making per-dev configuration per-dev
instead of per-port.  These are largely in preparation for
soon-to-be-posted ata_dev_configure/revalidate patchset.

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=113798939526779&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=113800194919594&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=113800459922438&w=2
[4] http://marc.theaimsgroup.com/?l=linux-ide&m=113804195925385&w=2
[5] http://marc.theaimsgroup.com/?l=linux-ide&m=113809002924734&w=2

--
tejun

