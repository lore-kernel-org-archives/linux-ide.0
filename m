From: Len Brown <lenb@kernel.org>
Subject: Re: [git patches] IDE updates for 2.6.20
Date: Thu, 8 Feb 2007 14:47:06 -0500
Message-ID: <200702081447.07223.lenb@kernel.org>
References: <20070207180814.27444.59159.sendpatchset@localhost.localdomain> <20070207182748.1c0c3588@localhost.localdomain> <45CA1916.6020709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423298AbXBHTtB@vger.kernel.org>
In-Reply-To: <45CA1916.6020709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-acpi@vger.kernel.org
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 07 February 2007 13:23, Sergei Shtylyov wrote:
> Hello.
> 
> Alan wrote:
> > On Wed, 07 Feb 2007 19:08:14 +0100
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> >>- ACPI support for IDE (has been in SuSE kernels for months)
> >>  (Hannes Reinecke <hare@suse.de>)
> 
> > I can find no public copy of this or discussion of it, please post a
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=116916643921306
> 
> > reference to the previous discussion or put the ACPI patch somewhere for
> > review first.
> 
> http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-acpi-support.patch

So it looks like...
if (CONFIG_BLK_DEV_IDEACPI=y)
	suspend uses _GTM
	resume uses _STM

But it looks like _GTF and using the task file is disabled by default,
and needs to be enabled by invoking "ide=acpigtf".  Why is that?

Also, what's the story on ide=acpionboot -- when/why is that expected
to be invoked, and why is it not the default?

thanks,
-Len
