From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: IDE CDROM - No DMA
Date: Sun, 12 Mar 2006 14:29:06 -0500
Message-ID: <200603121429.06372.kernel-stuff@comcast.net>
References: <200603101842.09251.kernel-stuff@comcast.net> <200603121209.33218.kernel-stuff@comcast.net> <1142186580.20056.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751742AbWCLT3H@vger.kernel.org>
In-Reply-To: <1142186580.20056.5.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Boot <bootc@bootc.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sunday 12 March 2006 13:03, Alan Cox wrote:

> If you feel adventurous then apply the libata PATA patch from my web
> page and compile a kernel with CONFIG_IDE=n and most stuff should work.
> Folks are still reporting some problems with libata and CD burning
> however.

Ok, I tried the ide2 patch on your website against -rc5 - Disabled CONFIG_IDE 
and kept rest of the configuration same as earlier. 

Funny situation - I cannot figure what my root device is. Earlier without the 
patch it was /dev/sda3 and now I try everything (hda3, hdb3, hdc3, hdd3, 
sda3, sdb3...) but it panics - not able to mount rootfs. 
I have -
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA 
Storage Controller IDE (rev 01) (prog-if 80 [Master]) 

It prints some ata_piix message while booting  but I cannot read that since it 
scrolls fast and post panic obviously I can't scroll up!

Any default for the only one HDD and CDROM that I can try?
Thanks
Parag
