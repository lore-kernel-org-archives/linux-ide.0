From: "Shane McDonald" <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Thu, 4 Dec 2008 08:01:49 -0600
Message-ID: <b2b2f2320812040601k55ab69a6n5da4d321151f94f@mail.gmail.com>
References: <E1L4UpB-0007ro-1g@localhost> <492A8306.9000400@ru.mvista.com>
	 <b2b2f2320812031839q43eb6102jbae0fbddd9a1cf75@mail.gmail.com>
	 <20081204100717.32819f1b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:49667 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbYLDOBw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 09:01:52 -0500
Received: by rn-out-0910.google.com with SMTP id k40so3444883rnd.17
        for <linux-ide@vger.kernel.org>; Thu, 04 Dec 2008 06:01:51 -0800 (PST)
In-Reply-To: <20081204100717.32819f1b@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Would it be acceptable to claim that these changes are outside the
scope of this patch, and code the IT8172 driver to behave in the same
manner as the other wrong drivers, with a suitable comment indicating
this fact?

Shane

On Thu, Dec 4, 2008 at 4:07 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I am not sure how to determine if IORDY sampling is supported by a
>> drive.  If I'm reading the code correctly, other drivers only check
>> that the PIO mode is > 2 (not > 1 as in my driver) -- that seems to be
>> the case for at least piix.c, siimage.c, and it8213.c.
>
> Old IDE is wrong on this and in fact unless it has changed recently
> simply can't cope with and doesn't provide functions for it. A libata
> driver can use the libata helpers but those also rely on the core ata
> code doing certain things so if you cut and paste it over you might have
> to make other old IDE changes in parallel.
>
>
