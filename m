From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/4] pata_cmd640: implement sff_irq_check() method
Date: Sat, 09 Oct 2010 16:10:42 +0400
Message-ID: <4CB05BC2.7080404@ru.mvista.com>
References: <201010081856.39644.sshtylyov@ru.mvista.com> <20101008173445.610b9202@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61669 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab0JIMM3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 08:12:29 -0400
Received: by ewy20 with SMTP id 20so30563ewy.19
        for <linux-ide@vger.kernel.org>; Sat, 09 Oct 2010 05:12:27 -0700 (PDT)
In-Reply-To: <20101008173445.610b9202@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

On 08-10-2010 20:34, Alan Cox wrote:

>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>

>> ---
>> The patch is against the recent Linus' tree.

> Why is this needed

    See 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=27943620cbd960f710a385ff4a538e14ed3f1922 
for why this method was introduced.

> and what setups did you test ?

    None. And given the usage of the method (it's called only for unexpected 
interrupts now), it would be quite hard to test.

MBR, Sergei
