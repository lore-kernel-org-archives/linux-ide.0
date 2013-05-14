From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Tue, 14 May 2013 12:06:16 -0700
Message-ID: <20130514190616.GU6795@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305121213.47294.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:55604 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab3ENTGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 May 2013 15:06:22 -0400
Received: by mail-ye0-f180.google.com with SMTP id r11so169230yen.11
        for <linux-ide@vger.kernel.org>; Tue, 14 May 2013 12:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305121213.47294.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

(cc'ing Sergei)

On Sun, May 12, 2013 at 12:13:46PM +0200, Vincent Pelletier wrote:
> In my understanding, it should indeed go in the "if (cdb)" block, as it should 
> only be needed for ATAPI commands. I don't think lbam/lbah need to be set (or 
> if they do, it's a different issue), because they are set independently from 
> DMADIR in atapi_xlat (so ata_exec_internal_sg would have to set them 
> independently too, probably in the "if (cdb)" block).
> 
> I've modified original patch to the attached one, and tested it: drive is 
> correctly recognised and data can be read from it.
> 
> What would be needed to integrate this patch into the kernel ?
> Also, why does atapi_dmadir default to disabled ? I'm very unfamiliar with 
> ata[pi], if there any drawback from enabling it by default to fix such
> devices ?

Patch looks correct to me but can you please put more detail into the
description preferably with a link to this thread?  As for why
atapi_dmadir isn't enabled by default, my memory is extremely fuzzy
now but ISTR it to be deprecated and cause issues with some devices.

Thanks.

-- 
tejun
