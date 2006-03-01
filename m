From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement and use ata_dev_revalidate(), take #2
Date: Wed, 1 Mar 2006 17:20:39 +0900
Message-ID: <11412012393192-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:34020 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751354AbWCAIUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 03:20:44 -0500
Received: by zproxy.gmail.com with SMTP id 16so82810nzp
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 00:20:43 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This is the second take of implement-and-use-ata_dev_revalidate
patchset.  In the last take[1], out of four patches, %1 got ACK'ed, %2
had some minor issues, %3 got no comment and %4 had some issue but got
resolved.

Changes from the last take are...

* in #2, @verbose is renamed to @print_info as suggested
* in #2, lba_desc change is described in the patch description

This patchset is against
the current #upstream[2]
+ kill-illegal-kfree patch[3]
+ reorganize-ata_dev_identify patchset[4]

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/8050
[2] cccc65a3b60edaf721cdee5a14f68ba009341822
[3] http://article.gmane.org/gmane.linux.ide/8324
[4] http://article.gmane.org/gmane.linux.ide/8412


