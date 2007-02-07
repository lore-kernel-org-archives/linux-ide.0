From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add 150ms between completion of hardreset and
 status checking
Date: Tue, 06 Feb 2007 19:43:57 -0500
Message-ID: <45C920CD.6020804@garzik.org>
References: <20070202062927.GA1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56951 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932952AbXBGAn7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:43:59 -0500
In-Reply-To: <20070202062927.GA1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Follow the old SRST rule and delay 150ms between completion of
> hardreset and status checking.  Debouncing delay should usually cover
> this but debounce duration could be shorter than 150ms under certain
> circumstances.
> 
> Usefulness depends on host controller implementation but it can't hurt
> and serves as a reminder that 2s delay for GoVault should also be
> added here.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

applied


