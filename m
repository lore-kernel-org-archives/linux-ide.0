From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 02/03] prep LLDDs for hotplug support, take 2
Date: Sat, 20 May 2006 00:38:10 +0900
Message-ID: <11480530901755-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:13143 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932352AbWESPiR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:38:17 -0400
Received: by py-out-1112.google.com with SMTP id z59so963255pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:38:16 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the second take of prep-LLDDs-for-hotplug-support patchset.
Not much has changed since the last take[L].  Note that making TF
access optional has been nacked, so sata_sil24 might have to retain TF
caching.

This patchset is against

  upstream (8d4ee71ff6de5255ebfdf44fb83419d27bd06368)
  + enforce-default-EH-actions patch [1]
  + scsi_implement_eh-patch [2]
  + prep-for-hotplug-support patchset [3]

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10530
[L] http://article.gmane.org/gmane.linux.ide/10063
[1] http://article.gmane.org/gmane.linux.ide/10317
[2] http://article.gmane.org/gmane.linux.ide/10529
[3] http://article.gmane.org/gmane.linux.ide/10546


