From: Grant Coady <gcoady.lk@gmail.com>
Subject: Re: PATA drivers queued for 2.6.19
Date: Wed, 06 Sep 2006 07:24:09 +1000
Message-ID: <lcqrf2hjo1fo28jpikf4iebq55c955folf@4ax.com>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com> <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr> <44FD7B1E.7020102@aitel.hist.no> <1157467176.9018.48.camel@localhost.localdomain> <b9arf2lrbh5v4pv9klbtujfhvq3hiuehdk@4ax.com> <m3veo2b3ht.fsf@defiant.localdomain>
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:31930 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751375AbWIEVYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 17:24:19 -0400
In-Reply-To: <m3veo2b3ht.fsf@defiant.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Helge Hafting <helge.hafting@aitel.hist.no>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

On Tue, 05 Sep 2006 19:57:34 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:

>Grant Coady <gcoady.lk@gmail.com> writes:
>
>> Which leads back to this slackware user, who's never used an initrd, 
>> thinking about dual root partitions just to get the name change from 
>> another /etc/fstab?  
>
>I think it's unnecessary, /etc/fstab is not used while mounting root fs,
>and both mount and fsck should understand labels (i.e., you can put
>labels there, even for root fs).

Thanks, Krzysztof, Alan and others, I can do labels now, avoiding 
them too long ;)

Grant.
