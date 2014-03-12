From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Bug (?) in ata (ahci) driver can lead to panic with ZPODD and
 unbind
Date: Wed, 12 Mar 2014 13:45:00 +0000
Message-ID: <20140312134500.0751752e@alan.etchedpixels.co.uk>
References: <235852D532FB204FB039DAF645E587C7B506036AFA@dc-ex1.power.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33324 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbaCLNpW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 09:45:22 -0400
In-Reply-To: <235852D532FB204FB039DAF645E587C7B506036AFA@dc-ex1.power.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Thomas <Joe.Thomas@dothill.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

>                 Is this really a bug? i.e. 'unbind' should cause zpodd_exit() (or ata_scsi_remove_dev()) to be called...
> or
>                 Are we missing a step before the 'unbind' where we need to cause the attached devices to be removed first (thus ensuring ata_scsi_remove_dev() be called)?

unbind is equivalent to a hot unplug of the controller so yes this
shouldn't crash in the ZPODD case (not that in the real world you are
likely to have a hotpluggable ZPODD controller).

Alan
