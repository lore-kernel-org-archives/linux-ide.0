From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 18:17:20 -0400
Message-ID: <469D3FF0.2010109@garzik.org>
References: <20070717214239.GF28448@devserv.devel.redhat.com> <ada8x9epuip.fsf@cisco.com> <469D3E66.3010502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50197 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbXGQWRY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 18:17:24 -0400
In-Reply-To: <469D3E66.3010502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

Jeff Garzik wrote:
> I don't buy that performance argument, in this case.  You are already 
> dirtying the same cacheline with other variable initializations.

Or simply sitting in a CPU register for large stretches of function 
runtime...

	Jeff


