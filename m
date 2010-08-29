From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff
 remodeling.
Date: Sun, 29 Aug 2010 11:05:19 +0200
Message-ID: <4C7A22CF.3090403@kernel.org>
References: <AANLkTim9daA5eoQDbtJSnMuoBOEkDV4Y_Z3GbcDxL7Rk@mail.gmail.com> <1283041897-4378-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53482 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab0H2JMC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2010 05:12:02 -0400
In-Reply-To: <1283041897-4378-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jeff@garzik.org, nicolas@jungers.net, linux-ide@vger.kernel.org

Hello,

On 08/29/2010 02:31 AM, Gwendal Grignou wrote:
> Re-introduce port_task_data to hold the link on the which the current
> request is in progress. It allows support of links behind port multiplier.
> 
> Not all libata-sff is PMP compliant. Code for native BMDMA controller
> does not take in accound PMP.
> 
> Tested on Marvell 7042 and Sil7526.

So sata_mv is using SFF state machine for PMP devices too.  Didn't see
that coming.  Thanks for fixing this.  Can you please consider the
followings?

* Make ata_sff_queue_pio_task() take a @qc (or @link if @qc can't be
  used for whatever reason) and @delay, instead of taking @ap, @link
  and @delay.

* Change ata_port->port_task_data to something more specific.  ie.
  sff_pio_task_qc or sff_pio_task_link.

Thanks.

-- 
tejun
