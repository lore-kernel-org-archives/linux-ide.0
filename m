From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 02/07] sil24: move error handling
 out of hot interrupt path
Date: Thu, 11 Aug 2005 15:18:05 -0400
Message-ID: <42FBA46D.7040504@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org> <20050730101344.F56FB4A0@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48807 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932385AbVHKTSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:18:10 -0400
In-Reply-To: <20050730101344.F56FB4A0@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 02_sil24_separate-out-error-path.patch
> 
> 	Move error handling from sil24_host_intr into separate
> 	function - sil24_error_intr.
> 
> 	Jeff, I don't think this patch actually improves readability
> 	and/or performance.  Is this what you wanted?

Yes.

It improves readability and maintainability by clearly separating the 
error and non-error paths.

It improves performance by removing an uncommon path -- error -- from 
the hot path (command completion).

	Jeff


