From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: ahci: implement workaround for ASUS P5W-DH Deluxe
 ahci_broken_hardreset(), take #2
Date: Thu, 25 Oct 2007 15:12:18 +0900
Message-ID: <472033C2.2050000@gmail.com>
References: <20071025055916.GG11853@htj.dyndns.org> <47203295.9010004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:30986 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbXJYGMZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 02:12:25 -0400
Received: by wa-out-1112.google.com with SMTP id v27so511019wah
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 23:12:25 -0700 (PDT)
In-Reply-To: <47203295.9010004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> P5W-DH Deluxe has ICH9 which doesn't have PMP support but SIMG 4726

Jim Paris just pointed out.  It can't be ICH9.  JFYI, s/ICH9/ICH7R/. 
Doesn't really matter tho.

Thanks.

-- 
tejun
