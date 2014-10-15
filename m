From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH] ata: sata_rcar: Add r8a7793 device support
Date: Wed, 15 Oct 2014 18:22:51 +0900
Message-ID: <CAH1o70JV7kkigKtYfGHQpwub9JnuJCQwUAL4s66G-bFKP3ADAg@mail.gmail.com>
References: <1413271894-10056-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdWSQYct5dnFnDBvVFBRCti8g5qJNKaVBBXOW9NZ6FWwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57793 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbaJOJWv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2014 05:22:51 -0400
In-Reply-To: <CAMuHMdWSQYct5dnFnDBvVFBRCti8g5qJNKaVBBXOW9NZ6FWwQw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Geert,

Thank you for your comment.
I updated the documentation and posted patch v2.

Thanks,
Kaneko

2014-10-15 4:32 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san, Matsuoka-san,
>
> On Tue, Oct 14, 2014 at 9:31 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is against for-next branch of Tejun's libata repo.
>>
>>  drivers/ata/sata_rcar.c | 5 +++++
>
> Can you please also update the binding documentation in
> Documentation/devicetree/bindings/ata/sata_rcar.txt?
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
