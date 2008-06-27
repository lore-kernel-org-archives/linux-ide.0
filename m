From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 13:10:42 +0400
Message-ID: <4864AE92.2090805@ru.mvista.com>
References: <1214548895.8011.526.camel@pasglop>	 <4864A6C9.2050709@ru.mvista.com> <1214556703.8011.531.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:21528 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750942AbYF0JKt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 05:10:49 -0400
In-Reply-To: <1214556703.8011.531.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Hello.

Benjamin Herrenschmidt wrote:
>>> The main one is that one their latest cell, they do the following
>>> "workarounds" which I never implemented in drivers/ide/ppc/pmac.c b=
ut
>>> I'd like to implement in the libata driver, unless you believe that=
 is
>>> unnecessary:
>>>
>>> a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multip=
le of 16
>>> bytes, switch to PIO for this command.
>>>  =20
>>>      =20
>>    No need to do this in old driver anyway since the *IDE* core only=
=20
>> uses DMA for block commands like READ and WRITE.
>> Not sure about libata.
>>    =20
>
> It doesn't use DMA to transfer the bulk of ATAPI ? I know it uses PIO
> for the CDB but the rest of the transfer isn't done with DMA ?
>  =20
   Like I said, DMA is used only for the *block* transfer commands for=20
which the transfer size would always be a multiple of 16 bytes.

MBR, Sergei


