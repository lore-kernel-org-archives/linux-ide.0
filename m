From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Wed, 11 May 2016 16:55:47 +0200
Message-ID: <573347F3.2080104@free.fr>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com> <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
 <20160510060440.GF2274@localhost> <20160510163022.GL7110@mtj.duckdns.org>
 <5732EA75.4070002@free.fr> <5732FE8E.9000605@free.fr>
 <yw1xlh3ghn8n.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:29998 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090AbcEKO4H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 May 2016 10:56:07 -0400
In-Reply-To: <yw1xlh3ghn8n.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Frias <sf84@laposte.net>, linux-ide@vger.kernel.org

On 11/05/2016 13:01, M=E5ns Rullg=E5rd wrote:

> Mason wrote:
>=20
>> Mans, did you intend to upstream your tangox-dma.c DMA driver?
>=20
> Yes, that's the idea, though I haven't yet updated it to work with
> tango4.  This SATA driver also needs a small addition to handle the D=
MA
> glue.  Now that the dust has settled a bit around these fixes, I can =
get
> back to that.

I may have an obsolete version of the driver, but I saw that you
would sometimes call wmb() after writel().

I thought writel() includes an implicit write barrier?
And that one uses writel_relaxed() if the barrier is not needed?

Did I misunderstand?

Somewhat related discussions:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/117626
http://billauer.co.il/blog/2014/08/wmb-rmb-mmiomb-effects/

Regards.
