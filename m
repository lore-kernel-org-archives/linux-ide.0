From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA and failed opcode was: 0x37 ?
Date: Wed, 31 Jan 2007 13:33:22 +0000
Message-ID: <20070131133322.475a2273@localhost.localdomain>
References: <45BF5003.3000503@imc-berlin.de>
	<20070130164401.295f9913@localhost.localdomain>
	<45BF7658.1090204@imc-berlin.de>
	<20070130172629.70ad628d@localhost.localdomain>
	<45BF7E21.7010605@imc-berlin.de>
	<20070130180727.594b35d0@localhost.localdomain>
	<45BF88B9.3050802@imc-berlin.de>
	<45BF8F33.3070008@ru.mvista.com>
	<45C066A8.2090500@imc-berlin.de>
	<45C09089.7070300@ru.mvista.com>
	<45C093CF.3020702@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40551 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933248AbXAaNVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 08:21:34 -0500
In-Reply-To: <45C093CF.3020702@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> I just connected the HDD in question to a PC and the kernel there DID NOT
> detect a HPA! Funny enough the output of cat /proc/ide/hdb/identify is
> different. Shouldn't it be the same!?

No they will be different because the PC hardware works properly. We'll
read both sizes realize they are the same and thus not report an HPA.

This essentially confirms your hardware or driver is bust.

Alan
