From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata: fix comment regarding setting cable type
Date: Mon, 20 Feb 2006 06:20:13 -0500
Message-ID: <43F9A5ED.9080008@pobox.com>
References: <1139983302106-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51155 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932505AbWBTLUQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 06:20:16 -0500
In-Reply-To: <1139983302106-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> The comment above ata_std_postreset() specified that setting cable
> type is the responsibility of postreset(), which isn't possible /
> optimal depending on controller / driver.  This patch kills the
> comment.  Setting cable type is responsibility of ->probe_reset.
> libata doesn't care whether it's done in probeinit, reset or
> postreset.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-3


