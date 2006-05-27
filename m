From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATAPI works on via_sata, but only sort of.
Date: Fri, 26 May 2006 23:08:26 -0400
Message-ID: <4477C2AA.8080807@garzik.org>
References: <1138507667.9669.6.camel@localhost.localdomain>	 <4477A3C3.9080808@garzik.org> <1148699141.20002.2.camel@laika.home.floam.sh.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56293 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751777AbWE0DI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 23:08:29 -0400
In-Reply-To: <1148699141.20002.2.camel@laika.home.floam.sh.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Gyes <floam@sh.nu>
Cc: linux-ide@vger.kernel.org

Aaron Gyes wrote:
> On Fri, 2006-05-26 at 20:56 -0400, Jeff Garzik wrote:
>> Aaron Gyes wrote:
>>> Hi,
>>>
>>> I recently tried out 2.6.16-rc1-mm3 to see if my Plextor PX716-SA would
>>> magically come to life, it did. It had previously not worked in 2.6.15
>>> with the correct parameters being passed to libata. I can seem to read
>>> CDs okay, however every single attempt at burning a CD thus far has
>>> resulted in either a CD that doesn't work or a CD with CRC errors. Is
>>> this expected/known? Can I do anything to fix it or help diagnose the
>>> problem further?
>>>
>>> My motherboard is a Asus A8V, VIA K8T800Pro.
>> Can you verify that 2.6.17-rc5 or the latest -mm works for you?
> 
> 2.6.17-rc4 + libata-dev did not. I made this post a couple days ago:
> 
> http://lkml.org/lkml/2006/5/23/13
> 
> If there is something specifically in -rc5 or -mm let me know and I can
> try that.

Both rc5 and -mm include fixes for this, that's why I made my request :)

	Jeff



