From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] libata: add back ->data_xfer to ata_piix.c
Date: Fri, 26 May 2006 21:31:19 -0400
Message-ID: <4477ABE7.5010203@pobox.com>
References: <447696DE.5090604@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10211 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751219AbWE0BbW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 21:31:22 -0400
In-Reply-To: <447696DE.5090604@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Add back ->data_xfer and ->mode_filter to ata_piix.c.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> The ->data_xfer and ->mode_filter hooks of ata_piix.c are left out when
> Alan's patches are merged. Add them back.

applied


