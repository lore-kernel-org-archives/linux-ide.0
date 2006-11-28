From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix READ CAPACITY simulation
Date: Tue, 28 Nov 2006 04:10:34 -0500
Message-ID: <456BFD0A.90209@pobox.com>
References: <20061120021547.GL2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935739AbWK1JKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:10:39 -0500
In-Reply-To: <20061120021547.GL2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com

Tejun Heo wrote:
> * READ CAPACITY (16) implementation fixed.  Result was shifted by two
>   bytes.  Carlos Pardo spotted this problem and submitted preliminary
>   patch.  Capacity => 2TB is handled correctly now.  (verifid w/ fake
>   capacity)
> 
> * Use dev->n_sectors instead of re-reading directly from ID data.
> 
> * Define and use ATA_SCSI_RBUF_SET() which considers rbuf length.
>   This should be done for all simulation functions.  Userland can
>   issue any simulated command with arbitrary buffer length.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

ACK


