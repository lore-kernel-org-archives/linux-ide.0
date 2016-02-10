From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH v4 0/3] ata: Fixes related to edge trigger latch for the ahci_xgene_driver.
Date: Wed, 10 Feb 2016 10:59:31 -0800
Message-ID: <CAOHikRBNL2gLJwhB2SEKJXZtOpmqwBET4P9RgRrPdhyH4bn0zA@mail.gmail.com>
References: <1454738124-9351-1-git-send-email-stripathi@apm.com>
	<20160210162547.GJ3741@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160210162547.GJ3741-qYNAdHglDFBN0TnZuCh8vA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Wed, Feb 10, 2016 at 8:25 AM, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Feb 06, 2016 at 11:25:21AM +0530, suman Tripathi wrote:
>> From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>>
>> This patch set implements a workaround for an errate in the APM
>> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
>> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
>> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
>> cycle. It also implements the capability to override generic interrupt
>> handler.
>
> Applied 1-3 to libata/for-4.6 with minor updates.

will this patchset  go to 4.5 ?

>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
