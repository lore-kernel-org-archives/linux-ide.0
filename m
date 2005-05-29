From: Erik Slagter <erik@slagter.name>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 19:26:31 +0200
Message-ID: <1117387591.4851.17.camel@localhost.localdomain>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:47286 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261225AbVE2R1G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 13:27:06 -0400
In-Reply-To: <4299F47B.5020603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, 2005-05-29 at 18:57 +0200, Michael Thonke wrote:

> >Another question: is there a fundamental problem to have the ICH6/7
> >enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
> >don't offer the choice to enable AHCI (like mine :-().

> here on my Mainboard ASUS P5WAD2-Premium (i955X/ICH7) I need to enable
> AHCI support like on the ICH6R based ASUS P5AD2-E xx the same here.
> What I have noticed is when I enable Intel Raid support AHCI is on by
> default, maybe it used AHCI if drive is capable?!

AHCI is needed for "raid"-support.

> What mainboard are you using Erik? All mainboards with ICH6R I saw and
> had (925X,925XE) offer options to enable AHCI.

ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
no plans to implement support for AHCI transition in the BIOS. &^$##($%
DELL.
