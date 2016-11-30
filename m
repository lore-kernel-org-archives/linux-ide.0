From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 10:03:47 -0500
Message-ID: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com> <20161130145322.252f7403@lxorguk.ukuu.org.uk>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34552 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964858AbcK3PEI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 10:04:08 -0500
Received: by mail-yw0-f194.google.com with SMTP id a10so14700701ywa.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 07:04:08 -0800 (PST)
In-Reply-To: <20161130145322.252f7403@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

On Wed, Nov 30, 2016 at 9:53 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 30 Nov 2016 16:11:39 +0300
> Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
>
>> Hello.
>>
>> On 11/29/2016 08:53 PM, Matthew Whitehead wrote:
>>
>> > If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
>> > common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
>> > and also their associated interrupts (14,15,11,10,8,12).
>> >
>> > Unfortunately, on such systems those interrupt lines are at a premium because there is no
>> > PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
>> > a list of ports to skip allocating.
>
> In what situation do you actually hit this. The probes should fail so the
> interrupt shouldn't end up allocated.
>

Alan,
  on my hardware it grabbed all those interrupts, showing up in
/proc/interrupts very clearly.

- Matthew
