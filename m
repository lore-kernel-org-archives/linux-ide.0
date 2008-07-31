From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2/2] libata-core: make sure that ata_force_tbl is freed
 in case of an error
Date: Thu, 31 Jul 2008 01:50:45 -0400
Message-ID: <489152B5.4050407@garzik.org>
References: <200807301932.m6UJWdaM012125@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42433 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbYGaFus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:50:48 -0400
In-Reply-To: <200807301932.m6UJWdaM012125@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, eo@nebensachen.de, alan@lxorguk.ukuu.org.uk, tj@kernel.org

akpm@linux-foundation.org wrote:
> From: Elias Oltmanns <eo@nebensachen.de>
> 
> Fix a potential memory leak when ata_init() encounters an error.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

applied


