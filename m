From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: improve spurious SDB FIS handling
Date: Thu, 01 Mar 2007 20:20:02 -0500
Message-ID: <45E77BC2.3060400@garzik.org>
References: <20070227042419.GG20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46276 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422673AbXCBBUE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:20:04 -0500
In-Reply-To: <20070227042419.GG20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Spurious SDB FIS during NCQ might not contain spurious completions.
> It could be spurious TF update or invalid async notification.  Treat
> as HSM violation iff a spurious SDB FIS contains spurious completions;
> otherwise, just whine once about it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


