From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Wed, 29 Mar 2006 12:59:39 +0100
Message-ID: <1143633580.17522.39.camel@localhost.localdomain>
References: <11431815313764-git-send-email-htejun@gmail.com>
	 <44240A67.7030001@pobox.com>
	 <1143215493.18986.11.camel@localhost.localdomain>
	 <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com>
	 <20060325054008.GG5288@htj.dyndns.org>
	 <20060325061215.GH5288@htj.dyndns.org>
	 <1143330895.28134.14.camel@localhost.localdomain>
	 <20060325235732.GA23222@htj.dyndns.org>
	 <1143458257.4970.18.camel@localhost.localdomain>
	 <20060329065814.GB11047@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10128 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750778AbWC2Lww (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Mar 2006 06:52:52 -0500
In-Reply-To: <20060329065814.GB11047@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mer, 2006-03-29 at 15:58 +0900, Tejun Heo wrote:
> Hmm... how about using ata_dev_enable() || ata_dev_disable() for
> ata_dev_pair() such that any existent device returned and make the
> user responsible for ata_dev_enable() testing if it wants only enabled
> device?

That seems sensible to me. Agreed

