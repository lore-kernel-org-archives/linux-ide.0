From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: give up hardreset on nf2
Date: Mon, 16 Feb 2009 18:58:15 -0500
Message-ID: <4999FD97.5000609@garzik.org>
References: <49937CA8.60005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45800 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbZBPX6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 18:58:20 -0500
In-Reply-To: <49937CA8.60005@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>, saro_v@hotmail.it, stable@kernel.org

Tejun Heo wrote:
> Kernel bz#12176 reports that nf2 hardreset simply doesn't work.  Give
> up.  Argh...
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Robert Hancock <hancockr@shaw.ca>
> Reported-by: Saro <saro_v@hotmail.it>

applied


