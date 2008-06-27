From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: libata and DMA quirks
Date: Fri, 27 Jun 2008 12:37:29 +0400
Message-ID: <4864A6C9.2050709@ru.mvista.com>
References: <1214548895.8011.526.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20717 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755151AbYF0Ihg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 04:37:36 -0400
In-Reply-To: <1214548895.8011.526.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Hello.

Benjamin Herrenschmidt wrote:
> The main one is that one their latest cell, they do the following
> "workarounds" which I never implemented in drivers/ide/ppc/pmac.c but
> I'd like to implement in the libata driver, unless you believe that i=
s
> unnecessary:
>
> a) =EF=BB=BFFor any ATAPI DMA, If the transfer size is not a multiple=
 of 16
> bytes, switch to PIO for this command.
>  =20

   No need to do this in old driver anyway since the *IDE* core only=20
uses DMA for block commands like READ and WRITE.
Not sure about libata.

WBR, Sergei


