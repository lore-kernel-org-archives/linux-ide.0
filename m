From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] ata_generic: unindent loop in generic_set_mode()
Date: Sat, 01 Dec 2007 18:19:05 -0500
Message-ID: <4751EBE9.4080900@garzik.org>
References: <11961602293422-git-send-email-htejun@gmail.com> <11961602293431-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59304 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbXLAXTH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:19:07 -0500
In-Reply-To: <11961602293431-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> Unindent loop body in generic_set_mode().  This is to ease future
> change.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ata_generic.c |   31 ++++++++++++++++---------------
>  1 files changed, 16 insertions(+), 15 deletions(-)

applied 1-12 to #upstream, with comments


