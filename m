From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] devres: release resources on device_del()
Date: Fri, 09 Mar 2007 07:51:04 -0500
Message-ID: <45F15838.7040501@garzik.org>
References: <20070309103419.GB32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55697 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767230AbXCIMvJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:51:09 -0500
In-Reply-To: <20070309103419.GB32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
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

applied to #upstream-fixes


