From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/13] ACPI objects for SATA/PATA
Date: Wed, 22 Feb 2006 16:28:31 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602221627160.24281@shark.he.net>
References: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
 <20060222162654.31ef25ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:42219 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751603AbWBWA2c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 19:28:32 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 16:28:31 -0800
In-Reply-To: <20060222162654.31ef25ad.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wed, 22 Feb 2006, Andrew Morton wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:
> >
> > This patch series is primarily ACPI objects support for SATA/PATA.
> > It applies to 2.6.16-rc4.
>
> I tried to get these on top of Jeff's current devel tree but gave up at
> ata-acpi-pata-methods when things got really sticky.
>
> So you're rather between a rock and a hard place here.  Perhaps it would be
> better for you to continue development on top of Jeff's devel tree, and to
> distribute a copy of git-libata-all.patch along with your patches to your
> testers.
>
> Of course, that puts them on the bleeding edge when all they want to do is
> to get their power management working, so that's not really suitable
> either.

OK, I'll think about how to attack that...
Thanks for the info.  I didn't think about you using git-libata*.
My bad.

-- 
~Randy
