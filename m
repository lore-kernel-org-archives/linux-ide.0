From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] ata_piix: clean up port flags
Date: Tue, 31 Oct 2006 23:55:38 -0500
Message-ID: <454828CA.1000806@pobox.com>
References: <1159598809262-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:65242 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161488AbWKAEzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 23:55:51 -0500
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

AFAICS, SRST is quite necessary on PATA.  What's going on?  There isn't 
much of any explanation for the SRST removal here :/

	Jeff



