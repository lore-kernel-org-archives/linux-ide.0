From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Wed, 22 Aug 2007 12:23:12 -0400
Message-ID: <20070822162312.GG9412@csclub.uwaterloo.ca>
References: <200708212149.12912.jopan@alumni.uv.es> <46CB626F.8020801@gmail.com> <200708220339.45138.jopan@alumni.uv.es> <46CBA0F0.70503@gmail.com> <20070822122359.7ce8ddaa@the-village.bc.nu> <46CC5AE4.1090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932456AbXHVQX0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CC5AE4.1090600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jos? Luis Pati?o Andr?s <jopan@alumni.uv.es>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 22, 2007 at 05:48:52PM +0200, Rene Herman wrote:
> He has a SATA harddrive and an IDE DVD drive. When he compiles with 
> CONFIG_ATA_PIIX (a driver which advertises both SATA and PATA in its 
> description) his drive works, his DVD does not. Is that not the correct 
> driver? Does he need something else? How does he get his DVD to work?

Well of course the DVD should show up as /dev/sr0 or scd0 with the new
driver, not the /dev/hd? name.  And scsi cdrom support is required too.

--
Len Sorensen
