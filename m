From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Subject: Re: bug report
Date: Wed, 24 Sep 2008 20:25:12 +0200
Message-ID: <1222280712.14959.14.camel@odie.local>
References: <48DA0B39.5050401@saturnosoft.biz>
	 <1222274317.14959.4.camel@odie.local>  <48DA7F1E.5030508@saturnosoft.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754909AbYIXSYa@vger.kernel.org>
In-Reply-To: <48DA7F1E.5030508@saturnosoft.biz>
Sender: linux-kernel-owner@vger.kernel.org
To: Todor Gyumyushev <todor@saturnosoft.biz>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Albert Lee <albertcc@tw.ibm.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[ CC'ing linux-ide mailing list and the people involved in commit
  56c819df (libata: update ATAPI overflow draining) that introduced the
  WARN_ON. ]

ons, 24 09 2008 kl. 20:55 +0300, skrev Todor Gyumyushev:
> Simon Holm Th=C3=B8gersen wrote:
> > ons, 24 09 2008 kl. 12:41 +0300, skrev Todor Gyumyushev:
> >  =20
> >> ------------[ cut here ]------------
> >> WARNING: at drivers/ata/libata-sff.c:944 ata_sff_hsm_move+0x4a9/0x=
6a0()
> >> Modules linked in: cdc_acm eth1394 vboxdrv isofs zlib_inflate ath5=
k=20
> >> aes_generic nls_utf8 nls_cp437 vfat fat nls_base i915 drm kvm=20
> >> acpi_cpufreq hci_usb rfcomm l2cap pktcdvd nfsd lockd nfs_acl auth_=
rpcgss=20
> >> sunrpc exportfs fan ac battery microcode firmware_class loop usb_s=
torage=20
> >> usbhid snd_hda_intel arc4 snd_pcm_oss sg ecb crypto_blkcipher=20
> >> snd_mixer_oss cryptomgr snd_pcm snd_timer tpm_infineon sr_mod usbl=
p snd=20
> >> rng_core cdrom ehci_hcd mac80211 thermal ohci1394 ieee1394 process=
or=20
> >> evdev thermal_sys tpm uhci_hcd iTCO_wdt iTCO_vendor_support soundc=
ore=20
> >> cfg80211 tpm_bios sky2 hwmon snd_page_alloc intel_agp button [last=
=20
> >> unloaded: ath5k]
> >> Pid: 0, comm: swapper Tainted: G        W 2.6.26.5 #6
> >>    =20
> >
> > This warning is not the first produced by your system, see the W fl=
ag in
> > the line above. Can you find an earlier warning in your dmesg/log? =
Or is
> > it similar to this one?
> >
> >  =20
> >> Call Trace:
> >>  <IRQ>  [<ffffffff80236214>] warn_on_slowpath+0x64/0xc0
> >>  [<ffffffff803c9ec8>] ata_sff_data_xfer+0x98/0xc0
> >>  [<ffffffff803c96c9>] ata_sff_hsm_move+0x4a9/0x6a0
> >>  [<ffffffff803c9c13>] ata_sff_interrupt+0x1a3/0x2c0
> >>  [<ffffffff802748e4>] handle_IRQ_event+0x34/0x70
> >>  [<ffffffff80275e60>] handle_edge_irq+0xc0/0x160
> >>  [<ffffffff8020ebac>] do_IRQ+0x7c/0x100
> >>  [<ffffffff8020bc51>] ret_from_intr+0x0/0xa
> >>  <EOI>  [<ffffffff8021c800>] lapic_next_event+0x0/0x10
> >>  [<ffffffff803fbc10>] cpuidle_idle_call+0x0/0x120
> >>  [<ffffffffa00564bc>] :processor:acpi_idle_enter_simple+0x1c5/0x23=
5
> >>  [<ffffffffa00564b2>] :processor:acpi_idle_enter_simple+0x1bb/0x23=
5
> >>  [<ffffffff803fbc10>] cpuidle_idle_call+0x0/0x120
> >>  [<ffffffff803fbce7>] cpuidle_idle_call+0xd7/0x120
> >>  [<ffffffff803fbc10>] cpuidle_idle_call+0x0/0x120
> >>  [<ffffffff803fbc10>] cpuidle_idle_call+0x0/0x120
> >>  [<ffffffff80209410>] default_idle+0x0/0x50
> >>  [<ffffffff8020a720>] cpu_idle+0x60/0xd0
> >>
> >> ---[ end trace 05ba06d61030bbb9 ]---
> >>
> >>    =20
> >
> >
> > Simon Holm Th=C3=B8gersen
> >
> >
> >  =20
> Hi there,
>=20
> yes you are correct, I found another one earlier, initially I thought=
 is=20
> the same but it is not.
>=20
> Regards,
> Todor
>=20
>=20
> ------------[ cut here ]------------
> WARNING: at drivers/ata/libata-sff.c:944 ata_sff_hsm_move+0x4a9/0x6a0=
()
> Modules linked in: eth1394 vboxdrv isofs zlib_inflate ath5k aes_gener=
ic=20
> nls_utf8 nls_cp437 vfat fat nls_base i915 drm kvm acpi_cpufreq hci_us=
b=20
> rfcomm l2cap pktcdvd nfsd lockd nfs_acl auth_rpcgss sunrpc exportfs f=
an=20
> ac battery microcode firmware_class loop usb_storage usbhid=20
> snd_hda_intel arc4 snd_pcm_oss sg ecb crypto_blkcipher snd_mixer_oss=20
> cryptomgr snd_pcm snd_timer tpm_infineon sr_mod usblp snd rng_core cd=
rom=20
> ehci_hcd mac80211 thermal ohci1394 ieee1394 processor evdev thermal_s=
ys=20
> tpm uhci_hcd iTCO_wdt iTCO_vendor_support soundcore cfg80211 tpm_bios=
=20
> sky2 hwmon snd_page_alloc intel_agp button [last unloaded: ath5k]
> Pid: 13270, comm: npviewer.bin Not tainted 2.6.26.5 #6
>=20
> Call Trace:
>  <IRQ>  [<ffffffff80236214>] warn_on_slowpath+0x64/0xc0
>  [<ffffffff8032cf0b>] elv_next_request+0x12b/0x1f0
>  [<ffffffff80252678>] getnstimeofday+0x48/0xc0
>  [<ffffffff8024fe70>] ktime_get_ts+0x30/0x60
>  [<ffffffff8024feac>] ktime_get+0xc/0x50
>  [<ffffffff8022e58a>] hrtick_start_fair+0x12a/0x190
>  [<ffffffff803c9ec8>] ata_sff_data_xfer+0x98/0xc0
>  [<ffffffff803c96c9>] ata_sff_hsm_move+0x4a9/0x6a0
>  [<ffffffff803c9c13>] ata_sff_interrupt+0x1a3/0x2c0
>  [<ffffffff802748e4>] handle_IRQ_event+0x34/0x70
>  [<ffffffff8023c44a>] __do_softirq+0x7a/0xf0
>  [<ffffffff80275e60>] handle_edge_irq+0xc0/0x160
>  [<ffffffff8020c8cc>] call_softirq+0x1c/0x30
>  [<ffffffff8020ebac>] do_IRQ+0x7c/0x100
>  [<ffffffff8020bc51>] ret_from_intr+0x0/0xa
>  <EOI>
> ---[ end trace 05ba06d61030bbb9 ]---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
