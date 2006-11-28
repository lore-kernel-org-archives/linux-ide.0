From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: remove unused HSM_ST_UNKNOWN
Date: Tue, 28 Nov 2006 04:00:54 -0500
Message-ID: <456BFAC6.3070403@pobox.com>
References: <20061117030511.GC2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51586 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935722AbWK1JA4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:00:56 -0500
In-Reply-To: <20061117030511.GC2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> HSM_ST_UNKNOWN is not used anywhere.  Its value is zero and supposed
> to serve sanity check purpose but HSM_ST_IDLE is used for that
> purpose.  This unused state causes confusion.  After a port is
> initialized but before the first command is executed, the idle hsm
> state is UNKNOWN.  However, once a command has completed, the idle hsm
> state is IDLE.  This defeats sanity check in ata_pio_task() for the
> first command.
> 
> This patch removes HSM_ST_UNKNOWN and consequently make HSM_ST_IDLE
> the default state.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


