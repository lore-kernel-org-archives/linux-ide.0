From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Basics of per controller fixup
Date: Fri, 5 Nov 2004 23:00:17 +0100
Message-ID: <200411052300.17155.bzolnier@elka.pw.edu.pl>
References: <1099672171.5630.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35021 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261180AbUKEV5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 16:57:38 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:40582 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S52975AbUKEV5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 22:57:37 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:63365 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S60274AbUKEVzp (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 5 Nov 2004 22:55:45 +0100
In-Reply-To: <1099672171.5630.42.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Friday 05 November 2004 17:29, Alan Cox wrote:
> We add probe_hwif_init_with_fixup (seperate naming as requested by
> Bartlomiej). This runs a fixup on present interfaces before attaching
> the drives. The existing API is maintained as a call to the new API.
> 
> The sometimes troublesome undecoded slave detector is moved to its own
> function and exported so that ide-cs and the upcoming delkin_cb can both
> use it (along with any arch specific cf/pcmcia drivers I don't know
> about).

* does delkin_cb need it?
* shouldn't this fixup be applied for CF devices?
* arch specific drivers shouldn't need this fixup
  (they can claim no slave decoding to IDE layer)

> The non-relevant checks for this scenario (M00000 and ITE RAID) are
> removed.

* this of course doesn't apply to -bk (not a problem though)
* also ITE RAID check is not present in vanilla tree and this patch

> diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/ide-probe.c linux-2.6.10rc1/drivers/ide/ide-probe.c
> --- linux.vanilla-2.6.10rc1/drivers/ide/ide-probe.c	2004-11-05 15:42:15.000000000 +0000
> +++ linux-2.6.10rc1/drivers/ide/ide-probe.c	2004-11-05 16:26:39.000000000 +0000
> @@ -652,6 +652,39 @@
>  	return rc;
>  }
>  
> +/**
> + *	ide_undecoded_slave	-	look for bad CF adapters
> + *	@hwif: interface
> + *
> + *	Analyse the drives on the interface and attempt to decide if we
> + *	have the same drive viewed twice. This occurs with crap CF adapters
> + *	and PCMCIA sometimes.
> + */
> +
> +void ide_undecoded_slave(ide_hwif_t *hwif) 
> +{
> +	ide_drive_t *drive0 = &hwif->drives[0];
> +	ide_drive_t *drive1 = &hwif->drives[1];
> +	
> +	if (drive0->present == 0 || drive1->present == 0)
> +			return;
> +		
> +	/* If the models don't match they are not the same product */	
> +	if (strcmp(drive0->id->model, drive1->id->model))
> +		return;
> +	/* Serial numbers do not match */
> +	if(strncmp(drive0->id->serial_no, drive1->id->serial_no, 20))
> +		return;
> +	/* No serial number, thankfully very rare for CF */
> +	if (drive0->id->serial_no[0] == 0)
> +		return;
> +	/* Appears to be an IDE flash adapter with decode bugs */
> +	printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
> +	drive1->present = 0;
> +}
> +
> +EXPORT_SYMBOL(ide_undecoded_slave);
> +
>  /*
>   * This routine only knows how to look for drive units 0 and 1
>   * on an interface, so any setting of MAX_DRIVES > 2 won't work here.
> @@ -723,18 +756,6 @@
>  		ide_drive_t *drive = &hwif->drives[unit];
>  		drive->dn = (hwif->channel ? 2 : 0) + unit;
>  		(void) probe_for_drive(drive);
> -		if (drive->present && hwif->present && unit == 1) {
> -			if (strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
> -			    /* Don't do this for noprobe or non ATA */
> -			    strcmp(drive->id->model, "UNKNOWN") &&
> -			    /* And beware of confused Maxtor drives that go "M0000000000"
> -			      "The SN# is garbage in the ID block..." [Eric] */
> -			    strncmp(drive->id->serial_no, "M0000000000000000000", 20) &&
> -			    strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0) {
> -				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
> -				drive->present = 0;
> -			}
> -		}
>  		if (drive->present && !hwif->present) {
>  			hwif->present = 1;
>  			if (hwif->chipset != ide_4drives ||
> @@ -808,13 +829,18 @@
>  }
>  
>  static int hwif_init(ide_hwif_t *hwif);
> -int probe_hwif_init (ide_hwif_t *hwif)
> +
> +int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
>  {
>  	probe_hwif(hwif);
>  	hwif_init(hwif);
>  
>  	if (hwif->present) {
>  		u16 unit = 0;
> +
> +		if(fixup != NULL)
> +			fixup(hwif);
> +			
>  		for (unit = 0; unit < MAX_DRIVES; ++unit) {
>  			ide_drive_t *drive = &hwif->drives[unit];
>  			/* For now don't attach absent drives, we may
> @@ -828,6 +854,13 @@
>  	return 0;
>  }
>  
> +EXPORT_SYMBOL(probe_hwif_init_with_fixup);
> +
> +int probe_hwif_init(ide_hwif_t *hwif)
> +{
> +	return probe_hwif_init_with_fixup(hwif, NULL);
> +}
> +
>  EXPORT_SYMBOL(probe_hwif_init);
>  
>  #if MAX_HWIFS > 1
> 
> 
