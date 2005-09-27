From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC 2.6.13.1 1/1] Cleanup for CS5535 IDE driver
Date: Tue, 27 Sep 2005 14:11:21 +0200
Message-ID: <58cb370e05092705114bf4504d@mail.gmail.com>
References: <200509230301.j8N31n7W019129@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.203]:13526 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932173AbVI0MLZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Sep 2005 08:11:25 -0400
Received: by nproxy.gmail.com with SMTP id x37so413763nfc
        for <linux-ide@vger.kernel.org>; Tue, 27 Sep 2005 05:11:21 -0700 (PDT)
In-Reply-To: <200509230301.j8N31n7W019129@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "jayakumar.ide@gmail.com" <jayakumar.ide@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9/23/05, jayakumar.ide@gmail.com <jayakumar.ide@gmail.com> wrote:
> Hi Bartlomiej, IDE folk,

Hi,

> Appended is my patch attempting to fix up the cs5535 driver as per
> your suggestions from the thread:
>
> http://marc.theaimsgroup.com/?l=linux-ide&m=112533052120330&w=2
>
> I listed what I did with respect to that todo list below:
>
> > * cs5535_tuneproc() needs to be fixed to not abuse ->tuneproc interface
> >   (which is exported to user-space), all DMA tuning should be done through
> >   ->speedproc interface only
> Done.
>
> > * cs5535_set_drive() needs to use ide_rate_filter() to limit values passed
> >   from the user-space
> Done. btw, thanks for the eighty93 explaination yesterday. I hope I
> got that part right in this.

Yep. :)

> > * cs5535_set_drive() needs to set drive's speed unconditionally otherwise
> >   drive may not be setup correctly after resume
> Done.
>
> > * cs5535_set_drive() shouldn't change drive->current_speed
> Done.
>
> > * cable detection needs to be in separate function (for hotplug - later)
> I'm not sure I followed. By cable detection, I think you are pointing
> to init_hwif_cs5535:
>
>         /* if a 80 wire cable was detected */
>         pci_read_config_byte(hwif->pci_dev, CS5535_CABLE_DETECT, &bit);
>         hwif->udma_four = bit & 1;
>
> I think we can leave this as is because the cs5535 is a SOC companion that
> doesn't have hotplug capability. Is that okay?

Even if chipset itself doesn't have hotplug capability please
abstract cable detection code to match future IDE core changes.

> > * driver lacks device side cable detection [ see eighty_ninty_three() ]
> I put eighty93 into ratemask which gets called from set_drive.
>
> > * driver needs to check for blacklisted DMA devices [ see ide_use_dma() ]
> Done. I added it in dma_check to match what the other drivers do.
>
> > * init_hwif_cs5535() should be marked __devinit not __init
> Since 5535 has no hotplug capability, I set all to __init.

Please use __devinit:
* there is fake PCI hotplug driver which allows you to hot(un)plug any devices
* sparse complains about wrong __init usage

> > * cs5535_ide_init() lacks __init tag
> Done.
>
> > * .name in driver struct should be "CS5535_IDE" (w/o space)
> Done.
>
> > * what taking ide_lock in init_chipset_cs5535() is supposed to protect?
> Nothing as far as I can tell so I took it out.
>
> > * it would be simpler to always set ->autotune and tune PIO instead of
> >   checking for BIOS settings
> Sounds logical. So I took out the reg reads and just set autotune.
>
> > * use 'drive->hwif' instead of 'HWIF' macro
> Done.
>
> > * use 'u8' instead of 'byte' type
> Done.
>
> > * remove unneeded includes
> Done.
>
> > * proper coding style:
> Done.
>
> I did the patch against 2.6.13.1. fyi, the part adding 5535_IDE to pci_ids.h
> duplicates a prior alsa patch I did that is in akpm's -mm. I think I
> should have made the pci_ids diff separate.
>
> I only tested with a single drive that turned out to only be capable of
> MWDMA2 since that's what I have available right now. I'll try to borrow a
> UDMA4 capable drive and 80c cable if I have a chance.
>
>  Model=QUANTUM FIREBALL_TM1280A, FwRev=A6B.2D00, SerialNo=692716821653
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs TrkOff }
>  RawCHS=2484/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=76kB, MaxMultSect=16, MultSect=16
>  CurCHS=2484/16/63, CurSects=2503872, LBA=yes, LBAsects=2503872
>  IORDY=on/off, tPIO={min:300,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
>  AdvancedPM=no
>
>  * signifies the current active mode
>
>  Timing buffer-cache reads:   668 MB in  2.01 seconds = 332.65 MB/sec
>  Timing buffered disk reads:   20 MB in  3.06 seconds =   6.54 MB/sec
>
> Please let me know how it looks and if you have any feedback.

two comments below

> +static int cs5535_config_drive_for_dma(ide_drive_t *drive)
> +{
> +       u8 speed;
> +
> +       speed = ide_dma_speed(drive, cs5535_ratemask(drive));
> +
> +       /* If no DMA speed was available then disable DMA and use PIO. */
> +       if (!speed) {
> +               speed = ide_get_best_pio_mode(drive, 255, 5, NULL);

just return 0 and let cs5535_dma_check() take care of tuning PIO mode

> +       }
> +
> +       cs5535_set_drive(drive, speed);
> +       return ide_dma_enable(drive);
> +}

> +static int cs5535_dma_check(ide_drive_t *drive)
> +{
> +       ide_hwif_t *hwif        = drive->hwif;
> +       struct hd_driveid *id   = drive->id;
> +       u8 speed;
> +
> +       drive->init_speed = 0;
> +
> +       if ((id->capability & 1) && drive->autodma) {
> +               if (ide_use_dma(drive)) {
> +                       if (cs5535_config_drive_for_dma(drive))
> +                               return hwif->ide_dma_on(drive);
> +               }
> +
> +               goto fast_ata_pio;
> +
> +       } else if ((id->capability & 8) || (id->field_valid & 2)) {
> +fast_ata_pio:
> +               speed = ide_get_best_pio_mode(drive, 255, 5, NULL);

wrong arguments (max PIO is 4 not 5)

> +               cs5535_set_drive(drive, speed);
> +               return hwif->ide_dma_off_quietly(drive);
> +       }
> +       /* IORDY not supported */
> +       return 0;
> +}

Otherwise it looks fine and I'll happily apply it after corrections.

Thanks,
Bartlomiej
