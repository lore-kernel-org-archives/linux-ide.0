From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_via + VT8237 RAID 0 array of 2 s-ata drives
Date: Fri, 11 Mar 2005 23:24:04 -0500
Message-ID: <42326EE4.2080102@pobox.com>
References: <29362.1110450136@www25.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57027 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261830AbVCLEYh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Mar 2005 23:24:37 -0500
In-Reply-To: <29362.1110450136@www25.gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chris.bu@gmx.net
Cc: linux-ide@vger.kernel.org

chris.bu@gmx.net wrote:
> Hi Jeff,
> 
> a quick question about libata + sata_via V1.10 as included in the most
> recent kernel 2.6.11.2:
> 
> I have a MSI KT6V (MS-7021) mainboard with VIA VT-8237 Southbridge and want
> to connect two S-ATA hard disk drives. Both drives should run in a RAID 0
> array, which is to be configured through the S-ATA RAID BIOS on the main
> board.
> 
> Is it possible that the sata_via driver recognizes the existence of the
> array and treats it as one drive under LINUX? As far as I've learned, the
> VT-8237 is not a real hardware RAID solution and needs some software support
> from the OS, too. Again, is it possible to do this, or does the driver only
> support seperate s-ata channels, no matter what is configured in the S-ATA
> RAID BIOS? If the BIOS configured RAID volumes are not supported at all (any
> plans for the near future?) what would you recommend to do instead to
> provide fast and efficient RAID 0 striping for both s-ata drives (to double
> the r/w data rate).
> 
> Are there any other limitations with the current sata_via driver concerning
> VT8237 with two S-ATA drives?

The sata_via driver will always just recognize each disk, not the RAID.

If you want to use the BIOS RAID, you have to use the "device mapper" 
with the "dmraid" utility.  But its recommended that you use the Linux 
"md" RAID.  Under Linux, the BIOS RAID is just a poorly-supported format 
that duplicates the better-tested Linux md raid.

http://linux.yyz.us/sata/faq-sata-raid.html#dmraid

	Jeff


