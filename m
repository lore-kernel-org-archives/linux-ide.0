From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a
 channel
Date: Thu, 25 Jan 2007 13:50:24 +0000
Message-ID: <20070125135024.32b31a72@localhost.localdomain>
References: <20070125112947.GC8606@htj.dyndns.org>
	<20070125123030.3093fb32@localhost.localdomain>
	<45B8A63F.8060305@pobox.com>
	<45B8B0DF.4080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:53654 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965352AbXAYNiz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 08:38:55 -0500
In-Reply-To: <45B8B0DF.4080602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> >> NAK, this is totally wrong
> 
> Eek.. You actually said this is/was documented and relied upon all over.
> 
> http://thread.gmane.org/gmane.linux.ide/13184/focus=14486

What I said (well tried to say since it was apparently vague and caused
confusion) was relied upon was the hardware being in PIO0 during probe
(because we don't call the PIO setup methods during probe/reset) and that
we decide which modes both devices are using *before* we set either of
them (which the current code appears to do correctly). This is because
the device may need to know both to apply limits - such as merging
address setup time.

> 
> (searching mailboxes more...)  Oh, and the dropping of common PIO mode
> selection was agreed upon by Jeff and Alan.
> 
> One way or the other, this only affects PATA devices and as long as all
> PATA LLDs guarantee that selection timing isn't violated, this can go.
> I thought PATA drivers still relied on this common denominator PIO mode
> configuration.  I think it's Alan's call.
> 
> > I'm curious what the motivation of this patch was?
> 
> Hope my intentions are explained.

Yep. I think it's a simple case of confusion about the meaning of an
email.

Alan
