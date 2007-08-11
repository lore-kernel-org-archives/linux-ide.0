From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Sat, 11 Aug 2007 19:10:15 +0200
Message-ID: <200708111910.15921.bzolnier@gmail.com>
References: <200708042206.57529.bzolnier@gmail.com> <200708102358.25715.bzolnier@gmail.com> <46BDEB54.6060609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:28193 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXHKRLA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 13:11:00 -0400
Received: by fk-out-0910.google.com with SMTP id z23so989454fkz
        for <linux-ide@vger.kernel.org>; Sat, 11 Aug 2007 10:10:58 -0700 (PDT)
In-Reply-To: <46BDEB54.6060609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 11 August 2007, you wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>   Good, that's what I lacked for hpt366.c!  Were you planning to push it to 
> >>>>Linus soon?
> 
> >>>Not really but if needed I will extract MWDMA filter part and push it sooner.
> 
> >>    Erm, may I just merge it to my patch (mentioning you of course)?
> 
> > Sure.
> 
>    I guess you want to keep the method's name? :-)

Not really, it may be ->mwdma_filter (to keep consistency with ->mwmda_mask).

Bart
