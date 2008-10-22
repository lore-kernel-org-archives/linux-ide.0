From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [git pull] IDE updates #4
Date: Wed, 22 Oct 2008 16:44:55 +0400
Message-ID: <48FF2047.6000509@ru.mvista.com>
References: <200810212100.52985.bzolnier@gmail.com>	 <48FF134F.2070509@ru.mvista.com> <58cb370e0810220514x419c9669jba1b7be942d3644a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35327 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752451AbYJVMpD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 08:45:03 -0400
In-Reply-To: <58cb370e0810220514x419c9669jba1b7be942d3644a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> Remove needless/confusing subdirs from drivers/ide/.
>> I think that with 2 new drivers being submitted/reworked based on feedback
>> and several patches submitted and pending submission to the pata-2.6 series
>> this really could have waited till 2.6.29...
>>     
>
> The situation is perfect right now for this change as there are no outstanding
> patches in pata-2.6 tree 

   There was one patch (already stale TX4939 version driver) as of 
yesterday.

> and number of new submitted patches is < 10 (I'll take
> care of fixing them up, ditto for all other new stuff that will be using old
> naming scheme).
>   

   Thanks for clarifying this.
   This rename only added more uncertainty for my pending patchset 
(which had been already dependant on at least TX4939 driver which keeps 
being recast by Atsushi and being stale in pata-2.6 series) as I can't 
predict when you and Linus will merge the changes and this is getting on 
my nerves, as I don't have time on any extra rework and I'm running out 
of time with the submission. I know I should have done this earlier and 
I'd have done this if its not for my unfortunate vacations... I aslso 
kept finding new issues looking on the IOC4 driver. :-/

> Thanks,
> Bart
>   

MBR. Sergei


