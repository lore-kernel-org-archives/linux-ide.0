From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clear ehi description after initial host report
Date: Tue, 09 Oct 2007 21:40:52 -0400
Message-ID: <470C2DA4.1090402@garzik.org>
References: <20071009055725.GF12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41713 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbXJJBky (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:40:54 -0400
In-Reply-To: <20071009055725.GF12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ehi description field is used to carry LLD specific controller
> description.  Sometimes, it's used without clearing before and LLD
> description gets printed with exception information one more time.
> Clear after printing.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

applied


