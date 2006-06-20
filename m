From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] libata: implement per-dev EH action mask
	eh_info->dev_action[]
Date: Tue, 20 Jun 2006 15:02:44 +0800
Message-ID: <1150786964.7132.117.camel@forrest26.sh.intel.com>
References: <20060619092723.GF11755@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12849 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965017AbWFTHV0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 03:21:26 -0400
In-Reply-To: <20060619092723.GF11755@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, 2006-06-19 at 18:27 +0900, Tejun Heo wrote:
> Note that per-dev actions
> can still be specified at port-level and it has the same effect of
> specifying the action for all devices on the port.
> 

Why not use eh_info->action for port-level only, and eh_info->dev_action
[] for device-level only?
>From my understanding, this clear separation can at least make code easy
to read.

Thanks,
Forrest
