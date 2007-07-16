From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 3/4] libata: prep for PMP support, take 5
Date: Mon, 16 Jul 2007 18:39:43 +0900
Message-ID: <1184578783463-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:27564 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbXGPJjt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:39:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1517689wah
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:39:49 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>, htejun@gmail.com

Hello, all.

This is the fifth take of libata-pmp-prep patchset.  This patchset
contains 12 patches implementing various stuff needed for PMP.

#01	: add PMP related constants
#02-04	: various small stuff
#05-06	: qc_defer mechanism implementation
#07-11	: link/device quirks and EH fast-fail path - things needed to
	  handle quirky PMP fan-out links / pseudo devices.
#12	: SATA SDB notify handler

This patchset hasn't changed from the last take[L] other than being
regenerated.

This patchset is against

  libata-dev#upstream (d79eb6de54f180dc83b488b20747f0097fde3dea)
  + [1] misc-updates patchset
  + [2] libata-link patchset

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/20115
[1] http://thread.gmane.org/gmane.linux.ide/20824
[2] http://thread.gmane.org/gmane.linux.ide/20842


