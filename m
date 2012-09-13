From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [libata:NEXT 14/21] ERROR: "ata_dev_set_feature"
 [drivers/ata/libahci.ko] undefined!
Date: Thu, 13 Sep 2012 13:51:46 +0800
Message-ID: <20120913055146.GA23462@localhost>
References: <20120913053915.GA23363@localhost>
 <5051726A.8090708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51708 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691Ab2IMFvv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2012 01:51:51 -0400
Content-Disposition: inline
In-Reply-To: <5051726A.8090708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Shane Huang <shane.huang@amd.com>, kernel-janitors@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

> This should already be fixed by
> 
> commit 633de4cc2c049949459dd0b73d78576cd23906b5
> Author: Jeff Garzik <jeff@garzik.org>

Hi Jeff, if you prefer to not rebase this branch (or more), please
tell me so that I avoid sending such fixed errors in future. Otherwise
they'll be reported anyway for improving bisectability.

Thanks,
Fengguang
