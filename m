From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: move BMDMA host status recording from EH
 to interrupt handler
Date: Tue, 28 Nov 2006 04:01:59 -0500
Message-ID: <456BFB07.2000105@pobox.com>
References: <20061117030621.GD2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57986 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935724AbWK1JCB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:02:01 -0500
In-Reply-To: <20061117030621.GD2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> For certain errors, interrupt handler alter BMDMA host status before
> entering EH (clears active and intr).  Thus altered BMDMA host status
> value is recorded by BMDMA EH and reported to user.  Move BMDMA host
> status recording from EH to interrupt handler.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


