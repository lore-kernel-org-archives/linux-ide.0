From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH next] ide: fix PowerMac bootup oops
Date: Mon, 8 Jun 2009 23:28:02 +0200
Message-ID: <200906082328.02729.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0906082137120.22183@sister.anvils>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:44316 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbZFHVXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2009 17:23:11 -0400
In-Reply-To: <Pine.LNX.4.64.0906082137120.22183@sister.anvils>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Joao Ramos <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi Hugh,

On Monday 08 June 2009 22:45:28 Hugh Dickins wrote:
> PowerMac bootup with CONFIG_IDE=y oopses in ide_pio_cycle_time():
> because "ide: try to use PIO Mode 0 during probe if possible" causes
> pmac_ide_set_pio_mode() now to be called before drive->id has been set.

Good spotting, I overlooked this aspect of the change while testing it
with piix host driver..

> It does the right thing if id is not set, so long as we check for that.

After auditing some other host drivers I see that drive->id can be used
also directly in ->set_pio_mode methods..

Could you please instead try moving ->id allocation from probe_for_drive()
to ide_port_alloc_devices() (this would fix all such issues for good) and
verify that it also fixes the oops?

> Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> ---
> 
>  drivers/ide/ide-timings.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnext/drivers/ide/ide-timings.c	2009-04-08 18:25:55.000000000 +0100
> +++ linux/drivers/ide/ide-timings.c	2009-06-03 19:45:58.000000000 +0100
> @@ -84,7 +84,7 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
>  	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
>  	u16 cycle = 0;
>  
> -	if (id[ATA_ID_FIELD_VALID] & 2) {
> +	if (id && (id[ATA_ID_FIELD_VALID] & 2)) {
>  		if (ata_id_has_iordy(drive->id))
>  			cycle = id[ATA_ID_EIDE_PIO_IORDY];
>  		else
