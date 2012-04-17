From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Tue, 17 Apr 2012 13:51:09 -0700
Message-ID: <CAOS58YNazcm3XZpujB5Y4d_c9Xh1-yn24cbinAbdbpFo5npXQw@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55031 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2DQUvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 16:51:10 -0400
Received: by vcqp1 with SMTP id p1so4435729vcq.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 13:51:09 -0700 (PDT)
In-Reply-To: <4F8DD708.8050502@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On Tue, Apr 17, 2012 at 1:48 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 12-04-17 04:38 PM, Mark Lord wrote:
>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>> I don't know when it stopped working, but it's a blooming pain in th=
e sysadmin.
>>
>> I need to hotplug a SATA drive into an AHCI port,
>> preferably without having to reboot first.
>>
>> Is there a patch available already for this regression?
>
> Answering my own question, this patch appears to address the issue.
> I'll test and report back again shortly:
>
> =A0 =A0http://patchwork.ozlabs.org/patch/146326/
>
> Odd that it's been sitting in various people's inboxes since 3.3-rc1
> and hasn't been pushed out yet.

This really is a userland policy problem and
unconditionally/automatically disabling PM on hotplug ports is just
trading one PITA for another.

Thanks.

--=20
tejun
