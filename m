From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/14] libata-hp-prep: implement sata_phy_debounce()
Date: Fri, 19 May 2006 11:07:21 -0400
Message-ID: <446DDF29.7000500@pobox.com>
References: <11480445841146-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932337AbWESPHh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:07:37 -0400
In-Reply-To: <11480445841146-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With hotplug, PHY always needs to be debounced before a reset as any
> reset might find new devices.  Extract PHY waiting code from
> sata_phy_resume() and extend it to include SStatus debouncing.  Note
> that sata_phy_debounce() is superset of what used to be done inside
> sata_phy_resume().
> 
> Three default debounce timing parameters are defined to be used by
> hot/boot plug.  As resume failure during probing will be properly
> handled as errors, timeout doesn't have to be long as before.
> probeinit() uses the same timeout to retain the original behavior.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 8-10


