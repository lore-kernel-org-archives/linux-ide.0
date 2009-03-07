From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: identify data word 53 bit 1 doesn't cover words 62 and 63 (take 2)
Date: Sat, 7 Mar 2009 17:05:48 +0100
Message-ID: <200903071705.49749.bzolnier@gmail.com>
References: <200903031404.45443.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:53851 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbZCGQYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Mar 2009 11:24:18 -0500
Received: by fxm24 with SMTP id 24so732895fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 07 Mar 2009 08:24:16 -0800 (PST)
In-Reply-To: <200903031404.45443.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 03 March 2009, Sergei Shtylyov wrote:
> The IDE code assumed for years that the bit 1 of the identify data word 53 also
> covers the validity of the SW/MW DMA information in words 62 and 63, but it has
> always covered only words 64 thru 70, with words 62 and 63 being defined in the
> original ATA spec, not in ATA-2...
> 
> This fix however should only concern *very* old hard disks and rather old CF
> cards...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
