From: Etienne Basset <etienne.basset-Bf/eaXMDFuuXqB7oj33eUg@public.gmane.org>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Wed, 01 Jul 2009 23:30:31 +0200
Message-ID: <4A4BD577.2080609@numericable.fr>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>	 <1246459661.9660.40.camel@falcon>	 <200907011821.26091.bzolnier@gmail.com>	 <200907011829.16850.bzolnier@gmail.com> <b6a2187b0907011028r27d35be4xc62c7ed4496dfb2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b6a2187b0907011028r27d35be4xc62c7ed4496dfb2f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Chua <jeff.chua.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wuzhangjin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Jeff Chua wrote:
> On Thu, Jul 2, 2009 at 12:29 AM, Bartlomiej
> Zolnierkiewicz<bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Here is the more complete version, also taking into the account changes
>> in ide_intr() and ide_timer_expiry():
> 
> This works great for. Survived STR, STD. I just applied on top vanilla
> latest Linus's git pull. Nothing else to revert.
> 
> Thanks,
> Jeff.
> 
> 
i confirm, this  works for me too :)
thanks,
Etienne


>> ---
>>  drivers/ide/ide-io.c |   15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> Index: b/drivers/ide/ide-io.c
>> ===================================================================
>> --- a/drivers/ide/ide-io.c
>> +++ b/drivers/ide/ide-io.c
>> @@ -532,7 +532,8 @@ repeat:
>>
>>                if (startstop == ide_stopped) {
>>                        rq = hwif->rq;
>> -                       hwif->rq = NULL;
>> +                       if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0)
>> +                               hwif->rq = NULL;
>>                        goto repeat;
>>                }
>>        } else
>> @@ -679,8 +680,10 @@ void ide_timer_expiry (unsigned long dat
>>                spin_lock_irq(&hwif->lock);
>>                enable_irq(hwif->irq);
>>                if (startstop == ide_stopped && hwif->polling == 0) {
>> -                       rq_in_flight = hwif->rq;
>> -                       hwif->rq = NULL;
>> +                       if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
>> +                               rq_in_flight = hwif->rq;
>> +                               hwif->rq = NULL;
>> +                       }
>>                        ide_unlock_port(hwif);
>>                        plug_device = 1;
>>                }
>> @@ -856,8 +859,10 @@ irqreturn_t ide_intr (int irq, void *dev
>>         */
>>        if (startstop == ide_stopped && hwif->polling == 0) {
>>                BUG_ON(hwif->handler);
>> -               rq_in_flight = hwif->rq;
>> -               hwif->rq = NULL;
>> +               if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
>> +                       rq_in_flight = hwif->rq;
>> +                       hwif->rq = NULL;
>> +               }
>>                ide_unlock_port(hwif);
>>                plug_device = 1;
>>        }
>>
