From: Tejun Heo <htejun@gmail.com>
Subject: Re: Stardom SATA HSM violation
Date: Fri, 07 Sep 2007 09:58:19 +0900
Message-ID: <46E0A22B.6040202@gmail.com>
References: <46CFA08E.6090604@arbores.ca> <6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com> <46DBCB6C.8080206@gmail.com> <46E01601.9010907@arbores.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:44222 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875AbXIGA61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 20:58:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so288443rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 17:58:26 -0700 (PDT)
In-Reply-To: <46E01601.9010907@arbores.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bryan@arbores.ca
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Michal.k.k.Piotrowski@gmail.com, Andrew Morton <akpm@linux-foundation.org>

Bryan Woods wrote:

> The full dmesg and hdparm -I command output are attached.
> 
> I have received word from the vendor that the Stardom 2611 will do
> RAID0 or 1 under windows, but only RAID1 under Linux. (Their manual
> said it worked with Linux but failed to mention the RAID mode
> restriction: argh!)
> 
> They recommended the 2600 model for RAID0 with Linux, but that model
> is only SATA-I so I will probably go with alternate hardware.
> 
> The vendor also suggested the possibility of a firmware upgrade to
> the 2611 - I am still waiting to hear. I will post a followup if
> this happens.

If possible, please post dmesg from 2.6.22.5.

Thanks.

-- 
tejun
