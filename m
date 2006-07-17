From: Tejun Heo <htejun@gmail.com>
Subject: [RFT][PATCHSET] hotplug polling, take 3
Date: Mon, 17 Jul 2006 16:00:48 +0900
Message-ID: <11531196483920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:31080 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932352AbWGQG7a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:59:30 -0400
Received: by nz-out-0102.google.com with SMTP id x7so399152nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:59:29 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of hotplug polling patchset.  As the name
implies, this patchset implements hotplug by polling.  Changes from
the last take[L] are.

* updated to accomodate earlier fixes & updates

* hp-poll is automatically disabled if the port enters any of static
  powersave mode.

* hp-poll can be manually disabled by setting
  libata.hotplug_polling_interval to zero.

This patchset is also available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/11862
[1] http://article.gmane.org/gmane.linux.ide/11966
[2] http://article.gmane.org/gmane.linux.ide/12001
[3] http://article.gmane.org/gmane.linux.ide/12002
[4] http://article.gmane.org/gmane.linux.ide/11870
[5] http://article.gmane.org/gmane.linux.ide/12138


