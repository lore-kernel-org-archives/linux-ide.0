From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 3/4] libata: prep for PMP support, take 4
Date: Sun, 1 Jul 2007 19:26:07 +0900
Message-ID: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:25349 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164AbXGAK0M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884678wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:11 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello, all.

This is the fourth take of libata-pmp-prep patchset.  This patchset
contains 12 patches implementing various stuff needed for PMP.

#01	: add PMP related constants
#02-04	: various small stuff
#05-06	: qc_defer mechanism implementation
#07-11	: link/device quirks and EH fast-fail path - things needed to
	  handle quirky PMP fan-out links / pseudo devices.
#12	: SATA SDB notify handler

Changes from the last take[L] are.

* PMP related constants patch moved here from pmp patchset
* qc_defer CLEAR_EXCL fixed to clear excl_link iff it points to self
* addition of various quirks/special case handling vital for
  supporting first-gen PMP chips
* generalized SDB notify handling

This patchset is against

  libata-dev#upstream (4e1ae96828f6cee7b89ab8ca474c150fe211afd8)
  + [1] misc-updates patchset
  + [2] libata-link patchset, take 4

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/13500
[1] http://thread.gmane.org/gmane.linux.ide/20081
[2] http://thread.gmane.org/gmane.linux.ide/20099


