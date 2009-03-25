From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] pata_artop: Serializing support
Date: Tue, 24 Mar 2009 22:46:20 -0400
Message-ID: <49C99AFC.8040107@garzik.org>
References: <20090324101952.9152.30261.stgit@localhost.localdomain> <20090324102139.9152.87330.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45704 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753659AbZCYCqZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:46:25 -0400
In-Reply-To: <20090324102139.9152.87330.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Enable both ports on the 6210 and serialize them
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  block/blk-settings.c     |    2 +-

applied 1-2, after removing the block/* comment changes (not my area)


