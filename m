From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 15:09:52 +0800
Message-ID: <1151305792.7132.184.camel@forrest26.sh.intel.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
	 <1151304179.7132.169.camel@forrest26.sh.intel.com>
	 <449F8597.7090605@gmail.com>
	 <1151304561.7132.173.camel@forrest26.sh.intel.com>
	 <449F88A9.30109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12637 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932301AbWFZHWj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 03:22:39 -0400
In-Reply-To: <449F88A9.30109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, 2006-06-26 at 16:11 +0900, Tejun Heo wrote:
> Will do after this whole thing get reviewed.  I don't know much about 
> ACPI but don't we need to do it regardless of LLDs?  If so, I think it 
> might be better to hook those directly into ata_eh_suspend/resume(). 

in ata_eh_suspend/resume(), all operations are device-level. We need a
port-level function inside ata_eh_suspend/resume(), and inside this
port-level function both generic port-level operations and LLD specific
port-level callbacks are called.

Thanks,
Forrest

