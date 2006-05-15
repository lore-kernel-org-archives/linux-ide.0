From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Assorted bugs in the PIIX drivers
Date: Mon, 15 May 2006 19:12:20 +0400
Message-ID: <44689A54.4020307@ru.mvista.com>
References: <1132929808.3298.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:5076 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964969AbWEOPNV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 11:13:21 -0400
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)
>
> I then started reading the docs and the code and noticing a couple of
> problems

> 1.	We set IE1 on PIO0-2 which the docs say is for PIO3+

    For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
to have no effect in the lower modes. This is actually not very correct since
when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

> I'm also not clear if the "no MWDMA0" list has been updated correctly
> for the newer chipsets.

    What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
by Intel.

MBR, Sergei


