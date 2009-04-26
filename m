From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/3] mg_disk: fix dependency on libata
Date: Sun, 26 Apr 2009 00:11:46 -0400
Message-ID: <49F3DF02.5030909@garzik.org>
References: <200904251509.11912.bzolnier@gmail.com> <49F3D994.7020304@kernel.org> <49F3DCD5.2070909@garzik.org> <49F3DE55.8070302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35729 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbZDZELv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Apr 2009 00:11:51 -0400
In-Reply-To: <49F3DE55.8070302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, unsik Kim <donari75@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Actually...  NVMHCI[1] uses the same style of id string extraction, even
>> though its command set is wholly new and unrelated to ATA.  I copied
>> into drivers/block/nvmhci.c[2] id_string, id_c_string and another
>> useful, generic routine: ata_wait_register.
>>
>> So, once nvmhci goes upstream, that will be a third copy...  nvmhci
>> still has rough edges, but it's mainly waiting on hardware "it works"
>> verification at this point.
> 
> For two copies, copying seems to be the right way to go.  For many
> more copies, making a library function is.  Three is a difficult
> number.  Maybe just make these inline functions for now?

<shrug>  I'm just adding some data, I don't have a good suggestion :)

The functions do not change very often, so three copies is not 
necessarily the end of the world.

	Jeff



