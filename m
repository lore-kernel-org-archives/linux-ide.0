From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: revalidate after transfer mode configuration
Date: Fri, 03 Mar 2006 17:42:29 -0500
Message-ID: <4408C655.8050500@pobox.com>
References: <11412012393687-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17559 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751292AbWCCWmb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 17:42:31 -0500
In-Reply-To: <11412012393687-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Revalidate device after transfer mode configuration.  This also makes
> dev->id up-to-date.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 1, 2 and 4.


