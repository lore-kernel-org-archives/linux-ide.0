From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] ata_piix: clean up port flags
Date: Wed, 01 Nov 2006 00:35:56 -0500
Message-ID: <4548323C.6080105@pobox.com>
References: <1159598809262-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23004 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946149AbWKAFgN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:36:13 -0500
In-Reply-To: <1159598809262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * move common flags into PIIX_PATA_FLAGS and PIIX_SATA_FLAGS
> * kill unnecessary ATA_FLAG_SRST
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, but no longer applies to #upstream


