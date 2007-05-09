From: Dominik Schulz <lkml@ds.gauner.org>
Subject: Re: Possible Bug in sata_via when trying to burn
Date: Wed, 09 May 2007 16:30:56 +0200
Message-ID: <4641DB20.6030606@ds.gauner.org>
References: <46419A8B.2060605@ds.gauner.org> <4641D1AE.3070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gauner.org ([85.10.240.115]:56051 "EHLO mail.gauner.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920AbXEIOa6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 10:30:58 -0400
In-Reply-To: <4641D1AE.3070602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

as far as I can see the kernel doesn't complain about anything. Nothing
in the syslog or anywhere else.

One thing I forgot to mention: It's no permission problem. I get exactly
the same output as root.

I've put the output of
wodim -VV blank=all -dev=2,0,0
at [1].

Tejun Heo wrote:
> Hello, Dominik.
>
> Dominik Schulz wrote:
>   
>> The Problem seems to affect cd writers attached to this chip, sata as
>> well as pata [2].
>>
>> Some details of my system:
>> Debian etch, running the 2.6.21 Kernel.
>> The CD-Writer is a NEC ND-3500AG attachted to the PATA Port of the VIA
>> 6421 Chip on an Abit AX8 V2.0 Motherboard.
>> lspci -vvv is at [3]
>> dmesg at [4]
>> the wodim output when trying to blank a cd [5]
>> kernel .config at [6]
>>     
>
> I need more info to tell what's going on.
>
> 1. Does the kernel complain about anything during wodim runs?
> 2. Please run wodim with -VV and report what it says.
>
> Thanks.
>
>   
[1] - http://blog.gauner.org/dl/wodimvv.txt
