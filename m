From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 06 Oct 2004 21:07:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <416496CC.4090105@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269356AbUJGBHg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 21:07:36 -0400
In-Reply-To: <20041006173656.A18221@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[libata & hot-unplug...]
>>Documentation/scsi/scsi_mid_low_api.txt for 2.6.x.  "good luck" for 
>>2.4.x, and libata needs to work on 2.4.x as well (at least for the time 
>>being)
> 
> 
> I've got phy-level hooks into interrupt handlers, all working
> nicely. I can't find any good examples of scsi_add/remove_device
> usage, and they do not like being called from an interrupt
> context. Can anyone lend some advice/examples of usage ?
> I've searched for guidelines on when/how to call these,
> above and beyond scsi_mid_low_api.txt, and come up empty
> handed.
> 
> If they need to be called from a helper-thread, I can do
> that - just looking for ground rules.

Correct, they must be called from process context.

	Jeff


