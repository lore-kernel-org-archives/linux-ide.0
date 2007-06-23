From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] qd65xx: fix PIO mode selection
Date: Sat, 23 Jun 2007 23:48:48 +0400
Message-ID: <467D7920.2090300@ru.mvista.com>
References: <200706232002.07091.bzolnier@gmail.com> <20070623204221.27f52df1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15441 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751559AbXFWTrH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 15:47:07 -0400
In-Reply-To: <20070623204221.27f52df1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>PIO4 is a maximum PIO mode supported by a driver.  Using "255" as a max_mode
>>argument to ide_get_best_pio_mode() could result in wrong timings being used
>>by a driver (for "pio" equal to 5) or OOPS (for "pio" values > 5 && < 255).

> The qdi6580 driver is somewhat hosed. The libata one worked on the single

[...]

> Possibly we should just drop support as I know of only one user and thats
> purely to test the code

    I remember actually using this piece of [insert yourself] back in 199[45], 
not in Linux though... :-)

> Alan

MBR, Sergei
