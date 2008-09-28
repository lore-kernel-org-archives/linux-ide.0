From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE	driver
Date: Sun, 28 Sep 2008 16:51:08 +0400
Message-ID: <48DF7DBC.1080804@ru.mvista.com>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <20080928114711.GB9207@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:12712 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752014AbYI1MuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 08:50:13 -0400
In-Reply-To: <20080928114711.GB9207@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

Hello.

Ralf Baechle wrote:

>>>+{

>>[...]

>>>+	pdev = platform_device_register_simple(DEV_NAME, -1,
>>>+		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));

>>  If you have the resources as static array anyway, why not have the  
>>device in the static variable too and use platform_device_register()?

> It saves a few lines of code.

    And wastes few words of static data since 
platform_device_register_simple() will kmalloc() the resources and do a copy 
from these resources after which they are not needed -- so, it's worth making 
swarm_ide_resource[] __initdata at least.
    If you were using platform_device_register() with static platform device, 
no memory allocation would have happened, and no data would have been wasted.

WBR, Sergei
