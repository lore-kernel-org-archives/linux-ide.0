From: Borislav Petkov <bp@alien8.de>
Subject: Re: Machine check exception
Date: Thu, 28 Jul 2011 09:47:19 +0200
Message-ID: <20110728074719.GA16261@liondog.tnic>
References: <4E2FF0EC.2020704@gmail.com>
 <20110727130319.GA26923@gere.osrc.amd.com>
 <4E302F6C.3@gmail.com>
 <20110727170309.GB26923@gere.osrc.amd.com>
 <4E307AF3.40109@gmail.com>
 <4E308360.8080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46102 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab1G1HrX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jul 2011 03:47:23 -0400
Content-Disposition: inline
In-Reply-To: <4E308360.8080302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "F. P. Beekhof" <fpbeekhof@gmail.com>
Cc: Borislav Petkov <bp@amd64.org>, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Wed, Jul 27, 2011 at 11:30:08PM +0200, F. P. Beekhof wrote:
> Note: after a suspend/resume cycle, the register value is back at 8,
> so I have to run the commands again to set it to 100008
> 
> # rdmsr -x 0xc001001f
> 100008
> (suspend / resume)
> # rdmsr -x 0xc001001f
> 8

Yeah, that's ok for now, just to test whether this fixes your issue. You
can add the wrmsr call to some post-resume hooks on your system.

-- 
Regards/Gruss,
    Boris.
