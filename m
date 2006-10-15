From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] hotplug polling, take 5
Date: Mon, 16 Oct 2006 07:37:26 +0900
Message-ID: <11609518461142-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:64583 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161197AbWJOWhd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:37:33 -0400
Received: by py-out-1112.google.com with SMTP id n25so2068070pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:37:33 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the fifth take of hotplug polling patchset.  This take doesn't
contain any real change than rebasing over the current upstream[U].
PMP patchset will be posted soon on top of this patchset and I wanted
to avoid confusion by posting patchsets in order.

As the name implies, this patchset implements hotplug by polling.
hp-poll is used to

* Monitor ports EH gave up.  When EH gives up on a port, it freezes
  the port to protect the rest of the system from it.  The user used
  to have to issue manual scan to retry the port.  hp-poll can monitor
  such port and retry it when hotplug event is detected.  This is also
  used by PMP support.

* Support hotplug on controllers which can report hotplug conditions
  but cannot raise interrupt.

Changes from the last take[L] are.

* updated to the current upstream

This patchset is also available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll

Thanks.

--
tejun

[U] da54f5fe54c7d75e2db7d17961fb36a8c28a8501
[L] http://article.gmane.org/gmane.linux.ide/13418


