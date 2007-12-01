From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 8/8] libata: implement fast speed down for unverified
 data transfer mode
Date: Sat, 01 Dec 2007 18:07:36 -0500
Message-ID: <4751E938.1090305@garzik.org>
References: <11961593392491-git-send-email-htejun@gmail.com> <1196159340385-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47211 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbXLAXHi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:07:38 -0500
In-Reply-To: <1196159340385-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Tejun Heo wrote:
> It's very likely that the configured data transfer mode is the wrong
> one if device fails data transfers right after initial data transfer
> mode configuration (including NCQ on/off and xfermode).  libata EH
> needs to speed down fast before upper layers give up on probing.
> 
> This patch implement fast speed down rules to handle such cases
> better.  Error occured while data transfer hasn't been verified
> trigger fast back-to-back speed down actions until data transfer
> works.
> 
> This change will make cable mis-detection and other initial
> configuration problems corrected before partition scanning code gives
> up.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I agree strongly.

Good work!


