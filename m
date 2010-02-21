From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Sun, 21 Feb 2010 10:01:27 +0900
Message-ID: <4B8085E7.5000501@kernel.org>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu> 	<d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com> 	<4B5666B4.6000804@kernel.org> <51f3faa71001191859l3c323a8ev6b7c0cced2c59e92@mail.gmail.com> 	<d2d378041001220611ieb9d715of8d727f8f93ca9f@mail.gmail.com> 	<4B5A70E5.6050106@kernel.org> <d2d378041001231339o1d1b0984y2b2a85b717987d93@mail.gmail.com> 	<4B67A149.10406@kernel.org> <d2d378041002170814l1da6b022p4902128c604fc84b@mail.gmail.com> 	<4B7C9CEE.4080902@kernel.org> <d2d378041002201111g7af41a3dpdb2fa300a65d56bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070302020000010506060109"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2d378041002201111g7af41a3dpdb2fa300a65d56bf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?Q2VuZ2l6IEfDvG5heQ==?= <cgunay@EMORY.EDU>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070302020000010506060109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/21/2010 04:11 AM, Cengiz Günay wrote:
>> Does the attached patch make any difference?
> 
> Not that I can tell. I still get an infinite loop of ata4 errors. I
> attached a full dmesg output with the patch. Note that I have both the
> patches disable-clear-ua and drain-from-atapi-pio-bytes applied at the
> same time.

Hmmm... So, DRQ gets cleared?  That's strange.  When then the 18 extra
bytes happen?  Can you please try this one?

-- 
tejun

--------------070302020000010506060109
Content-Type: text/x-patch;
 name="swncq-polling-pio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="swncq-polling-pio.patch"

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0c82d33..ae63b0b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -585,7 +585,7 @@ static const struct ata_port_info nv_port_info[] = {
 	/* SWNCQ */
 	{
 		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_NCQ,
+				  ATA_FLAG_NCQ | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
 		.udma_mask	= NV_UDMA_MASK,

--------------070302020000010506060109--
