From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [v3 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Fri, 24 Dec 2010 13:38:34 -0500
Message-ID: <4D14E8AA.5020304@pobox.com>
References: <1293197948-12896-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41605 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0LXSih (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:38:37 -0500
Received: by qwa26 with SMTP id 26so7308182qwa.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 10:38:37 -0800 (PST)
In-Reply-To: <1293197948-12896-1-git-send-email-wuzhangjin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

On 12/24/2010 08:39 AM, Wu Zhangjin wrote:
> Changes from v1:
>
>    o The driver version is incremented to 0.0.8 as feedback from "Sergei
>    Shtylyov"<sshtylyov@mvista.com>.
>
> ---
>
> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
> variant), so, remove the dependency of X86_32 and fix the building
> errors under the other platforms via only reserving the X86_32 specific
> parts for X86_32.
>
> pata_amd also supports cs5536 IDE controller, but this one saves about
> 33k for the compressed kernel image(vmlinuz for MIPS).
>
> Signed-off-by: Zhang Le<r0bertz@gentoo.org>
> Signed-off-by: Chen Jie<chenj@lemote.com>
> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   drivers/ata/Kconfig       |    2 +-
>   drivers/ata/pata_cs5536.c |   18 ++++++++++++------
>   2 files changed, 13 insertions(+), 7 deletions(-)

applied, after hand-fixing the comment message (as Sergei noted, 
automated tools script everything after "---" from the commit message)


