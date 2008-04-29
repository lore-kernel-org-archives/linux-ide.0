From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: PIO bounce copies to avoid long IRQ off runs
Date: Tue, 29 Apr 2008 17:21:34 +0100
Message-ID: <20080429172134.6e6d6b0a@core>
References: <20080429144754.7d2952c8@core>
	<da824cf30804290851g117b97e4u6952f64d02a09f02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42580 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760880AbYD2Q3I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 12:29:08 -0400
In-Reply-To: <da824cf30804290851g117b97e4u6952f64d02a09f02@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> >  -               kunmap_atomic(buf, KM_IRQ0);
> >  -               local_irq_restore(flags);
> >  +       if (PageHighMem(page) || 1 /* TEST FIXME */) {
> 
> Did you want the "|| 1" code committed as well?

Well it was more for discussion but no I didn't. Well spotted 8)


Alan
