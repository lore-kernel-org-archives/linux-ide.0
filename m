From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix class handling in ata_bus_probe()
Date: Sun, 12 Mar 2006 12:50:30 -0500
Message-ID: <44145F66.7050104@garzik.org>
References: <44144172.9040304@garzik.org> <20060312165701.GA9051@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28362 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751300AbWCLRud (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 12:50:33 -0500
In-Reply-To: <20060312165701.GA9051@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ata_bus_probe() didn't set classes[] properly for port disabled case
> of ->phy_reset() compatibility path.  This patch moves classes[]
> initialization and normalization out of ->probe_reset block such that
> it applies to both ->probe_reset and ->phy_reset paths.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


