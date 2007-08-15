From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream-fixes] libata: update HPA handling
Date: Thu, 16 Aug 2007 03:05:08 +0900
Message-ID: <20070815180508.GD21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:32103 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933736AbXHOSFc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:05:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2658wah
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 11:05:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

The current HPA handling implementation isn't robust enough and causes
regressions on several cases.  This patchset contains HPA handling
update.

* blacklist devices which puke on READ_NATIVE_MAX
* proper/better error handling - in most cases, HPA failure won't
  result in detection failure
* re-read IDENTIFY data after resizing
* more concise messages

Tested by setting up HPA area manually.

Thanks.

-- 
tejun
