From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Thu, 17 Dec 2009 01:34:34 -0500
Message-ID: <4B29D0FA.6060805@garzik.org>
References: <485882FE.1060409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46123 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763350AbZLQGel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:34:41 -0500
Received: by gxk3 with SMTP id 3so846333gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:34:41 -0800 (PST)
In-Reply-To: <485882FE.1060409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

On 06/17/2008 11:37 PM, Tejun Heo wrote:
> ahci 1.2 has an exciting! new feature called BIOS/OS handoff which
> basically is there to allow BIOS to keep tinkering with the controller
> even after OS starts executing.  I have no idea what this is useful
> for but it's there and we need to do it.
>
> This patch implements the handoff as FIXUP_HEADER as the controller
> needs to be claimed before the OS changes any configuration including
> IRQ routing.
>
> I'm yet to see any controller which actually requires this, so it's
> not for inclusion yet.  Maybe keep this in a separate branch?
>
> RFC, DON'T COMMIT
> ---
>   drivers/pci/quirks.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 109 insertions(+)

Looking through old emails...  did AMD ever confirm the usefulness of 
this patch?  Is it actually needed in the field?  I'm guessing the 
silence implies "No"...  :)

	Jeff



