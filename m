From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: update EH / configuration behavior
Date: Wed, 31 Oct 2007 10:17:01 +0900
Message-ID: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:1276 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbXJaBdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:33:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello,

This patchset contains six small patches updating EH / configuration
behavior.  This series is focused on improving corner case handling.
The following behavior changes are made.

* More robust handling classification failures.

* Improve host link speed down handling when PMP is attached.

* When PMP is attached, don't configure downstream links faster than
  the host link.

Thanks.

--
tejun
