From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
Date: Wed, 08 Sep 2004 23:17:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <413FCB61.7060604@pobox.com>
References: <200409082126.49832.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269266AbUIIDSH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Sep 2004 23:18:07 -0400
In-Reply-To: <200409082126.49832.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> +{
> +	memset(sg, 0, sizeof(*sg));
> +
> +	sg->page = virt_to_page(buf);
> +	sg->offset = offset_in_page(buf);
> +	sg->length = buflen;
> +}
> +


Surely this should be more generic?

	Jeff


