From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: stop engine during hard reset
Date: Thu, 26 Jan 2006 23:07:17 -0500
Message-ID: <43D99C75.8010504@pobox.com>
References: <20060123073153.GA27470@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:18106 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751162AbWA0EHU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:07:20 -0500
In-Reply-To: <20060123073153.GA27470@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> AHCI spec mandates engine to be stopped during hard resets.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


