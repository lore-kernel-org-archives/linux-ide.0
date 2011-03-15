From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: add another PCI ID for marvell
Date: Tue, 15 Mar 2011 02:45:23 -0400
Message-ID: <4D7F0B03.4070003@garzik.org>
References: <4CF3BF4A.4080009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54052 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab1COGp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 02:45:27 -0400
Received: by vws1 with SMTP id 1so287681vws.19
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 23:45:27 -0700 (PDT)
In-Reply-To: <4CF3BF4A.4080009@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Alessandro Tagliapietra <tagliapietra.alessandro@gmail.com>

On 11/29/2010 09:57 AM, Tejun Heo wrote:
> 1b4b:91a3 seems to be another PCI ID for marvell ahci.  Add it.
> Reported and tested in the following thread.
>
>   http://thread.gmane.org/gmane.linux.kernel/1068354
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Borislav Petkov<bp@alien8.de>
> Reported-by: Alessandro Tagliapietra<tagliapietra.alessandro@gmail.com>
> ---
>   drivers/ata/ahci.c |    2 ++
>   1 file changed, 2 insertions(+)

Found this one in the dustbin while searching around...  still needed, 
apparently.  Resurrected and applied.

