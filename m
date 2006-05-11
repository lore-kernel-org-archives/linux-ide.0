From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 10/11] prep for PM support
Date: Fri, 12 May 2006 01:37:50 +0900
Message-ID: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:50067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030328AbWEKQh4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:37:56 -0400
Received: by wr-out-0506.google.com with SMTP id i12so407142wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:37:56 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Howdy,

This is part of patchset series described in [T].

This is the first take of prep-for-PM-support patchset.  This patchset
contains 7 patches and implements various stuff needed for PM.

One of important updates is the addition of ops->qc_defer().  This is
to let LLDDs determine which commands they can accept at the moment.
This is necessary for PM and controllers have wildely different
capabilities regarding how many/different commands can be issued to
how many devices concurrently.  More info is in the message [T].

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset
  + [5] add-NCQ-support patchset, take 3
  + [6] prep-for-hotplug support, take 2
  + [7] prep-LLDDs-for-hotplug-support, take 1
  + [8] add-hotplug-support, take 2
  + [9] implement-ata_link, take 1

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011
[6] http://article.gmane.org/gmane.linux.ide/10028
[7] http://article.gmane.org/gmane.linux.ide/10063
[8] http://article.gmane.org/gmane.linux.ide/10073
[9] http://article.gmane.org/gmane.linux.ide/10106


