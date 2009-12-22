From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.32.2 SATA link detect failed, 2.6.32.1 works fine
Date: Mon, 21 Dec 2009 19:08:56 -0600
Message-ID: <51f3faa70912211708j200ab584wa835ffe50981415e@mail.gmail.com>
References: <alpine.LNX.2.00.0912211855460.1689@darkstar.example.net>
	 <4B30134C.1050609@gmail.com>
	 <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752872AbZLVBJM@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.0912220859060.1686@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
To: fengxiangjun <fengxiangjun@neusoft.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 21, 2009 at 7:02 PM, fengxiangjun <fengxiangjun@neusoft.com=
> wrote:
>
> Yeah, running 2.6.32.1 now, no problem.
>
> dmesg shows:
>
> ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>
> When booting 2.6.32.2 with the same config, I get
>
> ata1.00: SATA link down (SStatus 0 SControl 301)
>
> Weird.

CCing linux-ide and Tejun. Could be some kind of timing difference
triggering the problem, perhaps?

>
> On Mon, 21 Dec 2009, Robert Hancock wrote:
>
>> On 12/21/2009 05:12 AM, fengxiangjun wrote:
>> >
>> > Hi,
>> >
>> > after upgrading to 2.6.32.2,
>> > with the attached config,
>> > kernel booting always(just tried 10+ times) failed at:
>> >
>> > ata1.00: SATA link down (SStatus 0 SControl 301)
>> > ...
>> > VFS: Cannot open root device ...
>>
>> There were no libata changes in 2.6.32.2 that should have affected t=
his. Are
>> you sure the .config is unchanged? Have you rechecked that 2.6.31.1 =
still
>> works?
>>
> ---------------------------------------------------------------------=
------------------------------
> Confidentiality Notice: The information contained in this e-mail and =
any accompanying attachment(s)
> is intended only for the use of the intended recipient and may be con=
fidential and/or privileged of
> Neusoft Corporation, its subsidiaries and/or its affiliates. If any r=
eader of this communication is
> not the intended recipient, unauthorized use, forwarding, printing, =A0=
storing, disclosure or copying
> is strictly prohibited, and may be unlawful.If you have received this=
 communication in error,please
> immediately notify the sender by return e-mail, and delete the origin=
al message and all copies from
> your system. Thank you.
> ---------------------------------------------------------------------=
------------------------------
>
>
