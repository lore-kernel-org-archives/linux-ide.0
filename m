From: Frans Pop <elendil@planet.nl>
Subject: Re: [git patches] libata fixes
Date: Fri, 07 Dec 2007 22:27:49 +0100
Message-ID: <E1J0kjd-0006zE-SG@faramir.fjphome.nl>
References: <20071207203401.GA29005@havoc.gtf.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml12.KPNXCHANGE.COM ([213.75.38.112]:20011 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754508AbXLGV1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 16:27:52 -0500
In-reply-To: <20071207203401.GA29005@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> libata disabling command queueing (aka NCQ) based on some hueristics for
> detection device brokenness.... that ultimately turned out to be broken.
> 
> Remove the broken hueristic and turn NCQ back on for all the wrongfully
> maligned hard drives.

Yay!
