From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata#upstream] sata_promise: decode and report error
 reasons
Date: Wed, 04 Apr 2007 01:43:49 -0400
Message-ID: <46133B15.9020301@garzik.org>
References: <200703140851.l2E8pZ8A006182@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41459 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966313AbXDDFnv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 01:43:51 -0400
In-Reply-To: <200703140851.l2E8pZ8A006182@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch adds much needed error reason decoding and
> reporting to sata_promise. It's simplistic but should
> log all relevant error info the controller provides.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/sata_promise.c |   64 ++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 55 insertions(+), 9 deletions(-)
> 
> Changes since the preliminary version:
> * dropped SError decoding, as all bits there are standard
> * PDC2_HTO_ERR is mapped to AC_ERR_HOST_BUS not AC_ERR_TIMEOUT
> * PDC_UNDERRUN_ERR and PDC_OVERRUN_ERR are mapped to AC_ERR_HSM
>   not AC_ERR_ATA_BUS
> * added brief explanations to error constant declarations
> * some cleanups and simplifications

applied


