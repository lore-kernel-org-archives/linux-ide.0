From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 07/11] prep LLDDs for hotplug support, take 1 (REPOST)
Date: Fri, 12 May 2006 00:14:58 +0900
Message-ID: <11473604983883-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:62512 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030245AbWEKPPE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:15:04 -0400
Received: by wr-out-0506.google.com with SMTP id i12so388403wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:15:03 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hairu.

This is part of patchset series described in [T].

This is the first take of prep-LLDDs-for-hotplug-support patchset.
Some of patches in this patchset are from the first take of
add-hotplug-support patchset.

Things worth noting are

* Simply exporting ata_hsm_move() and calling the function with
  appropriate status is good enough for driving HSM for LLDDs
  implementing their own irq handlers.  sata_sil's new irq handler
  now uses it.

* TF faking is removed from sata_sil24.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset
  + [5] add-NCQ-support patchset, take 3
  + [6] prep for hotplug support, take 2

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011
[6] http://article.gmane.org/gmane.linux.ide/10028


