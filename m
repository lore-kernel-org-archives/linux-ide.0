From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sl82c105: dual channel support
Date: Fri, 01 Feb 2008 11:55:53 -0500
Message-ID: <47A34F19.1090901@garzik.org>
References: <20080128160823.4c9f2783@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60645 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758858AbYBAQzz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 11:55:55 -0500
In-Reply-To: <20080128160823.4c9f2783@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Use qc_defer to serialize the two channels
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied...  nice!


