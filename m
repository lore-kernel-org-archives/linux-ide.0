From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-sff: fix ata_sff_post_internal_cmd()
Date: Wed, 22 Oct 2008 20:40:39 -0400
Message-ID: <48FFC807.1050201@garzik.org>
References: <48FC04AD.7050309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50707 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbYJWAkm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:40:42 -0400
In-Reply-To: <48FC04AD.7050309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ata_sff_post_internal_cmd() needs to grab port lock before calling
> ata_bmdma_stop() and also need to clear hsm_task_state.  Fix it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-sff.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

applied


