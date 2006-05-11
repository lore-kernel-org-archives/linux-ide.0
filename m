From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Thu, 11 May 2006 16:46:25 +0100
Message-ID: <1147362385.26130.42.camel@localhost.localdomain>
References: <11473536881889-git-send-email-htejun@gmail.com>
	 <1147357322.26130.17.camel@localhost.localdomain>
	 <44634CB6.80804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23506 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030264AbWEKPe5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:34:57 -0400
In-Reply-To: <44634CB6.80804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Iau, 2006-05-11 at 23:39 +0900, Tejun Heo wrote:
> I'm not sure what you mean by synchronization.  But, freezing is indeed
>  for shutting the chip up.  If the port is frozen, EH doesn't touch
> active qcs nor tries to issue new command.  The port is thawed/used only
> after the port & device are put into known good state via successful
> reset.  Is this what you're talking about?

Sort of. I wanted to point out that this can occur

	IRQ is issued on chip

	->freeze
	returns

	->intr finally arrives and is serviced

Alan

