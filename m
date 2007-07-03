From: Mark Lord <liml@rtr.ca>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Tue, 03 Jul 2007 18:45:42 -0400
Message-ID: <468AD196.5050206@rtr.ca>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>	 <4683F340.2020905@rtr.ca>	 <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com>	 <46851F65.5070400@rtr.ca> <46852BAE.6070505@rtr.ca> <cd98e0260707020726s1b3ef8bx8ea766e24bc4d549@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4294 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbXGCWpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 18:45:44 -0400
In-Reply-To: <cd98e0260707020726s1b3ef8bx8ea766e24bc4d549@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johny Mail list <maillist.johny@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Johny Mail list wrote:
>
> This patch don't work in my case.

Please elaborate on "don't work".
Especially with a 2.6.18.8 kernel.

> Sorry but i don't understand when you say : "you may need to patch the
> patch to contain the correct PCI IDs (from lspci -n)."
> Where is the correct line in the patch to set the correct value.
> My lspci -n line for the sata is "00:1f.2 0101: 8086:24d1 (rev 02)".

No need to patch it then, as the patch already has 8086:24d1.

Cheers
