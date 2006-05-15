From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Mon, 15 May 2006 16:19:40 +0100
Message-ID: <1147706380.26686.59.camel@localhost.localdomain>
References: <11473536871340-git-send-email-htejun@gmail.com>
	 <44665AAB.7000806@pobox.com> <44666D98.1000503@gmail.com>
	 <44668249.9000004@pobox.com> <446685D1.4030607@gmail.com>
	 <446688C8.6020001@pobox.com>
	 <1147700193.26686.7.camel@localhost.localdomain>
	 <44688991.8010407@gmail.com>  <44688F69.8030002@gmail.com>
	 <1147704657.26686.49.camel@localhost.localdomain>
	 <446896D0.7060309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57829 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964956AbWEOPIU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 11:08:20 -0400
In-Reply-To: <446896D0.7060309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

> little bit more complex (it has more moving parts) and it would be
> difficult to define/tune speed down or any other error handling (say,
> turning off NCQ) criteria.  But, I might be planning too much.

The log problem is that you can get 32 errors very fast (doesn't take
much with multiple outstanding commands) so you have to choose which
info to throw away - the history or the detail in the commands 


