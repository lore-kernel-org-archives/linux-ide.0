From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/14] libata-hp-prep: implement ata_noop_check_status()
Date: Fri, 19 May 2006 11:12:17 -0400
Message-ID: <446DE051.6040101@pobox.com>
References: <11480445851733-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54438 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932339AbWESPM1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:12:27 -0400
In-Reply-To: <11480445851733-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> As with ops->tf_read, ops->check_status() and ops->check_altstatus()
> don't make sense for controllers without single TF image.  As
> ->check_status() and ->check_altstatus() are deeply integrated into
> libata core layer, implement ata_noop_check_status() as a temporary
> measure.  This function always returns ATA_DRDY without doing
> anything.

NAK, read previous message for rationale


