From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/13] ata_piix: convert ata_piix to new probing
	mechanism
Date: Thu, 11 May 2006 16:58:24 +0100
Message-ID: <1147363104.26130.49.camel@localhost.localdomain>
References: <11473615273443-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17296 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030288AbWEKPqc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:46:32 -0400
In-Reply-To: <11473615273443-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Gwe, 2006-05-12 at 00:32 +0900, Tejun Heo wrote:
> Convert ata_piix to new probing mechanism.  Automatic hotplug is not
> supported due to hardware limitation (no PHY event interrupt), but
> warm plugging works.

True for the SATA ports but don't try it on the PATA ones. The PATA side
requires the right buffers are present, and also in some situations that
IORDY is not in use before the unplug.

Alan

