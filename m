From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 06 Oct 2004 23:17:28 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4164B548.7030700@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269664AbUJGDRl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 23:17:41 -0400
In-Reply-To: <20041006214746.A18793@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>


Well, the PDC2037x docs are under NDA, but the following information is 
obviously required to implement hotplug, and therefore will obviously be 
public once implemented:

bits of Promise hotplug register, PDC_SATA_PLUG_CSR:

23:20	mask unplug irq (r/w)
19:16	mask plug irq (r/w)
11:8	SATAn is well connected (r/o)
7:4	SATAn is plugged again (rwc)
3:0	SATAn is disconnected (rwc)


