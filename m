From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] mg_disk: fix dependency on libata
Date: Sun, 26 Apr 2009 13:08:53 +0900
Message-ID: <49F3DE55.8070302@kernel.org>
References: <200904251509.11912.bzolnier@gmail.com> <49F3D994.7020304@kernel.org> <49F3DCD5.2070909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48295 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZDZEI6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Apr 2009 00:08:58 -0400
In-Reply-To: <49F3DCD5.2070909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, unsik Kim <donari75@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Actually...  NVMHCI[1] uses the same style of id string extraction, even
> though its command set is wholly new and unrelated to ATA.  I copied
> into drivers/block/nvmhci.c[2] id_string, id_c_string and another
> useful, generic routine: ata_wait_register.
>
> So, once nvmhci goes upstream, that will be a third copy...  nvmhci
> still has rough edges, but it's mainly waiting on hardware "it works"
> verification at this point.

For two copies, copying seems to be the right way to go.  For many
more copies, making a library function is.  Three is a difficult
number.  Maybe just make these inline functions for now?

Thanks.

-- 
tejun
