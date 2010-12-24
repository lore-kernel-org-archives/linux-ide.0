From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [v3 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Fri, 24 Dec 2010 18:31:07 +0300
Message-ID: <4D14BCBB.7060006@ru.mvista.com>
References: <1293197948-12896-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41087 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0LXPc1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 10:32:27 -0500
Received: by eye27 with SMTP id 27so3311989eye.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 07:32:25 -0800 (PST)
In-Reply-To: <1293197948-12896-1-git-send-email-wuzhangjin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

Hello.

Wu Zhangjin wrote:

> Changes from v1:

>   o The driver version is incremented to 0.0.8 as feedback from "Sergei
>   Shtylyov" <sshtylyov@mvista.com>.

    Note that this way the maintainer will have to hand edit your patch because 
git will automatically drop your description and signoff (they're below ---).
Such comments better follow the --- tearline as I said as they'll be 
automatically dropped by git in that case.

> ---

> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
> variant), so, remove the dependency of X86_32 and fix the building
> errors under the other platforms via only reserving the X86_32 specific
> parts for X86_32.

> pata_amd also supports cs5536 IDE controller, but this one saves about
> 33k for the compressed kernel image(vmlinuz for MIPS).

> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> Signed-off-by: Chen Jie <chenj@lemote.com>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

WBR, Sergei
