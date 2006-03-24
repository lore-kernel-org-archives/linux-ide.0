From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: add @disable_on_err to ata_set_mode(), take#2
Date: Fri, 24 Mar 2006 15:25:30 +0900
Message-ID: <11431815303216-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:14279 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423165AbWCXGZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 01:25:35 -0500
Received: by zproxy.gmail.com with SMTP id o37so734487nzf
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 22:25:35 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of add-disable_on_err-to-ata_set_mode
patchset.  Changes from the last take[1] are...

* a new patch check-disable-after-internal-cmd is added.  This makes
  ata_exec_internal() to check whether LLDD disabled the port after an
  internal command and handle the situation.  This change allows upper
  layers to operate under the assumption that lower layer does not
  diddle with port/device enable status.  Note that this is a
  temporary measure, to be removed once all LLDDs are updated to the
  new API.

This patchset is against
current upstream[2]
+ implement-per-dev-xfer-masks patchset, take#2 [3]

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8754
[2] 2cc432eed0491df66e14b578139bba2c75fb3f9a
[3] http://article.gmane.org/gmane.linux.ide/9001


