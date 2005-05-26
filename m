From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CSB5 IDE does not fully support native mode??
Date: Thu, 26 May 2005 15:24:39 +0100
Message-ID: <1117117463.5743.149.camel@localhost.localdomain>
References: <200505242026.DJT32107@ms3.netsolmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:3761 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261261AbVEZO0t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2005 10:26:49 -0400
In-Reply-To: <200505242026.DJT32107@ms3.netsolmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: evt@texelsoft.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Maw, 2005-05-24 at 21:26, evt@texelsoft.com wrote:
> Can someone explain what the issue is and what I might need to
> do to use csb5 ide in native mode? thanks.

In order to keep the legacy world from falling to bits IDE and VGA have
some ugly hacks in the PCI spec.

In legacy mode an IDE device appears at the "old" standard IDE addresses
and uses an external IRQ pin wired to the ISA IRQ lines (14 or 15). In
native mode it behaves like a PCI device, honouring the PCI bars and
using the PCI INT lines.

>From a performance perspective the difference is essentially irrelevant
and from a wiring perspective its often decided irrevocably by the board
maker.

