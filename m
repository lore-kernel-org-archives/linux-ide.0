From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 2.6.12-rc4 1/1] libata: stop setting sdev->host->max_sectors
 for lba48 drives
Date: Sun, 15 May 2005 18:02:00 -0400
Message-ID: <4287C6D8.5030204@pobox.com>
References: <20050512194953.GA8587@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:12952 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261266AbVEOWCD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 18:02:03 -0400
In-Reply-To: <20050512194953.GA8587@tuxdriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-ide@vger.kernel.org, stuart_hayes@Dell.com

John W. Linville wrote:
> Avoid changing sdev->host->max_sectors because it can prevent use of
> non-lba48 drives on other ports of the same adapter.
> 
> Signed-off-by: Stuart Hayes <stuart_hayes@Dell.com>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

applied


