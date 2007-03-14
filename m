From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Wed, 14 Mar 2007 22:44:28 +0900
Message-ID: <45F7FC3C.1000203@gmail.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <200703141442.09754.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:42884 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913AbXCNNoe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 09:44:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so176880wxd
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 06:44:33 -0700 (PDT)
In-Reply-To: <200703141442.09754.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>> My drive is a slave on bus, where master is a modern Seagate ST3160812A.
>>
>> On my system I see two regressions:
>> - One between year 2002 kernels and SuSE Linux 10.0:
>>   Delay with "packet command initiated yet DRQ isn't asserted" before
>>   first read access, then the read will succeed.
>>   I did not yet reproduce this regression just now on my hardware.
>> - Second between SuSE 10.1 and 10.2:
>>   Delay with "packet command initiated yet DRQ isn't asserted" before
>>   any attempt to access, then it will fail.
>>   This regression is reproducible just now on my hardware, but still may
>>   be caused by hardware problems raised by a slightly different
>>   initialization order.
> 
> It is reproduceable, SuSE 10.1 kernel is "good" and SuSE 10.2 is "bad".
> So even if this is caused by some hardware problems or different
> initialization order git-bisect on 2.6.16-2.6.20 should tell us what
> change caused the problem.
> 
> PS Tejun, I praise efforts to make ATA floppy drives work with libata
> but this is IMO a _future_ work (won't help et all for existing
> systems/distributions) and we need to have ide-floppy fixed _now_.

Yeap, agreed but I think getting more info on the libata HSM violation
can help diagnosing ide problem too.  Anyways, Stanislav, can you bisect
as Bartlomiej requested?

-- 
tejun
