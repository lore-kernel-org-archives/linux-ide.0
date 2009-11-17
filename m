From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]AHCI: disable sntf cap for ich8
Date: Mon, 16 Nov 2009 22:19:34 -0500
Message-ID: <4B021646.5040102@garzik.org>
References: <20091116015605.GA21717@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50959 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbZKQDTb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 22:19:31 -0500
In-Reply-To: <20091116015605.GA21717@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, sean.hefty@intel.com, Arjan van de Ven <arjan@linux.intel.com>, Alan Cox <alan@linux.intel.com>

On 11/15/2009 08:56 PM, Shaohua Li wrote:
> I obseved there is a sata_async_notification() for every ahci interrupt. But the
> async notification does nothing (this is hard disk drive and no pmp). This cause
> cpu wastes some time on sntf register access.
>
> It appears ICH AHCI doesn't support SNotification register, but the controller
> reports it does. After quirking it, the async notification disappears.

Patch applied.


> PS. it appears all ICH don't support SNotification register from ICH manual, don't
> know if we need quirk all ICH. I don't have machines with all kinds of ICH.

You work for Intel -- you or somebody needs to research and figure this 
out...  This is an Intel vendor issue that only Intel can definitively 
resolve.

	Jeff


