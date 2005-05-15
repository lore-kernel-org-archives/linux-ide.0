From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-2.6] libata: flush COMRESET set and clear
Date: Sun, 15 May 2005 19:01:01 -0400
Message-ID: <4287D4AD.7020104@pobox.com>
References: <20050325231907.E1D11BADC@lns1032.lss.emc.com> <20050328201027.3A50529917@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:4505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261329AbVEOXBG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 19:01:06 -0400
In-Reply-To: <20050328201027.3A50529917@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Brett Russ wrote:
> Updated patch to fix erroneous flush of COMRESET set and missing flush
> of COMRESET clear.  Created a new routine scr_write_flush() to try to
> prevent this in the future.  Also, this patch is based on libata-2.6
> instead of the previous libata-dev-2.6 based patch.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

applied


