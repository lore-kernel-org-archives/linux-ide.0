From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET] libata: clean up scsi_host_templates and ata_port_operations,
 take #3
Date: Mon, 17 Mar 2008 08:28:34 -0400
Message-ID: <47DE63F2.2030404@garzik.org>
References: <12052371651181-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47682 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYCQM2k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:28:40 -0400
In-Reply-To: <12052371651181-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, florian@openwrt.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of cleanup-sht-ops patchset.  As the name
> suggests it reorganizes and cleans up scsi_host_template and
> ata_port_operation tables used by libata core and low level drivers.
> 
> Please read the head message of the first take[F] for more info.
> Changes from the last take[L] are...
> 
> * Updated to fit the current upstream-fixes.
> 
> * pata_scc thaw change applied.
> 
> * pata_rb500_cf newly converted.
> 
> * Updated to accomodate drivers w/o any reset method available.
> 
> The following drivers need specific platform to build, so they need
> verification.  If you work on one of the following drivers, please
> verify that the driver builds and works fine.  It would be best if you
> can verify that the sht and ops don't change by the fifth and sixth
> patches using the method I'll write in another message.
> 
> * pata_at32
> * pata_bf54x
> * pata_icside
> * pata_ixp4xx_cf
> * pata_mpc52xx
> * pata_scc
> * sata_fsl
> * pata_rb500_cf
> 
> This patchset is on top of
> 
>   upstream-fixes (3db691daa4f6c4b899e144ea54a65738402c94e3)
> + [1] prefer-hardreset patchset, take#3 (the subject line is wrong)
> + [2] devres-implement-pcim_iomap_regions_request_all
> + [3] ahci-request-all-PCI-BARs
> + [4] libata-PCI-device-should-be-powered-up-before-being-accessed
> 
> This patchset is available as GIT branch.
> 
> http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops
> 
> The verification method is the same as before[B].
> 
> Thanks.

ACK patchset; based on recent comments I will await one final resend -- 
or simply do a 'git pull'?


