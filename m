From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/13] ACPI objects for SATA/PATA
Date: Wed, 22 Feb 2006 16:26:54 -0800
Message-ID: <20060222162654.31ef25ad.akpm@osdl.org>
References: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:9883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751542AbWBWAYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 19:24:46 -0500
In-Reply-To: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:
>
> This patch series is primarily ACPI objects support for SATA/PATA.
> It applies to 2.6.16-rc4.

I tried to get these on top of Jeff's current devel tree but gave up at
ata-acpi-pata-methods when things got really sticky.

So you're rather between a rock and a hard place here.  Perhaps it would be
better for you to continue development on top of Jeff's devel tree, and to
distribute a copy of git-libata-all.patch along with your patches to your
testers.

Of course, that puts them on the bleeding edge when all they want to do is
to get their power management working, so that's not really suitable
either.

