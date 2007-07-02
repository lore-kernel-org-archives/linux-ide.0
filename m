From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 16:51:57 +0900
Message-ID: <4688AE9D.7060008@gmail.com>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:39441 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbXGBHwD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 03:52:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2217650wah
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 00:52:01 -0700 (PDT)
In-Reply-To: <4688AB51.8080801@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <sfs@enhance-it.dk>
Cc: linux-ide@vger.kernel.org

Stefan Skotte wrote:
> drivers/scsi/ipr.c: In function __ipr_eh_dev_reset:
> drivers/scsi/ipr.c:3955: warning: passing argument 4 of ata_do_eh from
> incompatible pointer type
> drivers/scsi/ipr.c: In function ipr_ata_phy_reset:
> drivers/scsi/ipr.c:5049: error: struct ata_port has no member named
> device
> drivers/scsi/ipr.c:5053: error: struct ata_port has no member named
> device
> drivers/scsi/ipr.c:5056: error: struct ata_port has no member named
> device
> make[3]: *** [drivers/scsi/ipr.o] Error 1
> make[2]: *** [drivers/scsi] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.22-rc6'
> make: *** [debian/stamp-build-kernel] Error 2

Aiee, that's my bad.  I forgot to convert ipr.

> I just removed the ipr module since I'm not going to use it, but maybe
> I'm doing something wrong since I'm usng the debian build process (?),
> anyways I downloaded 2.6.22-rc6 from testing on kernel.org, so that
> should atleast be right.
> 
> Thanks for getting back to me, I will report back how well my 3531-based
> controller fares...

Thanks.

-- 
tejun
