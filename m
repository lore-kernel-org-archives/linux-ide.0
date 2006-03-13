From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: add @disable_on_err to ata_set_mode()
Date: Mon, 13 Mar 2006 17:09:00 +0900
Message-ID: <11422373402858-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:3486 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbWCMIJI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 03:09:08 -0500
Received: by zproxy.gmail.com with SMTP id 14so1228123nzn
        for <linux-ide@vger.kernel.org>; Mon, 13 Mar 2006 00:09:05 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello.

This patchset adds @disable_on_err to ata_set_mode().  If zero,
ata_set_mode() returns error code on failure; otherwise, only the
failing devices get disabled.  Note that the approach is slightly
different here because ATA xfer mode configuration is port-wide, so
ata_set_mode() acts as the final decision maker regarding device
offlining advised by @disable_on_err.

This patchset is against
  [1] the current upstream
+ [2] implement-per-dev-xfermask patchset

Thanks.

--
tejun

[1] fb21f0d0ec7e31cc814165e1a9d2662d9c9dd980
[2] http://article.gmane.org/gmane.linux.ide/8705


