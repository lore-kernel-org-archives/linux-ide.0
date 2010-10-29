From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Fri, 29 Oct 2010 01:49:14 -0400
Message-ID: <4CCA605A.9030000@garzik.org>
References: <1283027290.2721.37.camel@myfedorahat> <4C7BAA42.2050809@kernel.org> <AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com> <AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com> <AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com> <AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com> <AANLkTikqxmzQozCOo+7XDSWE4tTniSnYbomEgqA4aB-2@mail.gmail.com> <4C7F77C4.6040404@kernel.org> <AANLkTi=_fmtNjj=ZeSyuMtQg+YBJ3=gHAkeurJhDZmmh@mail.gmail.com> <4C80BA34.7090400@kernel.org> <AANLkTikBiCwCmCp-RgWBDb6nwkifK2CuiUXVSXYpMaCK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44856 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab0J2FtX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2010 01:49:23 -0400
Received: by qyk12 with SMTP id 12so6321337qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 28 Oct 2010 22:49:22 -0700 (PDT)
In-Reply-To: <AANLkTikBiCwCmCp-RgWBDb6nwkifK2CuiUXVSXYpMaCK@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Siddhartha Jain <siddhartha@siddharthajain.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 10/27/2010 10:11 PM, Siddhartha Jain wrote:
> Just wanted to checkin and report that so far I applied the patch to
> two revisions of 2.6.34 from fedora 13 x64 and have had no issues. My
> macbook pro sleeps well and wakes up as normal everytime.
>
> Thanks again to all involved. When should I expect it to be updated in
> the main trunk?


It's in the main trunk:

commit e2f3d75fc0e4a0d03c61872bad39ffa2e74a04ff
Author: Tejun Heo <htejun@gmail.com>
Date:   Tue Sep 7 14:05:31 2010 +0200

     libata: skip EH autopsy and recovery during suspend

