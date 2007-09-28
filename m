From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata drain fifo on stuck DRQ HSM violation
Date: Fri, 28 Sep 2007 02:56:44 -0700
Message-ID: <20070928025644.7ee4af0c.akpm@linux-foundation.org>
References: <46CFA08E.6090604@arbores.ca>
	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>
	<46DBCB6C.8080206@gmail.com>
	<20070905095327.6277d054.akpm@linux-foundation.org>
	<46DEE617.4050004@rtr.ca>
	<46E0A253.7060803@gmail.com>
	<46E154DE.2060602@rtr.ca>
	<46FB563A.80108@gmail.com>
	<20070927193701.6230d77f@the-village.bc.nu>
	<46FC3D7D.90009@gmail.com>
	<46FC3FDD.5060201@pobox.com>
	<46FC423C.2050206@gmail.com>
	<46FC7B72.2030103@rtr.ca>
	<46FCCDEC.20200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49636 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754776AbXI1J52 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 05:57:28 -0400
In-Reply-To: <46FCCDEC.20200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 28 Sep 2007 02:48:28 -0700 Tejun Heo <htejun@gmail.com> wrote:

> Mark Lord wrote:
> > Drain up to 512 words from host/bridge FIFO on stuck DRQ HSM violation,
> > rather than just getting stuck there forever.
> > 
> > Signed-Off-By:  Mark Lord <mlord@pobox.com>
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 

Nacked-by: scripts/checkpatch.pl
