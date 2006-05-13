From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 16/22] libata: implement new SCR handling and port on/offline
 functions
Date: Sat, 13 May 2006 17:43:48 -0400
Message-ID: <44665314.4040805@pobox.com>
References: <1147348791300-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53894 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932344AbWEMVn4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 17:43:56 -0400
In-Reply-To: <1147348791300-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_scr_{valid|read|write|write_flush}() and
> ata_port_{online|offline}().  These functions replace
> scr_{read|write}() and sata_dev_present().
> 
> Major difference between between the new SCR functions and the old
> ones is that the new ones have a way to signal error to the caller.
> This makes handling SCR-available and SCR-unavailable cases in the
> same path easier.  Also, it eases later PM implementation where SCR
> access can fail due to various reasons.
> 
> ata_port_{online|offline}() functions return 1 only when they are
> affirmitive of the condition.  e.g.  if SCR is unaccessible or
> presence cannot be determined for other reasons, these functions
> return 0.  So, ata_port_online() != !ata_port_offline().  This
> distinction is useful in many exception handling cases.

If its SATA-specific, it should have a "sata_" not "ata_" prefix.

Once a search-n-replace is applied, ACK.

	Jeff


