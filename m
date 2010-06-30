From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Tue, 29 Jun 2010 18:38:46 -0600
Message-ID: <AANLkTin-5rTHb1vlN2Wqesw2BNjgslGy5VNgUa6N9nmN@mail.gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com>
	<4C2777D3.1050208@gmail.com>
	<AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
	<4C28653E.4080908@garzik.org>
	<AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
	<4C298077.6070102@gmail.com>
	<AANLkTimnoyjEVTmorcPD_Ph9TDjNo33jz7qcwEE0z6-2@mail.gmail.com>
	<4C299EB0.6070102@gmail.com>
	<AANLkTilZI5vRPecvWZe3SG4V_NwLVsMGm4QA-4pnNm7x@mail.gmail.com>
	<4C29A0CF.80902@gmail.com>
	<AANLkTinYbtr1qBLibK7wYizCDq8V0HwFu01NUr-f_KfR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63901 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0F3Air convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 20:38:47 -0400
Received: by iwn7 with SMTP id 7so256366iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 17:38:47 -0700 (PDT)
In-Reply-To: <AANLkTinYbtr1qBLibK7wYizCDq8V0HwFu01NUr-f_KfR@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Li <simon.jiyou@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Tue, Jun 29, 2010 at 4:13 AM, Simon Li <simon.jiyou@gmail.com> wrote=
:
> We have one process(Streaming server) R/W disks, and another process
> is a pure monitoring process of the streaming server, periodicially
> collecting aliveness info from the streaming process. At the time of
> _"I called kernel temporary hung"_, the streaming process "looks"
> entering into stuck as no more logs prints(usually, there are dozens
> of logs prints in each second), this also exactly happened to the
> monitoring process, and the sys log as well. At the time of _"kernel
> hung resumed"_, the two process suddenly came back to run(Ye, observe=
d
> from log printings) and running as usual.
>
> A full syslog attached, you can do _grep_ "[RSS-RAW] Failed to read",
> the results indicate "kernel hung" frequently occurred during those
> read() syscalls.

If the process or syslog is writing its logs to disk, then eventually
after the kernel decides that too much data has been queued up to be
written to disk, those processes trying to write will block until some
of the data can be written out. If all disk I/O is stalled, then a lot
of things can more or less grind to a halt. The kernel is not hung,
but userspace may be effectively hung.

>
>
> On Tue, Jun 29, 2010 at 3:29 PM, Tejun Heo <htejun@gmail.com> wrote:
>> On 06/29/2010 09:27 AM, Simon Li wrote:
>>> "stuck" here I mean, the kernel stuck inside kernel, so application=
s
>>> got stuck as well...
>>
>> How did you determine that? =A0Come on. =A0Give us some data.
>>
>> --
>> tejun
>>
>
