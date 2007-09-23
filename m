From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 1/2] libata: prep for PMP support, take 6
Date: Sun, 23 Sep 2007 13:14:11 +0900
Message-ID: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:50630 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbXIWEOS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:14:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1140954rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:14:18 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the sixth take of libata-pmp-prep patchset.  This patchset
contains 12 patches implementing various stuff needed for PMP.

#01-04	: various small stuff
#05-06	: qc_defer mechanism implementation
#07-11	: link/device quirks and EH fast-fail path - things needed to
	  handle quirky PMP fan-out links / pseudo devices.
#12	: AN demultiplexer - sata_async_notification()

Change from the last take[L] are...

* Updated to handle both ATAPI AN and PMP AN as ATAPI AN has been
  merged inbetween.  This is done by adding new patch #01 and updating
  patch #12.

This patchset is against

  libata-dev#upstream (b56feca2ede0dd11a8409743ff14cf14cbcf5062)
  + [1] sata_sil24-fix-IRQ-clearing-race-when-PCIX_IRQ_WOC-is-used

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20857
[1] http://article.gmane.org/gmane.linux.ide/22918 


