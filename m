From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 13:45:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281306380.4244@woody.osdl.org>
References: <20061114150454.GA11900@havoc.gtf.org>
 <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org> <456CA429.9020507@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:40865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756883AbWK1VpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 16:45:14 -0500
In-Reply-To: <456CA429.9020507@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org



On Tue, 28 Nov 2006, Jeff Garzik wrote:
> 
> Does jgarzik/libata-dev.git#upstream (don't pull, just test) work for you?

Well, since I can't really test, I don't know. This problem has happened 
just once in the couple of weeks I've used that machine, and I wasn't even 
doing anything strange when it triggered (no heavy IO, no special 
programs, no nothing - I was literally just reading email and I think 
trying to browse over to news.com or something..)

So I was more hoping that you'd say that it's a known issue, and already 
fixed, or that the status bits would give you some clue and make you say 
"Ahh, we don't handle that case". I have nothing to "test". The thing 
seems to work, and I have no known way to trigger the problem...

> I'm pretty sure this is already fixed, by the polling IDENTIFY for ata_piix
> patchset.

Hmm. That sounds like it should just affect the bootup identification, 
which has always worked fine for me. Would it fix the softreset too?

Anyway, I can certainly try yout current "upstream" branch, but as 
mentioned, the standard kernel works fine for me generally, so I don't 
really know what I can offer (except if "upstream" simply doesn't work at 
all, in which case I'll certainly let you know ;)

		Linus
