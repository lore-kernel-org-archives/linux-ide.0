From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No equivalent for ide-scsi available with the new PATA drivers?
Date: Mon, 23 Jul 2007 17:52:39 +0100
Message-ID: <20070723175239.54b721f1@the-village.bc.nu>
References: <46A4D91C.3090509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47522 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760834AbXGWQp4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 12:45:56 -0400
In-Reply-To: <46A4D91C.3090509@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 23 Jul 2007 12:36:44 -0400
Chuck Ebbert <cebbert@redhat.com> wrote:

> People with IDE tape drives are complaining there's no ide-scsi
> driver available anymore with the new PATA layer. Is anyone
> working on one?

It would make no sense. The libata layer is already using the SCSI
midlayer so compliant devices should already appear with the st driver.

We might need some tape detect logic, but I don't have any tape devices
so its up to someone with a tape drive handy to help out...

Alan
