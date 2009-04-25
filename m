From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Sat, 25 Apr 2009 16:48:38 +0200
Message-ID: <200904251648.38389.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39302 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbZDYOoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2009 10:44:24 -0400
Received: by fxm2 with SMTP id 2so1549301fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 25 Apr 2009 07:44:22 -0700 (PDT)
In-Reply-To: <20090425170203.74603b9c@power-debian>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Gusev <a.gusev1980@mail.ru>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com


Hi,

On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> Hello!
> 
> I have tested linux-2.6.30-rc3 on my system and find some problems. One
> of them is delaying on initialization IDE subsystem. I don't have this
> problem on 2.6.29.1. The difference is looked on log of dmesg.

Unfortunately this doesn't give us any hint about the root cause of
the bug so please try narrowing the problem down to the specific change
using git-bisect (sorry, there were 212 drivers/ide/ commits during
v2.6.29..v2.6.30-rc3 and much much more non-drivers/ide/ ones).

Thanks,
Bart
