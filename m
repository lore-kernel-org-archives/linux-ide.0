From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 -rt] ide: workaround buggy hardware issues with
	preemptable hardirqs
Date: Sat, 28 Jun 2008 15:31:26 +0400
Message-ID: <20080628113126.GA438@polina.dev.rtsoft.ru>
References: <20080623234037.GA6793@polina.dev.rtsoft.ru> <20080623235141.GB17297@elte.hu> <20080624000016.GA12547@polina.dev.rtsoft.ru> <20080625123431.GA25452@polina.dev.rtsoft.ru> <20080628005436.GA1956@polina.dev.rtsoft.ru> <486612CC.3060505@ru.mvista.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:9708 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752717AbYF1Lb2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 07:31:28 -0400
Content-Disposition: inline
In-Reply-To: <486612CC.3060505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>

On Sat, Jun 28, 2008 at 02:30:36PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Anton Vorontsov wrote:
>> IDE interrupt handler relies on the fact that, if necessary, hardirqs
>> will re-trigger on ISR exit. The assumption is valid for level sensitive
>> interrupts.
>>   
>
>   It's valid for both edge and level triggered interrupts.

I think this is depends on PIC, whether it can or can not detect masked
edge interrupts...

>> But some hardware (namely ULi M5228 in the ULi M1575 "Super South Brige")
>> behaves in a strange way: it asserts interrupts as edge sensitive. And
>> because preemptable IRQ handler disables PIC's interrupt, PIC will likely
>> miss it.
>>   
>
>   Unmasking an IRQ should re-enable an edge detector in a PIC (or that  
> detector should even be independent from mask).

Should? Hm.. well, I can easily check it. Will just program the MPIC IRQ
to edge sensitive, and see if it fixes the problem (not sure if I already
tried this, I think I did try).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
