From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: libata-dev.git rebased
Date: Mon, 4 Dec 2006 18:40:24 -0700
Message-ID: <e9c3a7c20612041740s53c4dcc6p630e1fda4298c553@mail.gmail.com>
References: <457102DF.5020407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:61254 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968003AbWLEBk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 20:40:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3186597uga
        for <linux-ide@vger.kernel.org>; Mon, 04 Dec 2006 17:40:24 -0800 (PST)
In-Reply-To: <457102DF.5020407@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, daniel.e.wolstenholme@intel.com

On 12/1/06, Jeff Garzik <jeff@garzik.org> wrote:
> I just rebased all branches of libata-dev.git, and there was a bit of
> fallout:
>
> 1) Dan, I'll have to ask you to resend your sata_vsc MSI patch yet
> again, this time against 2.6.19.  Since it was against
> drivers/scsi/sata_vsc.c, that caused some cross-directory-move related
> problems.
I've copied Dan Wolstenholme.

Regards,
Dan Williams
