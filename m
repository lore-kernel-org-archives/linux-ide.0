From: "Michael Sterrett -Mr. Bones.-" <msterret@coat.com>
Subject: Re: [RFT] major libata update
Date: Sun, 21 May 2006 19:51:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0605211937540.5021@rutrow.coat.com>
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coat.coat.com ([164.153.10.15]:28844 "EHLO coat.coat.com")
	by vger.kernel.org with ESMTP id S964947AbWEUXve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2006 19:51:34 -0400
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Was having trouble getting a new Seagate drive to show up at all with
2.6.16.* so I went ahead and stepped up to .17_rc4 with this patch.
Still no go.  It looks like it's not even seeing the drive at all.
I hope I'm just missing something obvious.

dmesg after boot at:

http://dev.gentoo.org/~mr_bones_/

There's one with routeirq and one without.  The config file is there as
well as 2.6.17-rc4-dot-config.gz (from /proc/config.gz). lspci -v output is
in lspci-dash-v.  You can see that system is really (ab)using the pci bus.

This is the drive:
http://www.newegg.com/Product/Product.asp?Item=N82E16822148131

I don't think it's in sil_blacklist but I don't think it's even getting
that far.  Any tips on what to try next would be great.

Michael Sterrett
   -Mr. Bones.-
michael.sterrett@coat.com

On Mon, 15 May 2006, Jeff Garzik wrote:

>
> After much development and review, I merged a massive pile of libata
> patches from Tejun Heo and Albert Lee.  This update contains the
> following major libata

<chop>

> * sata_sil and ata_piix also need healthy re-testing of all basic
> functionality.
>
> FEEDBACK:
> * Please CC linux-ide@vger.kernel.org on all emails and bug reports.
>
> MERGE STATUS:
> * Barring major problems in testing, will submit during 2.6.18 merge window.
>
>
> Patch:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-git2-libata1.patch.bz2
> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
> 2.6.17-rcX[-gitY] kernels)

<chop>
