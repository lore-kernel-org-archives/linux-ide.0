From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: make user scan wait for scan to complete
Date: Wed, 01 Nov 2006 00:17:20 -0500
Message-ID: <45482DE0.8040002@pobox.com>
References: <20060930090717.GO25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41691 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1945978AbWKAFRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:17:23 -0500
In-Reply-To: <20060930090717.GO25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, fajunchen@gmail.com

Tejun Heo wrote:
> Make user scan wait for scan to complete.  This way user can wait for
> warm plug request to complete and is prevented from causing EH event
> storm by repetitively issuing scan request while EH is in progress.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Fajun Chen <fajunchen@gmail.com>

applied


