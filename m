From: Michal Jaegermann <michal@harddata.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 21:48:23 -0700
Message-ID: <20080129044823.GA12553@mail.harddata.com>
References: <200801272122.21823.gene.heskett@gmail.com> <200801281905.35278.gene.heskett@gmail.com> <alpine.LNX.1.00.0801281909170.13593@iabervon.org> <200801282031.58429.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [216.123.194.198] ([216.123.194.198]:34813 "EHLO
	mail.harddata.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYA2FsA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 00:48:00 -0500
Content-Disposition: inline
In-Reply-To: <200801282031.58429.gene.heskett@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Richard Heck <rgheck@bobjweil.com>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

On Mon, Jan 28, 2008 at 08:31:57PM -0500, Gene Heskett wrote:
> 
> In my script, its one line:
> mkinitrd -f initrd-$VER.img $VER && \
> 
> where $VER is the shell variable I edit to = the version number, located at 
> the top of the script.
> 
> Unforch, its failing:
> No module pata_amd found for kernel 2.6.24, aborting.

mkinitrd is just a shell script.  Even if its options, and there is
a quite a number of these, do not allow to influence a choice of
modules in a desired manner, it is pretty trivial to make yourself a
custom version of it and just hardwire there a fixed list of modules
to use instead of relying on general mechanisms which are trying
hard to guess what you may need.

That way your regular 'mkinitrd' will build something to boot with
libata and 'mkinird.ide' will use IDE modules for that purpose using
the same "core" kernel.

If you are using distribution kernels, as opposed to your own
configuration, it is quite likely that you will need to install
'kernel-devel' package and recompile and add required IDE modules
yourself as those may be not provided.  This is done the same way
like for any other "external" module.

   Michal
