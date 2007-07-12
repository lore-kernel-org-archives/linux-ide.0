From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 13/15] ahci: separate out ahci_exec_polled_cmd()
Date: Thu, 12 Jul 2007 16:26:44 -0400
Message-ID: <46968E84.4070000@garzik.org>
References: <11832872563686-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55738 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985AbXGLU0q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:26:46 -0400
In-Reply-To: <11832872563686-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out ahci_exec_polled_cmd() from ahci_softreset().  This will
> be used to implement ahci_pmp_read/write().  ahci_exec_polled_cmd()
> performs reset_engine before returning if the command fails (times
> out).  This is to improve robustness.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   54 +++++++++++++++++++++++++++++++--------------------
>  1 files changed, 33 insertions(+), 21 deletions(-)

ditto

might have to rediff to latest #upstream, versus my ahci.c changes


