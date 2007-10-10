From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] pata_jmicron: match vendor and class code only
Date: Tue, 09 Oct 2007 21:32:47 -0400
Message-ID: <470C2BBF.3080109@garzik.org>
References: <20071006220450.GD12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58433 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbXJJBct (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:32:49 -0400
In-Reply-To: <20071006220450.GD12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ethanhsiao@jmicron.com, justin@jmicron.com

Tejun Heo wrote:
> PATA part of all current JMB controllers behave the same way and
> JMicron confirms that all future ones will stay compatible.  Drop
> device matching and match only vendor and class.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
> Cc: Justin Tsai <justin@jmicron.com>
> ---
>  drivers/ata/pata_jmicron.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

applied


