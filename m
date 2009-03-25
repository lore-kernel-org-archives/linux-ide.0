From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/4] libata: Drain data on errors
Date: Tue, 24 Mar 2009 22:48:56 -0400
Message-ID: <49C99B98.30008@garzik.org>
References: <20090324101952.9152.30261.stgit@localhost.localdomain> <20090324102230.9152.26655.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45719 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbZCYCtB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:49:01 -0400
In-Reply-To: <20090324102230.9152.26655.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> If the device is signalling that there is data to drain after an error we
> should read the bytes out and throw them away. Without this some devices
> and controllers get wedged and don't recover.
> 
> Based on earlier work by Mark Lord
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/ata/libata-sff.c  |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/ata/pata_pcmcia.c |   34 +++++++++++++++++++++++++++++++++-
>  include/linux/libata.h    |    3 +++
>  3 files changed, 79 insertions(+), 3 deletions(-)

applied


