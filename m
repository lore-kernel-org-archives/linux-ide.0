From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Wed, 14 Mar 2007 20:58:03 +0900
Message-ID: <45F7E34B.6020206@gmail.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:18541 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161176AbXCNL6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 07:58:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so559010uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 04:58:15 -0700 (PDT)
In-Reply-To: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislav Brabec <sbrabec@novell.com>
Cc: albertl@mail.com, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Stanislav Brabec wrote:
> Looking at the syslog in Novell bug 232086 in detail, following line may
> indicate hardware failure:
> usb 5-1: string descriptor 0 read error: -22

I don't think usb 5-1 is related to ide-floppy problem.

> My drive is a slave on bus, where master is a modern Seagate ST3160812A.
> 
> On my system I see two regressions:
> - One between year 2002 kernels and SuSE Linux 10.0:
>   Delay with "packet command initiated yet DRQ isn't asserted" before
>   first read access, then the read will succeed.
>   I did not yet reproduce this regression just now on my hardware.
> - Second between SuSE 10.1 and 10.2:
>   Delay with "packet command initiated yet DRQ isn't asserted" before
>   any attempt to access, then it will fail.
>   This regression is reproducible just now on my hardware, but still may
>   be caused by hardware problems raised by a slightly different
>   initialization order.

I see.

> Tejun Heo wrote:
>> [libata]
>> And, as the device requires custom high level driver, libata fails
>> miserably.  Would it be worth to try support these devices?  Or are
>> they just too outdated to put the effort in?
> 
> As far as I remember, it was working without any special driver with
> ide-scsi.

If that's the case, libata should work too as long as the HSM problem is
fixed.

-- 
tejun
