From: wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: [v3 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Sat, 25 Dec 2010 11:33:31 +0800
Message-ID: <AANLkTi=7RBNF_XCkAhAkCSFfKnuUcHG_aWWf4dRBUMiQ@mail.gmail.com>
References: <1293197948-12896-1-git-send-email-wuzhangjin@gmail.com>
	<4D14E8AA.5020304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63276 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0LYDdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 22:33:32 -0500
Received: by wyb28 with SMTP id 28so7318797wyb.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 19:33:31 -0800 (PST)
In-Reply-To: <4D14E8AA.5020304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

On Sat, Dec 25, 2010 at 2:38 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 12/24/2010 08:39 AM, Wu Zhangjin wrote:
>>
>> Changes from v1:
>>
>> =A0 o The driver version is incremented to 0.0.8 as feedback from "S=
ergei
>> =A0 Shtylyov"<sshtylyov@mvista.com>.
>>
>> ---
>>
>> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
>> variant), so, remove the dependency of X86_32 and fix the building
>> errors under the other platforms via only reserving the X86_32 speci=
fic
>> parts for X86_32.
>>
>> pata_amd also supports cs5536 IDE controller, but this one saves abo=
ut
>> 33k for the compressed kernel image(vmlinuz for MIPS).
>>
>> Signed-off-by: Zhang Le<r0bertz@gentoo.org>
>> Signed-off-by: Chen Jie<chenj@lemote.com>
>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>> ---
>> =A0drivers/ata/Kconfig =A0 =A0 =A0 | =A0 =A02 +-
>> =A0drivers/ata/pata_cs5536.c | =A0 18 ++++++++++++------
>> =A02 files changed, 13 insertions(+), 7 deletions(-)
>
> applied, after hand-fixing the comment message (as Sergei noted, auto=
mated
> tools script everything after "---" from the commit message)
>

Thanks Jeff and Sergei.

Regards,
Wu Zhangjin
