From: Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bug #14622] Second IDE device not found
Date: Fri, 20 Nov 2009 03:41:44 -0500
Message-ID: <4B065648.6040609@garzik.org>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>	 <xXQGFmujPl.A.n7F.4SdALB@chimera>	 <20091119.120550.183823935.davem@davemloft.net> <40a4ed590911192359o563b104fo562f325ad9f5358e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <40a4ed590911192359o563b104fo562f325ad9f5358e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zeno Davatz <zdavatz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 11/20/2009 02:59 AM, Zeno Davatz wrote:
> On Thu, Nov 19, 2009 at 9:05 PM, David Miller<davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>  wrote:
>> From: "Rafael J. Wysocki"<rjw-KKrjLPT3xs0@public.gmane.org>
>> Date: Mon, 16 Nov 2009 23:37:47 +0100 (CET)
>>
>>> This message has been generated automatically as a part of a report
>>> of recent regressions.
>>>
>>> The following bug entry is on the current list of known regressions
>>> from 2.6.31.  Please verify if it still should be listed and let me know
>>> (either way).
>>>
>>>
>>> Bug-Entry     : http://bugzilla.kernel.org/show_bug.cgi?id=14622
>>> Subject               : Second IDE device not found
>>> Submitter     : Zeno Davatz<zdavatz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Date          : 2009-11-11 17:31 (6 days old)
>>> References    : http://marc.info/?l=linux-kernel&m=125796105822353&w=4
>>
>> We're going to need more information to diagnose this.
>>
>> And linux-ide should have been at least CC:'d from the very
>> beginning.
>>
>>  From what I can discern the problem is introduced somewhere between
>> 2.6.27 and 2.6.31, you have a Serverworks CSB5 and primarily the issue
>> is that attaching or detaching your CD-ROM driver influences whether
>> both of your disks are properly detected.  Correct?
>>
>> You seem to have played around with using the IDE layer vs. the
>> ATA layer.  Can you see any difference in behavior if you try
>> using just the IDE layer vs. just the ATA layer with the 2.6.31
>> kernel?
>
> Please see:
>
> http://www.flickr.com/photos/zrr/4118682747/
>
> and
>
> http://www.flickr.com/photos/zrr/4119453092/

Unfortunately, both of these photos only show that MD (block major 9) 
device could not be found for root.

For either ATA or IDE, we would need to see full dmesg somehow -- 
perhaps capturing serial console output?  (Documentation/serial-console.txt)


> I makes no difference if I choose ATA or only IDE.
>
> I am also attaching you my Kernel .config
>
> I could also test with 2.6.32-rc8 (torvalds-git)
>
> I suggest you send me two .config that I can both test with 2.6.31.6

I bet libata fails because CONFIG_BLK_DEV_SD is not enabled.  Probably 
want to enable CONFIG_BLK_DEV_SR too, for libata CD-ROM support.  I 
would be interested to see your failing ATA config, with IDE disabled.

	Jeff
