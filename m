From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 18:33:46 +0200
Message-ID: <200804021833.49295.linux@rainbow-software.org>
References: <200804021524.27222.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759215AbYDBQeQ@vger.kernel.org>
In-Reply-To: <200804021524.27222.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Wednesday 02 April 2008 15:24:26 Frans Pop wrote:
> Hi,
>
> We've received an installation report for Debian for an older system where
> no IDE driver gets loaded. The system does not have any IDE device listed
> in lspci. When ide-generic is modprobed manually, both the CD and hard disk
> work fine.
>
> Any suggestions on how such a system could be recognized?
> If we could do that, the installation system could take responsibility for
> loading ide-generic and making sure it is included in the initrd.
>
> Or even better, any chance to make the kernel/udev load ide-generic
> automatically for this system?
>
> See http://bugs.debian.org/472487 for details. I can get additional info
> from the owner of the system if needed.
>
> Cheers,
> FJP
>
> Output of lspci -nn:
> 00:00.0 Host bridge [0600]: Toshiba America Info Systems CPU to PCI bridge
> [1179:0601] (rev a0)
> 00:04.0 VGA compatible controller [0300]: Chips and Technologies F65555
> HiQVPro [102c:00e5] (rev c6)
> 00:0b.0 USB Controller [0c03]: NEC Corporation USB [1033:0035] (rev 02)
> 00:11.0 Communication controller [0780]: Toshiba America Info Systems FIR
> Port [1179:0701] (rev 21)
> 00:13.0 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97
> [1179:060f] (rev 20)
> 00:13.1 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97
> [1179:060f] (rev 20)

Looks like the controller is not a separate PCI device. Toshiba provides Bus 
Mastering driver for Windows 95:
http://209.167.114.38/support/download/files_Archive/Index/windows_95_files.htm

So the controller probably can do DMA but it's not a standard IDE controller. 
And looks like there's no driver in the kernel for it.

-- 
Ondrej Zary
