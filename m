From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: SATA/IDE strangeness (ATI chip)
Date: Fri, 18 Mar 2005 18:01:21 +0100
Message-ID: <58cb370e05031809012b59157c@mail.gmail.com>
References: <4239C48A.2050608@gmx.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:31341 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261899AbVCRRBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2005 12:01:22 -0500
Received: by wproxy.gmail.com with SMTP id 67so174499wri
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2005 09:01:21 -0800 (PST)
In-Reply-To: <4239C48A.2050608@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Korpilla <Oliver.Korpilla@gmx.de>
Cc: debian-amd64@lists.debian.org, linux-ide@vger.kernel.org

Hi,

On Thu, 17 Mar 2005 18:55:22 +0100, Oliver Korpilla
<Oliver.Korpilla@gmx.de> wrote:
> Hello!
> 
> On my MSI motherboard there are the following devices:
> 
> 0000:00:11.0 IDE interface: ATI Technologies Inc: Unknown device 437a
> 0000:00:12.0 IDE interface: ATI Technologies Inc: Unknown device 4379
> 0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376
> 
> These are listed in the PCI ID database (not committed yet):
> 
> 4376    Standard Dual Channel PCI IDE Controller ATI
> 4379    ATI 4379 Serial ATA Controller
> 437a    ATI 437A Serial ATA Controller
> 
> The 1st SATA controller seems to work with the SATA_SIL driver from
> vanilla 2.6.11 (and none sooner, I tried), and I'm using it that way
> now. Since the Debian Pure64 CD doesn't come with that, it doesn't find
> a HD when trying to install with the CD.
> 
> I have the following problems:
> ------------------------------
> * Though the SATA is configured in IDE mode in BIOS it does not show up
> as IDE within Linux and this does not change when the ATIIXP driver is
> loaded - ide2 is not recognized as a bus with connected devices. My SATA
> HD is listed by the BIOS to be channel 2 master, while CD-ROM on the
> Dual ATA is listed on channel 0, channel 1 is unused, so shouldn't the
> SATA drive show up as /dev/hde or something???

Linux no longer use legacy/obsolete BIOS ordering/naming.
You can name /dev nodes however you want using udev.

> * How can I tune the ATIIXP driver via parameters or source modification
> so it recognizes the SATA controllers as devices to configure???

What for?

> * How can I force ANY IDE driver to recognize these SATA drives in IDE
> mode?
> 
> This is a mail regarding this topic I'm confused about. The author seems
> to think, ATIIXP can do the 4379 as well:

It can't (reliably).

> http://www.ussg.iu.edu/hypermail/linux/kernel/0412.1/1460.html
> 
> Please let me know if I can provide you with any additional data.
> 
> Thanks and with kind regards,
> Oliver Korpilla
