From: Hubert Bailey <hbailey@marvell.com>
Subject: RE: Added advisement against marvell ATA controller in the ATA wiki
 page
Date: Sat, 11 Jun 2011 11:27:27 -0700
Message-ID: <B9B10C29375C5B40A2D240808654F60E5EE470A582@SC-VEXCH2.marvell.com>
References: <20110610070030.GB15235@htj.dyndns.org>
 <4DF20BDC.5090109@pobox.com> <4DF240B4.1030901@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53790 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab1FKS1g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Jun 2011 14:27:36 -0400
In-Reply-To: <4DF240B4.1030901@seoss.co.uk>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tim Small' <tim@seoss.co.uk>, Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Saeed Bishara <saeed@marvell.com>

Tim,

The SATA_mv supported devices stopped at SATA 3Gb and either PCI-e G1 or PCI/PCI-X.

The mvSATA supported devices were either SATA 3Gb or SAS/SATA 6Gb.  SATA 3Gb devices were PCI-e G1.  The newer SAS/SATA 6Gb are PCI-e G2.  There are x1, x4, and x8 PCI-e lane widths available.

The newer 88SE91xx parts are AHCI compliant, so no need for 3rd party driver.  Currently these parts are PCI-e G2 x1.  There is a newer version that is sampling that is PCI-e G2 x2.

Hope this helps clears this up.
 

-----Original Message-----
From: Tim Small [mailto:tim@seoss.co.uk] 
Sent: Friday, June 10, 2011 11:05 AM
To: Mark Lord
Cc: Tejun Heo; linux-ide@vger.kernel.org; Jeff Garzik; Saeed Bishara; Hubert Bailey
Subject: Re: Added advisement against marvell ATA controller in the ATA wiki page

On 10/06/11 13:19, Mark Lord wrote:
> It's only the Marvell AHCI controllers that are causing grief.
> The ones supported by sata_mv are among the very best performing SATA 
> controllers that work with Linux.
>   


It looks to me like Marvell have stopped further development on sata_mv interface cards - does anyone know if it's the case?  I couldn't find any SATA3 6GBps, or PCI-e 2.0 chips, so I assumed that Marvell has gone for ahci or mvsas only for it's current/future product ranges?

That's why I chose the 88SE9123 - as they seemed to offer reasonable performance/features etc. (albeit single lane PCI express only).

Cheers,

Tim.


--
South East Open Source Solutions Limited Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309


-----
No virus found in this message.
Checked by AVG - www.avg.com
Version: 10.0.1382 / Virus Database: 1513/3695 - Release Date: 06/11/11