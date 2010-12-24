From: wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: [v2 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Fri, 24 Dec 2010 21:30:50 +0800
Message-ID: <AANLkTim+s438quTkFKzv7ndX-1gCSf7AOrjoG-p-HOB7@mail.gmail.com>
References: <21c0c6ed72c9fb53f47562705de1c2dfc3f3b2ee.1293121910.git.wuzhangjin@gmail.com>
	<4D138A73.90504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42478 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0LXNav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 08:30:51 -0500
Received: by wyb28 with SMTP id 28so6965648wyb.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 05:30:50 -0800 (PST)
In-Reply-To: <4D138A73.90504@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

On Fri, Dec 24, 2010 at 1:44 AM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> Wu Zhangjin wrote:
>
>> pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
>> variant), so, remove the dependency of X86_32 and fix the building
>> errors under the other platforms via only reserving the X86_32 speci=
fic
>> parts for X86_32.
>
>> pata_amd also supports cs5536 IDE controller, but this one saves abo=
ut
>> 33k for the compressed kernel image(vmlinuz for MIPS).
>
>> The driver version is incremented to 0.08 as feedback from "Sergei
>> Shtylyov"
>> <sshtylyov@mvista.com>.
>
> =A0 This remark should really have been put under --- tear line...

Or I can simply add this line as the 1st line instead:

Changes from v1:

      o The driver version is incremented to 0.08 as feedback from "Ser=
gei
      Shtylyov" <sshtylyov@mvista.com>.

But this is really a trivial stuff ... anyway, v3 will be sent out late=
r ;-)

Regards,
Wu Zhangjin

>
>> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
>> Signed-off-by: Chen Jie <chenj@lemote.com>
>> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>
> WBR, Sergei
>
