From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: finish CONFIG_SCSI_[S]ATA -> CONFIG_[S]ATA renames
Date: Fri, 18 Aug 2006 14:36:08 -0400
Message-ID: <44E60898.4020805@pobox.com>
References: <20060818180832.GJ6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41192 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030503AbWHRSgM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2006 14:36:12 -0400
In-Reply-To: <20060818180832.GJ6371@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata CONFIG_* constants have been renamed during drivers/scsi ->
> drivers/ata move but old constants are still in use in many places.
> This patch converts all such places to new constants.
> 
> This patch restores INTEL_COMBINED quirk handling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

We never patch any arch's defconfig.  That's the responsibility of the 
arch maintainer to update.

	Jeff



