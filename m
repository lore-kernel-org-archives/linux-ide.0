From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] ahci: separate out ahci_kick_engine()
Date: Thu, 12 Jul 2007 16:26:24 -0400
Message-ID: <46968E70.7010004@garzik.org>
References: <11832872563253-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55724 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654AbXGLU00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:26:26 -0400
In-Reply-To: <11832872563253-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out stop_engine - CLO - start_engine sequence from
> ahci_softreset() and ahci_clo() into ahci_reset_engine() and use it in
> ahci_softreset() and ahci_post_internal_cmd().  The function will also
> be used to prepare for and clean up after PMP register access
> commands.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   69 +++++++++++++++++++++++++++-------------------------
>  1 files changed, 36 insertions(+), 33 deletions(-)

ditto


