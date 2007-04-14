From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Sun, 15 Apr 2007 00:16:47 +0400
Message-ID: <462136AF.9060505@ru.mvista.com>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:37633 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1750700AbXDNUPy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2007 16:15:54 -0400
In-Reply-To: <200704142011.l3EKBBhf025590@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Mikael Pettersson wrote:

>>While at it, also perform the following cleanups:

> ...
 
>>- correct the chipset names (from CMDxxx to PCI-xxx)
 
> Please explain why this rename is a correction.

   Because the chips are officially named PCI064[036] and PCI-64[89].

> Did the company making these chips change name at some point?
> Or did they change the names of the chips?

   It's just that Linux named them differently.

> CMD64x is an established name, while PCI-xxx is something
> I've never heard of (and it sounds awfully generic).

   Specs are available from http://gkernel.sourceforge.net/specs/ -- you can see the names on the first pages.

> /Mikael

MBR, Sergei
