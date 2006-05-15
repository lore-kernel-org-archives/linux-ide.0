From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 14:36:33 +0100
Message-ID: <1147700193.26686.7.camel@localhost.localdomain>
References: <11473536871340-git-send-email-htejun@gmail.com>
	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>
	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>
	 <446688C8.6020001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60308 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964843AbWEON0Y
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:26:24 -0400
In-Reply-To: <446688C8.6020001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Sad, 2006-05-13 at 21:32 -0400, Jeff Garzik wrote:
> I would just declare that all erings have 32 entries, and revisit the 
> issue if/when pain appears.  Hardcode 32, and make things easy.

Do we even need the ering. If you classify the error when it occurs it
seems all you need is a couple of 32bit words and to set bits and
shift ?

