From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3 v4] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Thu, 5 Mar 2009 14:48:10 +0100
Message-ID: <200903051448.11075.bzolnier@gmail.com>
References: <200902181107.27095.stf_xl@wp.pl> <200903021733.36315.bzolnier@gmail.com> <cd73a99e0903021154r6affe054u6117d9ee283b1def@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:56811 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbZCEOtw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Mar 2009 09:49:52 -0500
Received: by bwz26 with SMTP id 26so3289838bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2009 06:49:49 -0800 (PST)
In-Reply-To: <cd73a99e0903021154r6affe054u6117d9ee283b1def@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Monday 02 March 2009, Andrew Victor wrote:
> hi Bartlomiej
> 
> > Andrew, are you fine with me merging this patch together with IDE ones?
> 
> Patch is good.
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>

Cool, I applied patches 1-3.

[ Stanislaw, I also updated pata-2.6 tree to accomodate for the new
  driver, it would be great if you could try it (or "next" linux-next)
  so we know that at91_ide still works... ]
