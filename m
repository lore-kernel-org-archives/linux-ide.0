From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Tue, 17 Apr 2007 15:07:25 +0100
Message-ID: <20070417150725.1f675995@the-village.bc.nu>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se>
	<462136AF.9060505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49689 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964796AbXDQOEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 10:04:23 -0400
In-Reply-To: <462136AF.9060505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

> > CMD64x is an established name, while PCI-xxx is something
> > I've never heard of (and it sounds awfully generic).
> 
>    Specs are available from http://gkernel.sourceforge.net/specs/ -- you can see the names on the first pages.

End users don't read the specs, they read the box, and they seem to have
been marketed as CMD PCI-064x. So at least keep the CMD in the name so
people know what is what and can work out the pointless name change
