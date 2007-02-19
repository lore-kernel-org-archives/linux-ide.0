From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: add/fix enablebits
Date: Tue, 20 Feb 2007 00:09:38 +0100
Message-ID: <200702200009.38168.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702150135.28934.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:56442 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965498AbXBSXDf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 18:03:35 -0500
Received: by mu-out-0910.google.com with SMTP id g7so599959muf
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 15:03:33 -0800 (PST)
In-Reply-To: <200702150135.28934.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Wednesday 14 February 2007 23:35, Sergei Shtylyov wrote:
> The IDE core looks at the wrong bit when checking if the secondary channel is
> enabled on PCI0646 -- CFR bit 8 is read-ahead disable, bit 3 is the correct one.

I guess that you meant CNTRL here?

[ I corrected this in the applied patch ]

> Starting with PCI0646U chip, the primary channel can also be enbled/disabled --
> so, add 'enablebits' initializers to each 'ide_pci_device_t' structure, handling
> the original PCI0646 via adding the init_setup() method and clearing the 'reg'
> field there if necessary...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
