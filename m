From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Fri, 21 Sep 2007 07:54:07 +0200
Message-ID: <46F35C7F.20400@dunaweb.hu>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020408010809010708060207"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux.dunaweb.hu ([62.77.196.1]:52300 "EHLO linux.dunaweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbXIUFye (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 01:54:34 -0400
In-Reply-To: <46F2F6E5.3010406@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, kluo@nvidia.com, pchen@nvidia.com, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020408010809010708060207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Jeff Garzik =EDrta:
> akpm@linux-foundation.org wrote:
>> From: Kuan Luo <kluo@nvidia.com>
>>
>> Add the Software NCQ support to sata_nv.c for MCP51/MCP55/MCP61 SATA
>> controller.  NCQ function is disable by default, you can enable it wit=
h
>> 'swncq=3D1'.  NCQ will be turned off if the drive is Maxtor on MCP51 o=
r=20
>> MCP55
>> rev 0xa2 platform.
>>
>> [akpm@linux-foundation.org: build fix]
>> Signed-off-by: Kuan Luo <kluo@nvidia.com>
>> Signed-off-by: Peer Chen <pchen@nvidia.com>
>> Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/ata/sata_nv.c |  860 +++++++++++++++++++++++++++++++++++++++-=

>>  1 files changed, 851 insertions(+), 9 deletions(-)
>
> I finally gave this a thorough review.
>
> Overall, good work.  The state transitions all seem solid.  I made=20
> several minor changes and cleanups, and checked it into the 'nv-swncq' =

> branch of=20
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> Two hurdles before I'm ready to push upstream:
>
> * someone please verify my minor changes did not break anything; I=20
> don't have real hardware

After reading the diff between the original and your cleaned up version
it seems both the change from 4 individual flags to a single integer and =
the
nv_swncq_bmdma_stop() -> __ata_bmdma_stop() transition are obviously=20
correct.
I attached a small cleanup patch which may make one check a bit more=20
readable.

However, can you explain this chunk below? Why isn't it needed?

@@ -615,7 +622,6 @@ static const struct ata_port_info nv_por
        {
                .sht            =3D &nv_swncq_sht,
                .flags          =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
-               .link_flags     =3D ATA_LFLAG_HRST_TO_RESUME,
                .pio_mask       =3D NV_PIO_MASK,
                .mwdma_mask     =3D NV_MWDMA_MASK,
                .udma_mask      =3D NV_UDMA_MASK,


> * the pp->lock appears unnecessary at best, wrong at worst.  needs=20
> additional analysis.

I will test the code without this locking. Can you give me a better idea
besides beating both my disks with separate requests? Say, bonnie++
and simultaneous hdparm -tT on both?

Best regards,
Zolt=E1n B=F6sz=F6rm=E9nyi


--------------020408010809010708060207
Content-Type: text/x-patch;
 name="swncq-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swncq-cleanup.patch"

--- sata_nv.c.committed	2007-09-21 06:49:23.000000000 +0200
+++ sata_nv.c.cleanup-swncq	2007-09-21 07:47:24.000000000 +0200
@@ -2290,8 +2290,7 @@
 		 */
 		pp->dhfis_bits |= (0x1 << pp->last_issue_tag);
 		pp->ncq_flags |= ncq_saw_d2h;
-		if ((pp->ncq_flags & ncq_saw_sdb) ||
-		    (pp->ncq_flags & ncq_saw_backout)) {
+		if (pp->ncq_flags & (ncq_saw_sdb || ncq_saw_backout)) {
 			ata_ehi_push_desc(ehi, "illegal fis transaction");
 			ehi->err_mask |= AC_ERR_HSM;
 			ehi->action |= ATA_EH_HARDRESET;


--------------020408010809010708060207--
