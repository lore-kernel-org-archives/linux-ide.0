From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: improve HPA error handling
Date: Mon, 24 Mar 2008 22:25:37 -0400
Message-ID: <47E862A1.5080300@garzik.org>
References: <47E6477B.1020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49162 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbYCYCZk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 22:25:40 -0400
In-Reply-To: <47E6477B.1020805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> There's no point in retrying and eventually failing device detection
> when the device rejects READ_NATIVE_MAX[_EXT].  Disable HPA unlocking
> if READ_NATIVE_MAX[_EXT] is rejected as done when SET_MAX[_EXT] is
> rejected.
> 
> This allows some old drives to work even if they aren't blacklisted.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

applied


