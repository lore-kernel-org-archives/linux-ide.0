From: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Mon, 13 Sep 2004 11:23:59 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4145672F.7060603@inet6.fr>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <200409102321.17042.bzolnier@elka.pw.edu.pl> <4142D3AE.5050602@inet6.fr> <200409111802.45628.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www01.ies.inet6.fr ([62.210.153.201]:27584 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S266474AbUIMJYI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Sep 2004 05:24:08 -0400
In-Reply-To: <200409111802.45628.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote the following on 09/11/2004 06:02 PM :

>>In fact I think I'm only a speed bumper here. There's so little work to 
>>do on the sis5513 driver now that I don't follow IDE work closely 
>>anymore and must refresh my memories even for such simple patches. I 
>>believe there are people around more fit than me for sis5513 maintenance.
>>    
>>
>
>I'm not aware of any such person...
>
>  
>

Vojtech seemed quite proficient at sis5513.c hacking :-)

>
>Dedicated maintainers are very useful even for legacy drivers.
>This way the subsystem maintainer doesn't have to worry about
>every fscking driver (less bugs, faster development). :-)
>
>  
>

Ok, if you think a dedicated maintainer is the way to go, I'll continue 
to review occasional patches. In fact I enjoy doing this from time to 
time, I was merely worried about not being the best fit for the job anymore.

Regards,

Lionel.
