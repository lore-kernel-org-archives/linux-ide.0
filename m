From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Tue, 05 Jun 2007 18:14:46 +0400
Message-ID: <46656FD6.6030305@ru.mvista.com>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu> <Pine.LNX.4.62.0706031224030.25438@petra.hos.u-szeged.hu> <4662FC30.2000602@ru.mvista.com> <200706050300.56079.bzolnier@gmail.com> <46655AEA.4020906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:18856 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763495AbXFEONR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 10:13:17 -0400
In-Reply-To: <46655AEA.4020906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Geller Sandor <wildy@petra.hos.u-szeged.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, I wrote:

>> I felt inspired by this explanation (thanks!) and took a look at
>> hpt374-opensource-v2.10 vendor driver.  Here is something interesting:

>> glbdata.c:

>> ...
>> #ifdef CLOCK_66MHZ
>> ULONG setting370_66[] = {
>>         0xd029d5e,  0xd029d26,  0xc829ca6,  0xc829c84,  0xc829c62,
>>         0x2c829d2c, 0x2c829c66, 0x2c829c62,
>>         0x1c829c62, 0x1c9a9c62, 0x1c929c62, 0x1c8e9c62, 0x1c8a9c62,
>>         0x1c8a9c62/*0x1cae9c62*/, 0x1c869c62, 0x1c869c62,
>> };
>> ...

>> hpt366.c:

>> ...
>> static u32 sixty_six_base_hpt37x[] = {
>>         /* XFER_UDMA_6 */       0x1c869c62,
>>         /* XFER_UDMA_5 */       0x1cae9c62,     /* 0x1c8a9c62 */
>> ...

>> So we are using Dual ATA Clock for UDMA5 whereas vendor driver doesn't

>    This is so in all other HPT drivers (and HPT371N datasheet has the 
> same figures -- this chip is the only one supporting UDMA6 and having 
> the default DPLL clock > 50 MHz).

    What I meant to say was the only one I have a datasheet for. :-)

MBR, Sergei

