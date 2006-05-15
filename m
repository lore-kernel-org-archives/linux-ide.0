From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Assorted bugs in the PIIX drivers
Date: Mon, 15 May 2006 22:26:39 +0400
Message-ID: <4468C7DF.7090603@ru.mvista.com>
References: <1132929808.3298.18.camel@localhost.localdomain>	 <44689A54.4020307@ru.mvista.com> <1147708783.26686.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:6820 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S965132AbWEOS1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 14:27:49 -0400
In-Reply-To: <1147708783.26686.69.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

> On Llu, 2006-05-15 at 19:12 +0400, Sergei Shtylyov wrote:

>>    For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
>> to have no effect in the lower modes. This is actually not very correct since
>> when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
>> means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

> PIO2 depends on the drive (there is a drive parameter telling you the
> highest timing clock you can do with/without IORDY

    Yes. But when you're setting any _explicit_ PIO mode with Set Features
command, you're tell the drive to use -IORDY at the same time.

>>> I'm also not clear if the "no MWDMA0" list has been updated correctly
>>> for the newer chipsets.

>>    What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
>> greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
>> by Intel.

> Some old old drives only do MWDMA0. The Intel docs I have here don't
> describe it in any way as "unsupported",

    They just don't describe it, period. :-)

> merely broken on some ICH variants.

    ICH errata #55: "Note that DMA Mode-0 is an unsupported mode of the ICH."

> Alan

MBR, Sergei


