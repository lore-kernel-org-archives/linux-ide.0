From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: PROBLEM: SATA AHCI driver significant throughput loss in 2.6.22-rc5-g75154f40-dirty
Date: Fri, 29 Jun 2007 15:36:58 +0200
Message-ID: <6bffcb0e0706290636t334e2e29h17d215cee77dc2da@mail.gmail.com>
References: <439fa30706262117u2d5553dfp8395c6ca41574a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:53850 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765283AbXF2NhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 09:37:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1174328wah
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 06:36:59 -0700 (PDT)
In-Reply-To: <439fa30706262117u2d5553dfp8395c6ca41574a8c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan <metalifloyd@gmail.com>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

[adding linux-ide to cc]

On 27/06/07, Dan <metalifloyd@gmail.com> wrote:
> Something changed with the AHCI SATA driver in the latest git version.
> With 2.6.21 I get ~49MB/sec according to hdparm. Using the latest git
> version I only get ~8MB/sec. I've attached my .config and have
> included some info about my system below. Please let me know if you
> need more information or if I can help test anything.
>
> Lenovo Thinkpad T60p
>
> kernel information:
> ===================
> Linux lappy 2.6.22-rc5-g75154f40-dirty #1

Are you using any additional patches?

> SMP PREEMPT Sat Jun 23
> 21:14:49 EDT 2007 i686 Genuine Intel(R) CPU T2600 @ 2.16GHz
> GenuineIntel GNU/Linux
>
> Gnu C                  4.1.2
> Gnu make               3.81
> binutils               2.17
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> Linux C Library        > libc.2.5
> Dynamic linker (ldd)   2.5
> Procps                 3.2.7
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               6.9
> udev                   104
> wireless-tools         28
> Modules Loaded         fglrx agpgart af_packet snd_pcm_oss
> snd_mixer_oss ipw3945 ieee80211 ieee80211_crypt snd_hda_intel snd_pcm
> snd_timer snd soundcore snd_page_alloc e1000 psmouse evdev unix
>
>
>
> hdparm -i /dev/sda
> ==================
> /dev/sda:
>
>  Model=HTS721010G9SA00                         , FwRev=MCZIC10V,
> SerialNo=      MPDZN7Y0HKTYZL
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=7538kB, MaxMultSect=16, MultSect=?16?
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195371568
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-7 T13 1532D revision 1:  ATA/ATAPI-2,3,4,5,6,7
>
> cat /proc/modules
> =================
> fglrx 649632 15 - Live 0xf8a90000 (P)
> agpgart 30412 1 fglrx, Live 0xf894e000
> af_packet 23816 2 - Live 0xf893c000
> snd_pcm_oss 40736 0 - Live 0xf88eb000
> snd_mixer_oss 17536 1 snd_pcm_oss, Live 0xf88b4000
> ipw3945 201124 1 - Live 0xf8909000
> ieee80211 33608 1 ipw3945, Live 0xf88e1000
> ieee80211_crypt 8704 1 ieee80211, Live 0xf887d000
> snd_hda_intel 243864 0 - Live 0xf8958000
> snd_pcm 68996 2 snd_pcm_oss,snd_hda_intel, Live 0xf88f7000
> snd_timer 22148 1 snd_pcm, Live 0xf8872000
> snd 45412 5 snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_pcm,snd_timer,
> Live 0xf8881000
> soundcore 10208 1 snd, Live 0xf885a000
> snd_page_alloc 11400 2 snd_hda_intel,snd_pcm, Live 0xf884b000
> e1000 118080 0 - Live 0xf8896000
> psmouse 38416 0 - Live 0xf8867000
> evdev 11648 0 - Live 0xf8847000
> unix 29584 62 - Live 0xf8851000
>
>

Regards,
Michal

-- 
LOG
http://www.stardust.webpages.pl/log/
