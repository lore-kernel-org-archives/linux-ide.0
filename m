From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_qstor, pdc_adma, sata_sx4: convert to new EH
Date: Fri, 03 Aug 2007 20:58:26 +0900
Message-ID: <46B31862.10201@gmail.com>
References: <20070724011404.GA14064@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:27089 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbXHCMDc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 08:03:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so830464wah
        for <linux-ide@vger.kernel.org>; Fri, 03 Aug 2007 05:03:32 -0700 (PDT)
In-Reply-To: <20070724011404.GA14064@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mlord@pobox.com

Jeff Garzik wrote:
> This is just a refresh of the existing libata-dev.git#new-eh patches
> that convert all remaining old-EH drivers to new EH, against 2.6.23-rc1.
> 
> All three conversions are completely untested.  pdc_adma and sata_qstor
> need reviewing by someone with docs, in addition to testing.
> 
> Even "it still works" or "this patch breaks stuff" feedback from users
> is useful.

pdc_adma works fine.  Tested both a harddrive and a cdrom.  ATAPI check
sense seems to work and harddrive was successfully recovered from
timeout induced by shaking the harddisk for 30s.  :-)

-- 
tejun
