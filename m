From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fix IDE locking error.
Date: Fri, 17 Feb 2006 14:28:52 +0000
Message-ID: <1140186532.4283.2.camel@localhost.localdomain>
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32163 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751440AbWBQO0z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Feb 2006 09:26:55 -0500
In-Reply-To: <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Gwe, 2006-02-17 at 09:57 +0100, Bartlomiej Zolnierkiewicz wrote:
> Could we get a decent description of the problem and of the patch?

Audit the lock state on all entries to the tune function and it
certainly was the case that the old IDE layer could call it with the
lock either already held or not.

Alan

