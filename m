From: Tejun Heo <htejun@gmail.com>
Subject: sata_via: bit SATA_2DEV of SATA_PATA_SHARING register
Date: Thu, 20 Sep 2007 10:06:41 +0900
Message-ID: <46F1C7A1.8090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:38424 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXITBGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 21:06:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so340846rvb
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 18:06:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Jeff.

Do you recall why sata_via doesn't support configuration where SATA_2DEV
bit is set in the SATA_PATA_SHARING PCI conf reg?  Is it a leftover from
the days when libata didn't support mixed PATA/SATA setup?  I have a
machine which does that and just skipping the test makes it work just
fine and there's also a bug report reporting the same problem.  It seems
 some new chipset from via is setting the bit.

Thanks.

-- 
tejun
