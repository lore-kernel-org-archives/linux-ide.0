From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: move ata_id_n_sectors() upward
Date: Thu, 20 Sep 2007 17:22:34 -0400
Message-ID: <46F2E49A.9010707@garzik.org>
References: <20070903033158.GB16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34136 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbXITVWf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 17:22:35 -0400
In-Reply-To: <20070903033158.GB16890@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Move ata_id_n_sectors() upward right below ata_id_c_string().  This is
> to accomodate later changes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   30 +++++++++++++++---------------
>  1 files changed, 15 insertions(+), 15 deletions(-)

applied 1-3


