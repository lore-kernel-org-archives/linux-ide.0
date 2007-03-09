From: Tejun Heo <teheo@suse.de>
Subject: Re: [PATCH] devres: release resources on device_del()
Date: Fri, 09 Mar 2007 19:36:56 +0900
Message-ID: <45F138C8.40409@suse.de>
References: <20070309103419.GB32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jericho.provo.novell.com ([137.65.248.124]:53640 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993111AbXCIKhN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:37:13 -0500
In-Reply-To: <20070309103419.GB32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some platform devices are driven without driver attached, so managed
> resources can be acquired without driver attached.  Make sure such
> resources are released by calling devres_release_all() in
> device_del().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This one fixes oops on pata_platform and pata_legacy unload.  libata
> being the only user of devres at the moment.  I think this can go
> through libata-dev#upstream.

I meant libata-dev#upstream-fixes.  This needs to be fixed in 2.6.21.

-- 
tejun
