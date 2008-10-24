From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Fri, 24 Oct 2008 15:12:15 +0400
Message-ID: <4901AD8F.4000007@ru.mvista.com>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp> <200810232247.05686.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36345 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751752AbYJXLMZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 07:12:25 -0400
In-Reply-To: <200810232247.05686.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
>> It has custom set_pio_mode and some hacks for big endian.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>     
>
> I applied it so please address issues left (if any) with incremental patches.
>   

   I'm not sure there was really a need to haste it into -rc1 (if you 
could push it to Linus later anyway)...
   I've realized that I have a question to Atsushi on why he chose the 
same way of implemnting the register accesses as on TX4939 despite 
TX4938 IDE is not really a SoC but a board level device (so probable 
should be using the normal, not the "raw" I/O accessors)...

MBR, Sergei


