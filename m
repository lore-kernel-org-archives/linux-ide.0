From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Fri, 8 Oct 2004 10:56:08 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041008105608.A24640@florence.linkmargin.com>
References: <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com> <4164BDD6.6000404@pobox.com> <20041007171457.B21662@florence.linkmargin.com> <4165C263.4080102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:15316 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S270053AbUJHP6E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Oct 2004 11:58:04 -0400
Content-Disposition: inline
In-Reply-To: <4165C263.4080102@pobox.com>; from jgarzik@pobox.com on Thu, Oct 07, 2004 at 06:25:39PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Jeff Garzik wrote:
> [...]
> These args are wrong.  Consider master/slave configurations.

Can I check that I've got these things right:

 o *ap is a per sata-HBA-port structure ?
 o each port can have 0, 1 or 2 drives attached ?
   Though 0 & 1 are the only practical values
   for current SATA hardware ?
   Does this become 0 .. n when port expanders
   enter into the picture ?
 o struct scsi_device is a per drive structure ?

So *ap may need to support an aribrary list of devs,
just like struct Scsi_host does today ?

Since I bring up port expanders, will we still get hot-plug
notification from the hardware when a downstream drive changes
state ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
