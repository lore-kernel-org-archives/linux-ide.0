From: Anton Salnikov <asalnikov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 22 Jan 2008 15:11:37 +0300
Message-ID: <200801221511.37372.asalnikov@ru.mvista.com>
References: <200801212144.29511.asalnikov@ru.mvista.com> <20080121195148.146741ca@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:40343 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751690AbYAVMLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 07:11:40 -0500
In-Reply-To: <20080121195148.146741ca@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

> > +static inline u32 ioread(u32 reg)
> > +{
> > +	return ioread32(base + reg);
> > +}
> > +
> > +static inline void iowrite(u32 val, u32 reg)
> > +{
> > +	iowrite32(val, base + reg);
> > +}
> 
> Why not just use ioread32/iowrite32 directly ?

Because this increases readability and does not affect functionality at all

> Otherwise this looks way way better.
> 
> Alan
> 

Anton
