From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Fri, 10 Oct 2008 17:55:08 -0700
Message-ID: <20081010175508.3d1ed2a4@infradead.org>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org>
	<20081010202515.446857cc@lxorguk.ukuu.org.uk>
	<20081010200528.GJ19428@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44748 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYJKAzP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 20:55:15 -0400
In-Reply-To: <20081010200528.GJ19428@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, torvalds@osdl.org

On Fri, 10 Oct 2008 22:05:28 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> In this specific patch, it'll do no harm at least since I very much
> doubt we'll see a false positive. And even if, the consequences wont
> be dire. But it does want the version check, of course.
> 

also, is "is an ssd" the right question or is "doesn't have seek
latency" the right one?
(difference is.. well EMC boxes with lots of ram etc)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
