From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Sat, 13 May 2006 18:16:11 -0400
Message-ID: <44665AAB.7000806@pobox.com>
References: <11473536871340-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39303 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932364AbWEMWQS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:16:18 -0400
In-Reply-To: <11473536871340-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +struct ata_ering {
> +	int			cursor;
> +	int			size;
> +	struct ata_ering_entry	ring[];
> +};
> +
> +#define DEFINE_ATA_ERING(name, size)	\
> +	struct ata_ering	name;	\
> +	struct ata_ering_entry	name_entries[size];

ACK, but this is creeping dangerously close to C abuse :)

This sort of code will confuse debuggers and source checkers.

	Jeff


