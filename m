From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 6/7] libata: clean up the SFF code for coding style
Date: Fri, 05 Dec 2008 15:29:58 -0500
Message-ID: <49398F46.2040804@garzik.org>
References: <20081205194231.17133.42760.stgit@localhost.localdomain> <20081205194333.17133.94943.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47302 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbYLEUaG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Dec 2008 15:30:06 -0500
In-Reply-To: <20081205194333.17133.94943.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/ata/libata-sff.c |  136 +++++++++++++++++++++++-----------------------
>  1 files changed, 69 insertions(+), 67 deletions(-)

I always disliked the style where exports were mixed in with code, 
because IMO in practice it clouds the picture of what exactly is exported.

But I suppose time has overruled me, so I'll apply...

	Jeff



