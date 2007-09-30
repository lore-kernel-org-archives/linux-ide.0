From: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 16:42:20 +0200
Message-ID: <20070930164220.47dd3d47@localhost>
References: <20070930160548.235be972@localhost>
	<46FFAFE1.2010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:59177 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbXI3OmY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Sep 2007 10:42:24 -0400
In-Reply-To: <46FFAFE1.2010302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sun, 30 Sep 2007 07:17:05 -0700
Tejun Heo <htejun@gmail.com> wrote:

> Paolo Ornati wrote:
> > Seagate Barracuda ST380817AS has troubles with NCQ. For example,
> > unpacking a tarball on an XFS filesystem gives this:
> > 
> > ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> > ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
> >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)  
> 
> Hmmm... Was there a thread about this one?  Also, please cc
> linux-ide@vger.kernel.org.

Yes, this was the thread:
http://lkml.org/lkml/2007/1/21/43

-- 
	Paolo Ornati
	Linux 2.6.23-rc8-ga64314e6-dirty on x86_64
