From: Zeno Davatz <zdavatz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #14622] Second IDE device not found
Date: Fri, 20 Nov 2009 10:29:03 +0100
Message-ID: <40a4ed590911200129p6f0d048dqef10df2b311d4744@mail.gmail.com>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>
	 <xXQGFmujPl.A.n7F.4SdALB@chimera>
	 <20091119.120550.183823935.davem@davemloft.net>
	 <40a4ed590911192359o563b104fo562f325ad9f5358e@mail.gmail.com>
	 <4B065648.6040609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B065648.6040609-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Nov 20, 2009 at 9:41 AM, Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org> wrote:
> On 11/20/2009 02:59 AM, Zeno Davatz wrote:
>>
>> On Thu, Nov 19, 2009 at 9:05 PM, David Miller<davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org> =A0=
wrote:
>>>
>>> From: "Rafael J. Wysocki"<rjw-KKrjLPT3xs0@public.gmane.org>
>>> Date: Mon, 16 Nov 2009 23:37:47 +0100 (CET)
>>>
>>>> This message has been generated automatically as a part of a repor=
t
>>>> of recent regressions.
>>>>
>>>> The following bug entry is on the current list of known regression=
s
>>>> from 2.6.31. =A0Please verify if it still should be listed and let=
 me know
>>>> (either way).
>>>>
>>>>
>>>> Bug-Entry =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D1=
4622
>>>> Subject =A0 =A0 =A0 =A0 =A0 =A0 =A0 : Second IDE device not found
>>>> Submitter =A0 =A0 : Zeno Davatz<zdavatz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> Date =A0 =A0 =A0 =A0 =A0: 2009-11-11 17:31 (6 days old)
>>>> References =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1257961=
05822353&w=3D4
>>>
>>> We're going to need more information to diagnose this.
>>>
>>> And linux-ide should have been at least CC:'d from the very
>>> beginning.
>>>
>>> =A0From what I can discern the problem is introduced somewhere betw=
een
>>> 2.6.27 and 2.6.31, you have a Serverworks CSB5 and primarily the is=
sue
>>> is that attaching or detaching your CD-ROM driver influences whethe=
r
>>> both of your disks are properly detected. =A0Correct?
>>>
>>> You seem to have played around with using the IDE layer vs. the
>>> ATA layer. =A0Can you see any difference in behavior if you try
>>> using just the IDE layer vs. just the ATA layer with the 2.6.31
>>> kernel?
>>
>> Please see:
>>
>> http://www.flickr.com/photos/zrr/4118682747/
>>
>> and
>>
>> http://www.flickr.com/photos/zrr/4119453092/
>
> Unfortunately, both of these photos only show that MD (block major 9)=
 device
> could not be found for root.
>
> For either ATA or IDE, we would need to see full dmesg somehow -- per=
haps
> capturing serial console output? =A0(Documentation/serial-console.txt=
)

Ok, I appended

console=3DttyS1,9600 console=3Dtty0

to the kernel command line at lilo after choosing the kernel image and
I get a ton of output. But how to I save the output to a file?

>> I makes no difference if I choose ATA or only IDE.
>>
>> I am also attaching you my Kernel .config
>>
>> I could also test with 2.6.32-rc8 (torvalds-git)
>>
>> I suggest you send me two .config that I can both test with 2.6.31.6
>
> I bet libata fails because CONFIG_BLK_DEV_SD is not enabled. =A0Proba=
bly want
> to enable CONFIG_BLK_DEV_SR too, for libata CD-ROM support. =A0I woul=
d be
> interested to see your failing ATA config, with IDE disabled.

I enabled CONFIG_BLK_DEV_SR. Do you want above test with or without

CONFIG_BLK_DEV_SVWKS (OSB4/CSB5) enabled?

Best
Zeno
