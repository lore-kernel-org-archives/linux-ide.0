From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 6 Oct 2004 22:49:29 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041006224929.B18793@florence.linkmargin.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:59265 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S269672AbUJGDvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 23:51:18 -0400
Content-Disposition: inline
In-Reply-To: <4164B548.7030700@pobox.com>; from jgarzik@pobox.com on Wed, Oct 06, 2004 at 11:17:28PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Jeff Garzik wrote:
> 
> Well, the PDC2037x docs are under NDA, but the following information is 
> obviously required to implement hotplug, and therefore will obviously be 
> public once implemented:
> 
> bits of Promise hotplug register, PDC_SATA_PLUG_CSR:
> 
> 23:20	mask unplug irq (r/w)
> 19:16	mask plug irq (r/w)
> 11:8	SATAn is well connected (r/o)
> 7:4	SATAn is plugged again (rwc)
> 3:0	SATAn is disconnected (rwc)

There's a fine line between being terse and being cryptic,
as "man man" used to say .. :)

Is it also true that the standard SATA control, error and
status registers exist and function pretty much as the
spec says (at least for (1 << 16) in error and the
IPM & DET fields in Status) ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
