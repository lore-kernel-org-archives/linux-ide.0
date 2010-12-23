From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [v2 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Thu, 23 Dec 2010 20:44:19 +0300
Message-ID: <4D138A73.90504@ru.mvista.com>
References: <21c0c6ed72c9fb53f47562705de1c2dfc3f3b2ee.1293121910.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37133 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0LWRpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Dec 2010 12:45:39 -0500
Received: by ewy5 with SMTP id 5so3180900ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2010 09:45:38 -0800 (PST)
In-Reply-To: <21c0c6ed72c9fb53f47562705de1c2dfc3f3b2ee.1293121910.git.wuzhangjin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

Hello.

Wu Zhangjin wrote:

> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
> variant), so, remove the dependency of X86_32 and fix the building
> errors under the other platforms via only reserving the X86_32 specific
> parts for X86_32.

> pata_amd also supports cs5536 IDE controller, but this one saves about
> 33k for the compressed kernel image(vmlinuz for MIPS).

> The driver version is incremented to 0.08 as feedback from "Sergei Shtylyov"
> <sshtylyov@mvista.com>.

    This remark should really have been put under --- tear line...

> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> Signed-off-by: Chen Jie <chenj@lemote.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

WBR, Sergei
