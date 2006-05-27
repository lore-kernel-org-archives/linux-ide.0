From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 16:30:48 -0400
Message-ID: <4478B6F8.1090608@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:6817 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964966AbWE0Uar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:30:47 -0400
In-Reply-To: <4478B312.5040901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org

Jeff Garzik wrote:
> Jeff Garzik wrote:
>> This fixes a bug in alt4 v1, by eliminating the second ata_set_mode()
>> call, found in ata_device_resume().
>
> This seems to make my x86-64 box happier...
>
>     Jeff

((second attempt at sending this -- first one seems
to have been blocked by something, probably due to
an attached .jpg screenshot))

With alt4_v2 applied, resume still fails,
but slightly differently from before.

This time, there's the initial blank-screen for 31 seconds,
then the backlight turns on and I can see the syslog scrolling
in the window where I left it, as before.

New, is that the disk activity LED is stuck-on,
and the error-recovery code is doing something
every 30 seconds or so.

Screenshot here temporarily:  http://rtr.ca/libata1.jpg

Other than that, it's still dead -- disk I/O not working.

Can this patch be combined with Linus's one-liner
and still work on your machine?

Cheers 
