From: Marc Dionne <marc.c.dionne@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 17 Mar 2010 18:22:59 -0400
Message-ID: <6041d2001003171522u616c319eocc850c66acae49c7@mail.gmail.com>
References: <20100317200431.GA24631@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:4069 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab0CQWXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2010 18:23:01 -0400
In-Reply-To: <20100317200431.GA24631@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Mar 17, 2010 at 4:04 PM, Jeff Garzik <jeff@garzik.org> wrote:
>
> The ATA timeout bug is still being worked, testers welcome. =A0Patch =
posted
> to linux-ide and LKML was also posted to the tracking bug,
> http://bugzilla.kernel.org/show_bug.cgi?id=3D15537

Since you're asking for testers, that patch does fix the ATA timeout
issue for me - it was easy to trigger when doing a kernel compile when
in IDE mode.

I do still see a few "clearing spurious IRQ" messages that are new
with 2.6.34, but with no visible effect.

Marc
