From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] hpt366: fix HPT37x PIO mode timings
Date: Fri, 07 Dec 2007 22:03:39 +0300
Message-ID: <4759990B.1000807@ru.mvista.com>
References: <200712072116.21795.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27779 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751097AbXLGTDX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 14:03:23 -0500
In-Reply-To: <200712072116.21795.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> After looking into the HPT370 manual (now that I have it) and re-checking all
> the timing tables, here's what I have discovered:

> - at 33 MHz clock, PIO mode 0 timings turned to be overclocked, and all other
>   PIO modes underclocked;

> - at 50 MHz clock, PIO modes 0 to 2 turned to be oveclocked;

    Argh, just noticed that PIO0 setup time is still overclocked at 33/50 
MHz... :-/

> - at 66 MHz clock, PIO mode 0 was oveclocked too.

> Finally, the taskfile timing (matching PIO mode 0) turned to be overclocked at
> all clock frequencies (and in all manuals)...

> The new timings have been tested on HPT370 chip (at 33 MHz PCI clock) and on
> HPT371N chip (at both 50 and 66 MHz DPLL clock).

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Will post the updated patch later...

MBR, Sergei
