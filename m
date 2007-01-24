From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: 2.6.20-rc5: known unfixed regressions (v3) (part 2)
Date: Wed, 24 Jan 2007 11:06:31 -0500
Message-ID: <20070124160631.GE7582@csclub.uwaterloo.ca>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070124154725.GK17836@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750910AbXAXQGd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070124154725.GK17836@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gd@spherenet.de, petero2@telia.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, Uwe Bugla <uwe.bugla@gmx.de>, alan@lxorguk.ukuu.org.uk, Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, Nick Piggin <nickpiggin@yahoo.com.au>, ttb@tentacle.dhs.org, rml@novell.com, Livio Soares <livio@eecg.toronto.edu>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Malte Schr??der <MalteSch@gmx.de>, "Vladimir V. Saveliev" <vs@namesys.com>, reiserfs-dev@namesys.com, Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>, xfs-masters@oss.sgi.com, takada <takada@mbf.nifty.com>, Jordan Crouse <jordan.crouse@amd.com>, Andrew Clayton <andrew@digital-domain.net>, Trond Myklebust <trond.myklebust@fys.uio.no>
List-Id: linux-ide@vger.kernel.org

On Wed, Jan 24, 2007 at 04:47:25PM +0100, Adrian Bunk wrote:
> Subject    : fix geode_configure()
> References : http://lkml.org/lkml/2007/1/9/216
> Submitter  : Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Caused-By  : takada <takada@mbf.nifty.com>
>              commit e4f0ae0ea63caceff37a13f281a72652b7ea71ba
> Handled-By : takada <takada@mbf.nifty.com>
>              Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> Status     : patches are being discussed

I wouldn't call this a regression.  It appears to go way back.  I also
didn't find it, I just commented on it since it does affect the platform
I work on.

--
Len Sorensen
