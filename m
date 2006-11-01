From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/6] libata: convert @post_reset to @flags in ata_dev_read_id()
Date: Wed, 01 Nov 2006 00:36:04 -0500
Message-ID: <45483244.9050600@pobox.com>
References: <115959880960-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946111AbWKAFgR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:36:17 -0500
In-Reply-To: <115959880960-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make ata_dev_read_id() take @flags instead of @post_reset.  Currently
> there is only one flag defined - ATA_READID_POSTRESET, which is
> equivalent to @post_reset.  This is preparation for polling presence
> detection.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


