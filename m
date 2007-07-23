From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: No equivalent for ide-scsi available with the new PATA drivers?
Date: Mon, 23 Jul 2007 11:48:14 -0500
Message-ID: <1185209294.3417.15.camel@localhost.localdomain>
References: <46A4D91C.3090509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:36863 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761776AbXGWQsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 12:48:16 -0400
In-Reply-To: <46A4D91C.3090509@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 2007-07-23 at 12:36 -0400, Chuck Ebbert wrote:
> People with IDE tape drives are complaining there's no ide-scsi
> driver available anymore with the new PATA layer. Is anyone
> working on one?

You mean libata-pata?  The SCSI tape driver, st (or the onstream osst
driver), should just attach natively, shouldn't it ... or is there
something missing in the sat layer?

James


