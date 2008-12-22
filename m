From: Tejun Heo <tj@kernel.org>
Subject: Re: ICH10R and Samsung HDS724040KLSA80
Date: Mon, 22 Dec 2008 18:59:59 +0900
Message-ID: <494F651F.7020809@kernel.org>
References: <b1dab3a10812211242q29515f80n54cd3b9d8b3edc34@mail.gmail.com> <494EDA84.9000603@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35144 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbYLVKAF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 05:00:05 -0500
In-Reply-To: <494EDA84.9000603@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Obviously HPA processing is not being skipped in your case. The existing
> blacklist entry only covers HDS724040KLSA80 with firmware KFAOA20N. Your
> drive might be a different firmware version (it's not possible to tell
> from this log as the SCSI message only shows the first 4 characters of
> the firmware). Can you can tell what the firmware version is (hdparm -I
> on the drive, I believe, if you can get it to be recognized)?

Yeah, it looks like either a broken firmware or PHYs don't like each
other on 3.0Gbps.  Does "libata.force=2:1.5Gbps" help?

-- 
tejun
