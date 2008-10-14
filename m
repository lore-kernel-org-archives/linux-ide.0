From: Tejun Heo <tj@kernel.org>
Subject: Re: How to determine performance bottleneck?
Date: Wed, 15 Oct 2008 02:19:25 +0900
Message-ID: <48F4D49D.3050602@kernel.org>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>	 <48F3D8E2.8000006@kernel.org> <da824cf30810140929o4b82f69fs9a826ef880d3f462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45352 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbYJNRVy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 13:21:54 -0400
In-Reply-To: <da824cf30810140929o4b82f69fs9a826ef880d3f462@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Grant Grundler wrote:
> On Mon, Oct 13, 2008 at 4:25 PM, Tejun Heo <tj@kernel.org> wrote:
> ...
>>> Tejun, what kind of throughput have you seen when you have been testing
>>> the sil3132 and multipliers?
>> That's the limit of sil3124/3132.  Dunno why but you can't go over that.
> 
> To be clear, I understood "that" ==  ~100 MB/s

It's somewhere around that.  I don't remember the exact number at the
moment.

>>  There's 3132-2 chip on the market.  Maybe it's worth a try?
> 
> Are you possibly thinking of 3124-2 ? (4-port PCI-X device, not PCI-e)
> 
> I didn't see mention of 3132-2 on
> http://www.siliconimage.com/products/product.aspx?id=32

I asked SIMG about the issue and whether they have newer revisions which
solve the issue.  When I know more, I'll post it on the ata wiki page.

Thanks.

-- 
tejun
