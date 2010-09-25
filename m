From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] hpt366: add debounce delay to cable_detect() method
Date: Sat, 25 Sep 2010 20:49:40 +0400
Message-ID: <4C9E2824.50505@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200911202152.22910.sshtylyov@ru.mvista.com> <4B1D17D9.4040906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48054 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0IYQu0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Sep 2010 12:50:26 -0400
Received: by eyb6 with SMTP id 6so988354eyb.19
        for <linux-ide@vger.kernel.org>; Sat, 25 Sep 2010 09:50:24 -0700 (PDT)
In-Reply-To: <4B1D17D9.4040906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, stable@kernel.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk

Hello.

I wrote:

>> Alan Cox reported that cable detection sometimes works unreliably
>> for HPT3xxN and that the issue is fixed by adding debounce delay
>> as used by the vendor drivers.

>> While at it, get rid of unneeded parens/space in the vicinity...

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Cc: stable@kernel.org

>    David, will you (finally) apply this patch?

    Well, nine months has passed, and I have to ask again -- are you going to at 
last apply it? :-/

MBR, Sergei

