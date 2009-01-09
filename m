From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: use WARN_ON_ONCE on hot paths
Date: Fri, 09 Jan 2009 07:03:14 -0500
Message-ID: <49673D02.6000002@garzik.org>
References: <b6fcc0a0901081202m30be591fse66e7f38477e0c0c@mail.gmail.com>	 <20090108221753.78648cd6@daedalus.pq.iki.fi>	 <20090108125317.648397d2@infradead.org> <49667C36.4080300@gmail.com>	 <20090108143127.437c15de@infradead.org> <4966974B.3090700@gmail.com>	 <49672166.4050606@gmail.com> <496724A2.5030400@kernel.org> <c4e36d110901090331r7c1cf06cy25c4a3a3579e47de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57824 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbZAIMD2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jan 2009 07:03:28 -0500
In-Reply-To: <c4e36d110901090331r7c1cf06cy25c4a3a3579e47de@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "Justin P. Mattock" <justinmattock@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Zdenek Kabelac wrote:
> 2009/1/9 Tejun Heo <tj@kernel.org>:
>> Convert WARN_ON() on command issue/completion paths to WARN_ON_ONCE()
>> so that libata doesn't spam the machine even when one of those
>> conditions triggers repeatedly.
>>
> 
> 
> Hi
> 
> I've not yet applied this patch - but now I'm getting these WARNS on my T61:
> (commit: 2150edc6c5cf00f7adb54538b9ea2a3e9cedca3f)
> 
> Is this patch solving the problem or just hiding warnings ?

Hiding warnings.  As Tejun noted in another email, this condition should 
not be happening in the first place.

If I had to guess, I would say that Arjan's patches assume it is OK to 
treat two ports on a single IDE controller as completely independent, 
when that is not really the reality of the hardware.

	Jeff




