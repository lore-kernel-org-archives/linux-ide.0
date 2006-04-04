From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: do not fail softreset if PHY reports no device
Date: Tue, 04 Apr 2006 08:44:48 -0400
Message-ID: <44326A40.3040008@garzik.org>
References: <442FF8C2.40201@garzik.org> <20060402164936.GA20570@htj.dyndns.org> <20060402165806.GO13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36812 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932435AbWDDMov (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 08:44:51 -0400
In-Reply-To: <20060402165806.GO13172@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> All softreset methods are responsible for detecting device presence
> and succeed softreset in such cases.  AHCI didn't use to check for
> device presence before proceeding with softreset and this caused
> unnecessary reset retrials during probing.  This patch adds presence
> detection to AHCI softreset.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> This makes AHCI act like all other softresets and new EH already
> handles false successes properly.  So, I think this should do the
> trick.

applied


