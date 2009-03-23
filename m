From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE cable detection on Apple PowerBook
Date: Mon, 23 Mar 2009 21:09:24 +0100
Message-ID: <200903232109.24971.bzolnier@gmail.com>
References: <20090322101704.80473ee8.posco.grubb@gmail.com> <49C76AFF.5090008@ru.mvista.com> <20090323201121.ab925b5a.posco.grubb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44348 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbZCWUJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Mar 2009 16:09:45 -0400
Received: by fxm2 with SMTP id 2so1970473fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2009 13:09:42 -0700 (PDT)
In-Reply-To: <20090323201121.ab925b5a.posco.grubb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TOMARI Hisanobu <posco.grubb@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, benh@kernel.crashing.org

On Monday 23 March 2009, TOMARI Hisanobu wrote:
> On Mon, 23 Mar 2009 13:57:03 +0300
> Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> >     Unacceptable style, brace should be on the same line with *if*; run your 
> > patch thru scripts/checkpatch.pl please...
> Thank you for telling me the error. Now, this one should be all right.
> 
> ---
> 
> Signed-off-by: TOMARI Hisanobu <posco.grubb@gmail.com>
> This patch against 2.6.28.8 modifies the behavior of 80c cable detection 
> of drivers/ide/pmac.c.
> As IDE cable used on Apple PowerBook/iBook laptops are always of "Short 40" 
> type when the firmware says it's 80 conductor one, the cable detection should 
> return ATA_CBL_PATA40_SHORT on those machines.
> This enables to automatically use UDMA5 even with drives that doesn't correctly 
> detect those cables on Apple laptops.

applied

PS please keep the following ordering in future:

- patch description
- S-o-B line
- "---" line

to allow easier/automatic merging of patches
