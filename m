From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 6 Oct 2004 17:36:56 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041006173656.A18221@florence.linkmargin.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:33190 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S269508AbUJFWim (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 18:38:42 -0400
Content-Disposition: inline
In-Reply-To: <4161BB01.5080607@pobox.com>; from jgarzik@pobox.com on Mon, Oct 04, 2004 at 05:05:05PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [libata & hot-unplug...]
> Documentation/scsi/scsi_mid_low_api.txt for 2.6.x.  "good luck" for 
> 2.4.x, and libata needs to work on 2.4.x as well (at least for the time 
> being)

I've got phy-level hooks into interrupt handlers, all working
nicely. I can't find any good examples of scsi_add/remove_device
usage, and they do not like being called from an interrupt
context. Can anyone lend some advice/examples of usage ?
I've searched for guidelines on when/how to call these,
above and beyond scsi_mid_low_api.txt, and come up empty
handed.

If they need to be called from a helper-thread, I can do
that - just looking for ground rules.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
