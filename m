From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Fwd: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 - "dead" harddisc until reboot
Date: Thu, 10 Jun 2010 18:58:03 -0600
Message-ID: <4C118A1B.3040206@gmail.com>
References: <4C114285.8050201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50729 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab0FKA6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2010 20:58:06 -0400
Received: by iwn37 with SMTP id 37so556233iwn.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Jun 2010 17:58:04 -0700 (PDT)
In-Reply-To: <4C114285.8050201@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MadLoisae@gmx.net
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 06/10/2010 01:52 PM, MadLoisae@gmx.net wrote:
> Hi there,
>
> actually I am using kernel 2.6.34, up to now I was in every (stable)
> release since 2.6.30 affected by this issue.
> Today I have reactivated legacy, regrettably deprecated parallel ATA
> support and have disabled libata. Its a shame, libata is much faster
> (about 20% faster I/O measureable) and more forward-looking, but it is
> not a real alternative if it crashes continuous but not reproduceable on
> via-chipsets (google for this, the web is filled of this issue!). I
> know, via chipsets are not very good, but shouldn't we try to make it
> better (or at least best as possible) with newer drivers instead of worse?
> I hope legacy ATA support won't be removed soon from the kernel sources ...
>
> I like trying out a lot, but if the response is so thin it does not make
> fun just looking at the same issue with the same messages again and
> again not able to do anything beside looking at it and resetting the box
> afterwards ...

Have you tried limiting the speed to UDMA2? If that helps then it could 
be that the motherboard circuitry, etc. isn't suitable for faster speeds.

Random timeouts are unfortunately quite hard to debug since there's so 
many problems that can cause them but the symptoms are the same: could 
be that there was an error on the bus that caused something to stall, an 
interrupt got lost somehow, etc. Or maybe the timing of device access is 
somehow different and thus more likely to trigger whatever the cause is. 
There also seem to be a fair number of bugs in these IDE chipsets that 
the driver has to work around, could be there is one missing in the 
libata version..
