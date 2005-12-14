From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/7] SATA ACPI linux/libata.h update
Date: Wed, 14 Dec 2005 17:08:33 -0500
Message-ID: <43A097E1.1000402@pobox.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com> <20051213160530.1fcadda0.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13785 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965004AbVLNWIf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2005 17:08:35 -0500
In-Reply-To: <20051213160530.1fcadda0.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, axboe@suse.de

Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Add ACPI data pointer/length holders.
> 
> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Why does struct ata_device need to remember this info at all?

	Jeff



