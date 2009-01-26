From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: set NODEV_HINT for 0x7f status
Date: Mon, 26 Jan 2009 06:39:59 -0500
Message-ID: <497DA10F.6020507@garzik.org>
References: <497BBFA8.4080804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55161 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbZAZLkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:40:03 -0500
In-Reply-To: <497BBFA8.4080804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, bugsbuggy@ymail.com

Tejun Heo wrote:
> Asus Pundit-R with atiixp controller has the second port missing and,
> very unusually, its status is stuck at 0x7f and all others at 0.  This
> meanst that it fails TF access test but gets detected as a disk due to
> classification code check and then evades polling IDENTIFY presence
> detection thanks to the missing BSY in the status value causing
> excessive delays during boot.
> 
> This patch makes libata-sff HSM set NODEV_HINT if the status is 0x7f
> to make polling IDENTIFY presence detection work for these machines.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-sff.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)

applied


