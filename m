From: Tejun Heo <tj@kernel.org>
Subject: Re: MSI broken in libata?
Date: Sat, 09 Jan 2010 18:11:05 +0900
Message-ID: <4B484829.6060405@kernel.org>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42682 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440Ab0AIXQb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jan 2010 18:16:31 -0500
In-Reply-To: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 12/25/2009 06:22 PM, Torsten Kaiser wrote:
> As reported in http://lkml.org/lkml/2009/12/19/82 the new MSI support
> for sata_sil24 does not work for me.
> This is still the same with 2.6.33-rc2.
> 
> Why I think, this might be a problem within libata:
>  * other drivers can use MSI successful on my system (tg3, radeon, hda-intel)
>  * happens both in sata_sil24 and sata_nv
>  * the count in /proc/interrupts increases for the MSIs assigned to
> sata_sil24/sata_nv, so interrupt delivery seems to work
>  * only writing seems to fail

How does it fail?  Timeouts?  Also, ahci enables MSI by default if
available and works fine on many configurations so I don't think
anything in libata core layer is broken regarding MSI (there just
isn't anything which can break).

Thanks.

-- 
tejun
