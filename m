From: Jeff Garzik <jeff@garzik.org>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 09:49:01 -0400
Message-ID: <4505694D.5020304@garzik.org>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36787 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750776AbWIKNtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2006 09:49:03 -0400
In-Reply-To: <450568F3.3020005@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Sergei Shtylyov wrote:
>    It's not likely I'll be able to try it. But I'm absolutely sure that 
> drive aborted the read commands with the sector count of 0 (i.e. 256 
> actually). The exact model was IBM DHEA-34331.
>    255 sectors actually seems more safe bet.

This sort of thing should be handled by quirks, depending on the 
controller and drive.

That's why I was asking for testing, to see if the current code already 
handles this.

	Jeff


