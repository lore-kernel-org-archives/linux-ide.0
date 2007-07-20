From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] libata: fix last_ctl caching in ata_tf_read()
Date: Fri, 20 Jul 2007 07:46:48 -0400
Message-ID: <46A0A0A8.6070603@garzik.org>
References: <469CC9E3.4030907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49749 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbXGTLqt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:46:49 -0400
In-Reply-To: <469CC9E3.4030907@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> libata: fix last_ctl caching in ata_tf_read()
> 
> last_ctl was not cached properly. (Pointed out
> by Tejun Heo.)
> 
> Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
> 
> ---
> (Apply after Petr's patch to fix SMART bugs.)
> 
>  drivers/ata/libata-sff.c |    4 ++++
>  1 file changed, 4 insertions(+)

Petr's new patch eliminates the need for this...


