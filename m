From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_marvell: Cable and reset fixes
Date: Fri, 09 Mar 2007 07:32:40 -0500
Message-ID: <45F153E8.3010504@pobox.com>
References: <20070307164809.5802649a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55511 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965787AbXCIMcn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:32:43 -0500
In-Reply-To: <20070307164809.5802649a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> There are two changes here. Firstly we switch to a cable detect method,
> secondly the old code forgot to call ata_std_prereset() but somehow
> managed to work anyway. Fix the missing call.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied (patch dated mar 07)


