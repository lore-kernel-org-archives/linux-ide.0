From: "Brian Rademacher" <rad@radfiles.net>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 16:22:22 -0700
Message-ID: <921508A38CE441ED9F2537C461007084@Rad>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com> <496E61E8.5010602@rtr.ca> <496E72D7.2070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:48030
	"EHLO QMTA09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753458AbZANXWW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 18:22:22 -0500
In-Reply-To: <496E72D7.2070206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>, Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Harri, as I reported on Redhat's Bugzilla 
(https://bugzilla.redhat.com/show_bug.cgi?id=462425), I think this is the 
fix as well...

Thanks for your port observation and Mark Lord's hard work on picking 
through the driver!!


----- Original Message ----- 
From: "Harri Olin" <harri.olin@gmail.com>
To: "Mark Lord" <liml@rtr.ca>
Cc: "IDE/ATA development list" <linux-ide@vger.kernel.org>; "Brian 
Rademacher" <rad@radfiles.net>; "Eamonn Hamilton" <EAMONN.HAMILTON@saic.com>
Sent: Wednesday, January 14, 2009 4:18 PM
Subject: Re: sata_mv: trial fix for lost NCQ interrupts


> Mark Lord wrote:
>> Harri Olin wrote:
>> ..
>>> I tried the patch and it works as well as it did without the patch. That 
>>> is to say, timeouts still happen, every couple of minutes on moderate
>> ..
>>
>> Yup.  On reflection, that patch has no effect, other than speeding things 
>> up.
>>
>> However, I think I *have* found the actual bug this time.
>> Try this patch and report back again.
>>
>> --- linux-2.6.28/drivers/ata/sata_mv.c    2009-01-13 
>> 15:57:11.000000000 -0500
>> +++ linux/drivers/ata/sata_mv.c    2009-01-14 16:56:38.000000000 -0500
>> @@ -883,7 +883,7 @@
>>         struct mv_host_priv *hpriv = ap->host->private_data;
>>         int hardport = mv_hardport_from_port(ap->port_no);
>>         void __iomem *hc_mmio = mv_hc_base_from_port(
>> -                    mv_host_base(ap->host), hardport);
>> +                    mv_host_base(ap->host), ap->port_no);
>>         u32 hc_irq_cause, ipending;
>>
>>         /* clear EDMA event indicators, if any */
>
> After first 55 minutes of testing, no timeouts yet, so I'm quite sure it 
> works ok now (yay!). Without this patch, timeouts happened every couple 
> minutes on similar load. I think I'll let it run for a day and report back 
> tomorrow how things are by then.
>
> Note that I didn't apply the previous patch as they don't apply on each 
> other. If needed, I can test it separately after running this for a while.
>
> Oh, and thanks for the hard work :)
>
> -- 
> Harri. 

