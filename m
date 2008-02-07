From: Jeff Garzik <JGarzik@DunveganMedia.com>
Subject: Re: [PATCH 2/4] libata: update ATAPI overflow draining
Date: Wed, 06 Feb 2008 19:14:00 -0500
Message-ID: <47AA4D48.8030807@DunveganMedia.com>
References: <11992723701811-git-send-email-htejun@gmail.com> <11992723711166-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47014 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933148AbYBGAOE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 19:14:04 -0500
In-Reply-To: <11992723711166-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> For misc ATAPI commands which transfer variable length data to the
> host, overflow can occur due to application or hardware bug.  Such
> overflows can be ignored safely as long as overflow data is properly
> drained.  libata HSM implementation has this implemented in
> __atapi_pio_bytes() and recently updated for 2.6.24-rc but it requires
> further improvements.  Improve drain logic such that...
> 
> * Report overflow errors using ehi desc mechanism instead of printing
>   directly.
> 
> * Properly calculate the number of bytes to be drained considering
>   actual number of consumed bytes for partial draining.
> 
> * Add and use ata_drain_page for draining.  This change fixes the
>   problem where LLDs which do 32bit IOs consumes 4 bytes on each 2
>   byte draining resulting in draining twice more data than requested.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Acked-by: Albert Lee <albertcc@tw.ibm.com>
> ---
>  drivers/ata/libata-core.c |  104 +++++++++++++++++++++++----------------------
>  1 files changed, 53 insertions(+), 51 deletions(-)

(updating status on an old patch)

dropped, due to your current work



