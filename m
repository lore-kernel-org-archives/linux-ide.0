From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [Bug #12263] Sata soft reset filling log
Date: Mon, 16 Feb 2009 18:31:28 +0300
Message-ID: <499986D0.3000205@ru.mvista.com>
References: <sTyoMUwdm9B.A.QCH.U40lJB@chimera> <200902152221.43834.rjw@sisk.pl> <20090215223045.GC29300@elte.hu> <200902160012.57584.rjw@sisk.pl> <499983DF.5050503@ru.mvista.com> <49998480.3090408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49998480.3090408-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: Justin Madru <jdm64-u1xxEuL7cY4AvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IDE <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>, Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello, I wrote:

>>>>>>> This message has been generated automatically as a part of a report
>>>>>>> of regressions introduced between 2.6.27 and 2.6.28.

>>>>>>> The following bug entry is on the current list of known regressions
>>>>>>> introduced between 2.6.27 and 2.6.28.  Please verify if it still 
>>>>>>> should
>>>>>>> be listed and let me know (either way).

>>>>>>> Bug-Entry    : http://bugzilla.kernel.org/show_bug.cgi?id=12263
>>>>>>> Subject        : Sata soft reset filling log
>>>>>>> Submitter    : Justin Madru <bevicm-QP1aEjBt37AFQeE35raUng@public.gmane.org>
>>>>>>> Date        : 2008-12-13 2:07 (64 days old)
>>>>>>> References    : 
>>>>>>> http://marc.info/?l=linux-kernel&m=122913412608533&w=4

>>>>>> I'm still seeing this on .29-rc5, and I think that my bug #12263 
>>>>>> is a duplicate of bug #12609,
>>>>>> or more correctly it's a duplicate of mine because I reported first.

>>>>>> It seems like the bug has been fixed in tip/master for some time now.
>>>>>> Below is the diff of origin and tip from when I tested.

>>>>> Ingo, do you know whinch patch in -tip fixes this regression?

>>>> This one, done on Jan 10, more than a month ago:

>>>>  f1d26da: Revert "libata: Add 32bit PIO support"

>>>> When a commit causes trouble in -tip qa i immediately revert it in 
>>>> 95% of the cases, no questions asked. Especially if it's related to 
>>>> persistent storage.

>>> OK, thanks.

>>> We seem to have a working fix patch for this issue in bug #12609.

>>    Wait, if this is indeed post-2.6.27 regression, it couldn't 
>> possibly have been caused by that patch which got merged during 
>> 2.6.29-rc1 timeframe. Something's up with this bug...

>    Also, it's been reported for a hard disk while regression in bug 
> 12609 only hits the ATAPI devices.  I think that bug 12263 needs to be reopened.

    After referring to the SCSI command codes "cdb 0x1e" means ALLOW MEDIUM 
REMOVAL command -- which could hardly be addressed to an usual hard disk. So, 
it looks like we had a case of the confused bug report which has a lot of info 
on the hard disk while errors were most probably happening with a CD/DVD 
drive. :-)

MBR, Sergei
