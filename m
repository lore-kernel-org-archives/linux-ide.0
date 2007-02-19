From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: procfs code fixes/cleanups
Date: Tue, 20 Feb 2007 00:10:31 +0100
Message-ID: <200702200010.31793.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702152217.08984.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:41544 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513AbXBSXE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 18:04:28 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2556666nfa
        for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2007 15:04:27 -0800 (PST)
In-Reply-To: <200702152217.08984.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Thursday 15 February 2007 20:17, Sergei Shtylyov wrote:
> Fix several issues with the driver's procfs output:
> 
> - when testing if channel is enabled, the code looks at the "simplex" bits, not
>   at the real enable bits -- add #define for the primary channel enable bit;
> 
> - UltraDMA modes 0, 1, 3 for slave drive reported incorrectly due to using the
>   master drive's clock cycle resolution bit.
> 
> While at it, also perform some cleanups:
> 
> - don't read from the registers which are not used for dump;
> 
> - correct the chipset names (from CMDxxx to PCI-xxx);
> 
> - rework UltraDMA mode dump code;
> 
> - remove PIO mode dump code that has never been finished;
> 
> - remove the duplicate interrupt status dump (the MRDMODE register bits mirror
>   those in the CFR and ARTTIM23 registers);
> 
> - add spaces in the ?: operators...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
