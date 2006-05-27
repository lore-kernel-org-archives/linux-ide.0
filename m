From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATAPI works on via_sata, but only sort of.
Date: Fri, 26 May 2006 20:56:35 -0400
Message-ID: <4477A3C3.9080808@garzik.org>
References: <1138507667.9669.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21986 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932779AbWE0A4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 20:56:38 -0400
In-Reply-To: <1138507667.9669.6.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Gyes <floam@sh.nu>
Cc: linux-ide@vger.kernel.org

Aaron Gyes wrote:
> Hi,
> 
> I recently tried out 2.6.16-rc1-mm3 to see if my Plextor PX716-SA would
> magically come to life, it did. It had previously not worked in 2.6.15
> with the correct parameters being passed to libata. I can seem to read
> CDs okay, however every single attempt at burning a CD thus far has
> resulted in either a CD that doesn't work or a CD with CRC errors. Is
> this expected/known? Can I do anything to fix it or help diagnose the
> problem further?
> 
> My motherboard is a Asus A8V, VIA K8T800Pro.

Can you verify that 2.6.17-rc5 or the latest -mm works for you?

	Jeff



