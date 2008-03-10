From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Mon, 10 Mar 2008 22:05:53 +0900
Message-ID: <47D53231.30107@gmail.com>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <47D0C9E6.8090301@gmail.com> <Pine.LNX.4.64.0803082345000.6749@axis700.grange> <47D3723B.3040700@gmail.com> <Pine.LNX.4.64.0803092221560.7385@axis700.grange> <47D485EC.1060103@gmail.com> <Pine.LNX.4.64.0803100821440.3948@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050508050404020705010406"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753822AbYCJNGV@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0803100821440.3948@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050508050404020705010406
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Guennadi Liakhovetski wrote:
> On Mon, 10 Mar 2008, Tejun Heo wrote:
> 
>>> Yctually it was 2.6.24 before, rebuilt 2.6.25-rc4, booted as above, it did 
>>> say:
>>>
>>> ata4: FORCE: PHY spd limit set to 1.5Gbps
>>>
>>> but hot-plugging the drive still took 50 seconds to recover.
>> How about cold plugging?
> 
> Same.

Does the attached patch help?

-- 
tejun

--------------050508050404020705010406
Content-Type: text/plain;
 name="debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug"

---
 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

Index: tree2/drivers/ata/ahci.c
===================================================================
--- tree2.orig/drivers/ata/ahci.c
+++ tree2/drivers/ata/ahci.c
@@ -397,6 +397,7 @@ static const struct ata_port_operations 
 static const struct ata_port_info ahci_port_info[] = {
 	/* board_ahci */
 	{
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= AHCI_LFLAG_COMMON,
 		.pio_mask	= 0x1f, /* pio0-4 */

--------------050508050404020705010406--
