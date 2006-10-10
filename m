From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] hotplug polling, take 4
Date: Tue, 10 Oct 2006 14:36:12 +0900
Message-ID: <116045857221-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:21785 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964993AbWJJFgW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Oct 2006 01:36:22 -0400
Received: by nf-out-0910.google.com with SMTP id x30so189400nfb
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 22:36:21 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the fourth take of hotplug polling patchset.  As the name
implies, this patchset implements hotplug by polling.  hp-poll is used
to

* Monitor ports EH gave up.  When EH gives up on a port, it freezes
  the port to protect the rest of the system from it.  The user used
  to have to issue manual scan to retry the port.  hp-poll can monitor
  such port and retry it when hotplug event is detected.  This is also
  used by PMP support.

* Support hotplug on controllers which can report hotplug conditions
  but cannot raise interrupt.

Changes from the last take[L] are.

* updated to the current upstream

* global hp_poll_list and hp_poll_work replaced with per-host
  hp_poll_task

This patchset is also available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll
  (web is temporarily down, but git pull works)

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/12151


