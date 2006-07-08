From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 2/3] prep for PMP support, take 2
Date: Sat, 8 Jul 2006 14:51:17 +0900
Message-ID: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:62072 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964775AbWGHFu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:26 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206133wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:25 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Howdy,

This is part of patchset series described in [T].

This is the first take of libata-pmp-prep patchset.  This patchset
contains 6 patches and implements various stuff needed for PMP.

Changes from the last take[L] are.

* s/pm/pmp/g
* link resume handling updated

This patchset is against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
  + [1] hp-poll patchset, take #2
  + [2] libata-link patchset, take 2

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11927
[L] http://article.gmane.org/gmane.linux.ide/10112
[1] http://article.gmane.org/gmane.linux.ide/11862
[2] http://article.gmane.org/gmane.linux.ide/11928


