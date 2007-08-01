From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
 for CF	interface
Date: Wed, 01 Aug 2007 17:11:49 +0400
Message-ID: <46B08695.6030102@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>	<20070725165326.5331.19920.stgit@localhost.localdomain> <46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com> <a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:23699 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762530AbXHANJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 09:09:50 -0400
In-Reply-To: <a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org

Hello.

Segher Boessenkool wrote:

>>>> +    ide@f0000000 {
>>>> +        compatible = "mmio-ide";
>>>> +        device_type = "ide";

>>>     Why not "ata"?

> The hardware is called (E)IDE, the protocol is called ATA.

    Sorry for not denouncing this earlier. :-)
    ATA is the name of ANSI standard describing IDE.

> Or that's what I was told --

    Re-check your sources. ;-)

 > I think there's some historic revisionism involved, too.

    IDE was probably an initial name of the infamous disk hardware/protocol 
later standardized as ATA, EIDE (being more of a trademark) more or less 
equals to ATA-2.

>>     Also, what mmio-ide in the compat properly means in the context of
>> ide_platform which is able to handle both port and memory mapped IDE. 
>> I think
>> we must get rid with this crap, and since this IDE register mapping is 
>> pretty
>> much board specific, call it something like "mpc8349emitx-ide" instead.

> "mmio-ide" simply is not specific enough.  The device_type

    Yes.

> should go, too.

> If this IDE interface is board-specific, thee "compatible"

    It's "thy", not "thee". ;-)

> property should include the board vendor name and board
> name.  Oh, that's what "emitx" tries to do -- it could be
> a bit clearer perhaps ;-)

    Yeah, I forgot about the vondor's "fsl," prefix.

> Segher

MBR, Sergei
