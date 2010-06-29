From: Simon Li <simon.jiyou@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Tue, 29 Jun 2010 15:27:02 +0800
Message-ID: <AANLkTilZI5vRPecvWZe3SG4V_NwLVsMGm4QA-4pnNm7x@mail.gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com>
	<4C2777D3.1050208@gmail.com>
	<AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
	<4C28653E.4080908@garzik.org>
	<AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com>
	<4C298077.6070102@gmail.com>
	<AANLkTimnoyjEVTmorcPD_Ph9TDjNo33jz7qcwEE0z6-2@mail.gmail.com>
	<4C299EB0.6070102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40904 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0F2H1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 03:27:03 -0400
Received: by pxi8 with SMTP id 8so2169675pxi.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 00:27:02 -0700 (PDT)
In-Reply-To: <4C299EB0.6070102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

"stuck" here I mean, the kernel stuck inside kernel, so applications
got stuck as well...


On Tue, Jun 29, 2010 at 3:20 PM, Tejun Heo <htejun@gmail.com> wrote:
> Hello, Simon.
>
> On 06/29/2010 09:10 AM, Simon Li wrote:
>> We observed that all the processes on the blade are totally stuck,
>> though only one process is actually accessing the disks, other
>> processes are mostly CPU-consuming applications.
>
> Can you please turn on printk timestamp and attach the dmesg output
> _after_ such failure? =A0I think there are two possibilities. =A0The
> kernel could be generating too many messages to slow serial console,
> or the it might as well be that all processes got stuck on IO. =A0It'=
s
> really difficult to figure out what's going on without more specific
> information. =A0What does "stuck" mean? =A0Does it mean all of them a=
re in
> iowait or is the kernel just stuck inside kernel?
>
> Thanks.
>
> --
> tejun
>
