From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates
Date: Wed, 4 Aug 2010 11:32:05 -0700
Message-ID: <AANLkTik-68XiTq3VC6ta3-YVL8r=FpwFErAx8nVV4CJ4@mail.gmail.com>
References: <20100804015530.GA8136@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41868 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754029Ab0HDSdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Aug 2010 14:33:17 -0400
In-Reply-To: <20100804015530.GA8136@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Aug 3, 2010 at 6:55 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Tejun Heo (4):
> =A0 =A0 =A0ata_generic: drop hard coded DMA force logic for CENATEK
> =A0 =A0 =A0ata_piix: fix locking around SIDPR access
> =A0 =A0 =A0libata: more PCI IDs for jmicron controllers
> =A0 =A0 =A0sata_fsl,mv,nv: prepare for NCQ command completion update

Hmm. Aren't these the ones that you said causes "sata_mv is behaving
weirdly"? I think I'll wait for you to do another pull request when
that is sorted out..

             Linus
