From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Wed, 06 Oct 2004 23:59:32 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4164BF24.8090303@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com> <20041006224929.B18793@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45194 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269675AbUJGD7p
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Oct 2004 23:59:45 -0400
In-Reply-To: <20041006224929.B18793@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Andy Warner wrote:
> Is it also true that the standard SATA control, error and
> status registers exist and function pretty much as the
> spec says (at least for (1 << 16) in error and the
> IPM & DET fields in Status) ?

SStatus and SControl yes.  The SError register seems to be for error 
conditions only; no mention of PhyRdy being directly manipulated.

	Jeff


