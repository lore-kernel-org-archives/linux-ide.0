From: Dan Porat <dan.porat@gmail.com>
Subject: Re: NCQ high speed data integrity issues
Date: Thu, 17 Dec 2009 08:49:54 +0200
Message-ID: <93b143da0912162249q2b439537hb9d18dae00359d38@mail.gmail.com>
References: <93b143da0912151129obdf3613q558295b320e4db65@mail.gmail.com>
	 <da824cf30912151247r14c4e29cp6c97421683d82eb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:34869 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbZLQGtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:49:55 -0500
Received: by fg-out-1718.google.com with SMTP id 19so805436fgg.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:49:54 -0800 (PST)
In-Reply-To: <da824cf30912151247r14c4e29cp6c97421683d82eb2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org

Variyng the speed - using usleep.

bpt is a parameter but when used over sd , it seems to be ignored somehow , and
transfers have variating sizes.

regarding the data - since the problem is a timing issues or
synchronization issue , it does not always appear.
The disk is written with the same character and when read , using
sgp_dd , sometimes , some data is just different.

We know for sure that the data is written correctly as it sometimes
does succeed to read all successfully.
No errors are to be seen in kernel level , and definitely not in the
application side.

We have seen that the more threads there are , the more likely this
problem to occur.
Same as the amount of data.
The bigger the data , the more likely for us to see the problem.

Any suggestion how to investigate ?


Dan Porat

On Tue, Dec 15, 2009 at 10:47 PM, Grant Grundler <grundler@google.com> wrote:
>
> On Tue, Dec 15, 2009 at 11:29 AM, Dan Porat <dan.porat@gmail.com> wrote:
> > I am running into data integrity issues while running sgp_dd ver 1.20
> > against any sg device while running 31 threads.
> > kernel 2.6.28 Ubuntu.
> > When running it in slow speed (20 MB/s) all runs well.
> > When pushing it towards the 50MB/s , Data integrity issues appear.
>
> How are you varying the speed?
>
> > When running it against sd devices - no integrity issues , but bpt is
> > not determined and changes .
>
> Hrm? bpt is a parameter. What do you mean?
>
> I don't know offhand why sg vs sd would make a difference but it's
> obviously of interest.
>
> > Any idea how to fix the sg data integrity issues?
>
> Can you post Good vs Bad data?
> Knowing the offset, size, and type of corruption will help narrow down
> possible sources of corruption.
>
> Any errors reported by the device driver, memory controller, sg device?
>
> cheers,
> grant
