From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 14:26:06 +0100
Message-ID: <45C098EE.60101@imc-berlin.de>
References: <45BF5003.3000503@imc-berlin.de>	<20070130164401.295f9913@localhost.localdomain>	<45BF7658.1090204@imc-berlin.de>	<20070130172629.70ad628d@localhost.localdomain>	<45BF7E21.7010605@imc-berlin.de>	<20070130180727.594b35d0@localhost.localdomain>	<45BF88B9.3050802@imc-berlin.de>	<45BF8F33.3070008@ru.mvista.com>	<45C066A8.2090500@imc-berlin.de>	<45C09089.7070300@ru.mvista.com>	<45C093CF.3020702@imc-berlin.de> <20070131133322.475a2273@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:2778 "EHLO
	mail.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933252AbXAaN0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 08:26:09 -0500
In-Reply-To: <20070131133322.475a2273@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Alan wrote:
>> I just connected the HDD in question to a PC and the kernel there DID NOT
>> detect a HPA! Funny enough the output of cat /proc/ide/hdb/identify is
>> different. Shouldn't it be the same!?
>
> No they will be different because the PC hardware works properly. We'll
> read both sizes realize they are the same and thus not report an HPA.

Ah. I see.

> This essentially confirms your hardware or driver is bust.
Ok. So the mean problem is that reading the HOB registers does not work ...
Hmmm.

--
Steven

