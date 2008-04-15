From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Pb1200/DBAu1200: fix bad IDE resource size
Date: Tue, 15 Apr 2008 23:09:11 +0200
Message-ID: <200804152309.11471.bzolnier@gmail.com>
References: <200804152044.32912.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:59155 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbYDOVT7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:59 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2407243fkr.5
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:56 -0700 (PDT)
In-Reply-To: <200804152044.32912.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Tuesday 15 April 2008, Sergei Shtylyov wrote:
> The header files for the Pb1200/DBAu1200 boards have wrong definition for the
> IDE interface's  decoded range length -- it should be 512 bytes according to
> what the IDE driver does.  In addition, the IDE platform device claims 1 byte
> too many for its memory resource -- fix the platform code and the IDE driver
> in accordance.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

Well, since I've been already merging the other au1xxx-ide patches
to IDE tree I've also applied this one while at it...

>  arch/mips/au1000/common/platform.c    |    2 +-
>  drivers/ide/mips/au1xxx-ide.c         |    7 ++++---
>  include/asm-mips/mach-db1x00/db1200.h |    4 ++--
>  include/asm-mips/mach-pb1x00/pb1200.h |    4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
