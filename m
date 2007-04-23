From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Mon, 23 Apr 2007 23:58:46 +0200
Message-ID: <200704232358.46095.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702152217.08984.sshtylyov@ru.mvista.com> <200704142341.16071.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32073 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbXDWWaT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 18:30:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so51007uga
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 15:30:19 -0700 (PDT)
In-Reply-To: <200704142341.16071.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 14 April 2007, Sergei Shtylyov wrote:
> Fix several issues with the driver's procfs output:
> 
> - when testing if channel is enabled, the code looks at the "simplex" bits, not
>   at the real enable bits -- add #define for the primary channel enable bit;
> 
> - UltraDMA modes 0, 1, 3 for slave drive reported incorrectly due to using the
>   master drive's clock cycle resolution bit.
> 
> While at it, also perform the following cleanups:
> 
> - don't print extra newline before the first controller's dump;
> 
> - correct the chipset names (from CMDxxx to PCI-xxx)
> 
> - don't read from the registers which aren't used for dump;
> 
> - better align the table column sizes;
> 
> - rework UltraDMA mode dump code;
> 
> - remove PIO mode dump code that has never been finished;
> 
> - remove the duplicate interrupt status (the MRDMODE register bits mirror those
>   those in the CFR and ARTTIM23 registers) and fold the dump into single line;
> 
> - correct the style of the ?: operators...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This version fixes an issue with the channel enable misreporting in the older
> patch, adds workaround for missing primary channel enable bit on PCI0643/6, and
> also beuatifies the overall table format.  Has been tested on PCI-649 as well.

applied
