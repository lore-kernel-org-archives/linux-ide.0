From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] cmd64x: add/fix enablebits (take 2)
Date: Mon, 23 Apr 2007 23:54:24 +0200
Message-ID: <200704232354.24720.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702150135.28934.sshtylyov@ru.mvista.com> <200704142331.51648.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396AbXDWWaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so51003uga
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:18 -0700 (PDT)
In-Reply-To: <200704142331.51648.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 April 2007, Sergei Shtylyov wrote:
> The IDE core looks at the wrong bit when checking if the secondary channel is
> enabled on PCI0646 -- CNTRL register bit 7 is read-ahead disable, bit 3 is the
> correct one.
> Starting with PCI0646U chip, the primary channel can also be enabled/disabled --
> so, add 'enablebits' initializers to each 'ide_pci_device_t' structure, handling
> the original PCI0646 via adding the init_setup() method and clearing the 'reg'
> field there if necessary...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> ---
> This is an update due to patch order changes.  Has also been tested on PCI-649.

applied
