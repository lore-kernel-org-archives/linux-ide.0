From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Tue, 30 May 2006 00:24:11 -0400
Message-ID: <447BC8EB.3080607@pobox.com>
References: <1148884736485-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31972 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751355AbWE3EYZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:24:25 -0400
In-Reply-To: <1148884736485-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement unload unplug - driver unloading / PCI removal via hot
> unplug path.  This is done by ata_port_detach() which requests detach
> of all devices, schedules EH and wait for it to complete.  EH path is
> slightly modified to handle this (e.g. force zero eh_info during
> unloading).  With this patch, EH and unloading are properly
> synchronized and unloading should be safe under any circumstances.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

How does this behave for controller hotplug?  For that case, there is 
nothing to EH...

	Jeff



