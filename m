From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH] ata: Fix build error in sata_highbank
Date: Fri, 28 Sep 2012 12:56:31 -0500
Message-ID: <5065E4CF.9020200@calxeda.com>
References: <1348853017-9205-1-git-send-email-mark.langsdorf@calxeda.com> <5065DEB0.7000702@computer.org> <CA+icZUXTNyhO-Y7kFw7xtf8DEgb-5KZCfPxHb7miRZ4Qyov+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp181.dfw.emailsrvr.com ([67.192.241.181]:54800 "EHLO
	smtp181.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758648Ab2I1R42 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2012 13:56:28 -0400
In-Reply-To: <CA+icZUXTNyhO-Y7kFw7xtf8DEgb-5KZCfPxHb7miRZ4Qyov+Hw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>
Cc: Jan Ceuleers <jan.ceuleers@computer.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, Randy Dunlap <rdunlap@xenotime.net>

On 09/28/2012 12:37 PM, Sedat Dilek wrote:
> On Fri, Sep 28, 2012 at 7:30 PM, Jan Ceuleers <jan.ceuleers@computer.org> wrote:
>> On 09/28/2012 07:23 PM, Mark Langsdorf wrote:
>>> From: Mark Langsdorf <Mark Langsdorf>
>>
>> Mark,
>>
>> This From: line is malformed: the bit between the angle brackets should
>> contain an email address.
>>
> 
> Randy sent a patch to linux-next ML and pinged again on this (see [1]).
> I see no Reported-by... no S-o-b :-(.
> 
> - Sedat -
> 
> [1] http://marc.info/?t=134807860300006&r=1&w=2

I submitted patch immediately after he reported it and was told that
Jeff Garzik would push it up:

http://patchwork.kernel.org/patch/1460971

I'm really not sure why this isn't in linux-next already.

--Mark Langsdorf
Calxeda, Inc.
