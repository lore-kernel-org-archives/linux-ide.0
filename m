From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Kernel 2.6.6 Bug !!!!
Date: Mon, 10 May 2004 14:22:13 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409F9015.4020707@superbug.demon.co.uk>
References: <409F64B7.6050906@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:43276 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S264704AbUEJOWZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2004 10:22:25 -0400
In-Reply-To: <409F64B7.6050906@yahoo.de>
List-Id: linux-ide@vger.kernel.org
To: Stefan <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org

Stefan wrote:
> Sorry for posting this to the ide list, but it is the only one I'm 
> registered.
> 
> I just got the new kernel 2.6.6. It seems like there is a really bad bug 
> in it.
> The Nvidia driver and my soundcard driver (this one I wrote myself), 
> don't work anymore.
> 
> 
> cmaudio.ko

You say you wrote the soundcard driver yourself.
Does alsa support your sound card. If not, I think the alsa project 
would be very interested to look at your source code, so that they could 
add support for it in alsa, and therefore the linux 2.6.x kernel would 
have native support for it

Just a thought.

James
