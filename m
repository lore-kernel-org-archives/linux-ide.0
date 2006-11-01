From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: move ata_irq_on() into libata-sff.c
Date: Wed, 01 Nov 2006 00:14:01 -0500
Message-ID: <45482D19.7060800@pobox.com>
References: <20061009021026.GA10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34267 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946060AbWKAFOE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 00:14:04 -0500
In-Reply-To: <20061009021026.GA10832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_irq_on() isn't used outside of libata core layer.  The function is
> TF/SFF interface specific but currently used by core path with some
> hack too.  Move it from include/linux/libata.h to
> drivers/ata/libata-sff.c.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


