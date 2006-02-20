From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: fix WARN_ON() condition in *_fill_sg()
Date: Mon, 20 Feb 2006 16:56:45 -0500
Message-ID: <43FA3B1D.1030202@pobox.com>
References: <11404469171463-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:2540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932626AbWBTV4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 16:56:49 -0500
In-Reply-To: <11404469171463-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> For ATAPI commands, padding can reduce qc->n_elem by one and thus to
> zero making assert(qc->n_elem > 0)'s in ata_fill_sg() and qs_fill_sg()
> fail for legal commands.  This patch fixes the assert()'s to take
> qc->pad_len into account.
> 
> Although the condition check seems a bit excessive, as this part of
> code isn't still stable yet, I think it's worth to keep those.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


