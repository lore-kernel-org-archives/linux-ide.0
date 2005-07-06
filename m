From: "Al Boldi" <a1426z@gawab.com>
Subject: RE: [git patches] IDE update
Date: Wed, 6 Jul 2005 06:26:03 +0300
Message-ID: <200507060326.GAA25248@raad.intranet>
References: <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="windows-1256"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.184.187.37] ([213.184.187.37]:42756 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261689AbVGFD2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jul 2005 23:28:22 -0400
In-Reply-To: <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Linus Torvalds' <torvalds@osdl.org>, 'Grant Coady' <grant_lkml@dodo.com.au>
Cc: 'Jens Axboe' <axboe@suse.de>, 'Ondrej Zary' <linux@rainbow-software.org>, =?windows-1256?Q?'Andr=E9_Tomt'?= <andre@tomt.net>, 'Bartlomiej Zolnierkiewicz' <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Linus Torvalds wrote: {
On Wed, 6 Jul 2005, Grant Coady wrote:
> 
> Executive Summary

Btw, can you try this same thing (or at least a subset) with a large file on
a filesystem? Does that show the same pattern, or is it always just the raw
device?
}

Linus,
Cat /dev/hda > /dev/null and cat /tmp/tst.dsk > /dev/null show the same
symptoms.
The problem shows most when the cpu is slow and the hd is fast.
When the cpu is fast and the hd is slow the cpu will make up for lost cycles
and the problem will not show!


