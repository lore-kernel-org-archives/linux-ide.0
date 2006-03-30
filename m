From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE CDROM tail read errors
Date: Thu, 30 Mar 2006 12:18:09 +0100
Message-ID: <1143717489.29388.32.camel@localhost.localdomain>
References: <m3wtedrrpf.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932176AbWC3LKa@vger.kernel.org>
In-Reply-To: <m3wtedrrpf.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mer, 2006-03-29 at 21:11 +0200, Krzysztof Halasa wrote:
> # ls -l
> -rw-r--r-- 1 root root 687177728 Mar 29 15:51 img-15.iso
> -rw-r--r-- 1 root root 687177728 Mar 29 15:58 img-15a.iso
> 
> The files are just truncated FC5d1 images (57344 bytes missing).

The final partial read is dropped rather than partially completed.

> # cat /sys/block/sr0/size
> 1342264 (i.e., the same as with 2.6.15 + drivers/ide)
> 
> # cat /dev/cdrw > img-16a.iso
> cat: /dev/cdrw: Input/output error
> 
> # cat /sys/block/sr0/size
> 1342256 (looks like it has been adjusted to .iso image size / 512 when
>          the first I/O error occured)

The SCSI layer does this bit for everyone. Its actually not libata or
the PATA drivers that have done the work here. You should find ide-scsi
does the same.

I patched the old IDE driver a bit to try and deal with this and if you
want the patch to hack on and tidy up further feel free. 
