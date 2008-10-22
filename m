From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [git pull] IDE updates #4
Date: Wed, 22 Oct 2008 14:14:17 +0200
Message-ID: <58cb370e0810220514x419c9669jba1b7be942d3644a@mail.gmail.com>
References: <200810212100.52985.bzolnier@gmail.com>
	 <48FF134F.2070509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:8134 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYJVMOS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 08:14:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2931065rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Oct 2008 05:14:17 -0700 (PDT)
In-Reply-To: <48FF134F.2070509@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 22, 2008 at 1:49 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
>> Remove needless/confusing subdirs from drivers/ide/.
>>
>
>  I think that with 2 new drivers being submitted/reworked based on feedback
> and several patches submitted and pending submission to the pata-2.6 series
> this really could have waited till 2.6.29...

The situation is perfect right now for this change as there are no outstanding
patches in pata-2.6 tree and number of new submitted patches is < 10 (I'll take
care of fixing them up, ditto for all other new stuff that will be using old
naming scheme).

Thanks,
Bart
