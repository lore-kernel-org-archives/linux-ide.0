From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I have returned!
Date: Thu, 16 Oct 2008 05:40:39 -0400
Message-ID: <48F70C17.5030202@pobox.com>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru> <48F2F138.6020103@kernel.org> <48F34CB9.3020000@pobox.com> <20081013150231.294b38b6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56897 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbYJPJkr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 05:40:47 -0400
In-Reply-To: <20081013150231.294b38b6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
>> I have returned!  muhahahahahaha....
> 
> Oh good..
> --
> 
> ibmtr: PCMCIA IBMTR is ok on 64bit
> 
> From: Alan Cox <alan@redhat.com>
> 
> For whatever value of 'OK' can be applied to the use of token ring. Seems
> the 32bit to 64bit cleanups missed re-enabling the pcmcia driver
> 
> Closes #7133 and also reviewed the code in question
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/net/pcmcia/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

applied


