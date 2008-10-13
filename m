From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: weird throughput on write to SATA disk
Date: Mon, 13 Oct 2008 23:39:33 +0100
Message-ID: <20081013233933.2ee5a011@lxorguk.ukuu.org.uk>
References: <1223925629.3947.7.camel@duo>
	<da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40659 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755587AbYJMWjn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 18:39:43 -0400
In-Reply-To: <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: kenneth johansson <ken@kenjo.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 13 Oct 2008 14:07:15 -0700
"Grant Grundler" <grundler@google.com> wrote:

> On Mon, Oct 13, 2008 at 12:19 PM, kenneth johansson <ken@kenjo.org> wrote:
> > When writing data to /dev/sdb (that is the whole disk and no filesystem)
> > it starts out ok around 100MB/sec but soon end up doing considerably
> > worse. For prolonged times lasting several minutes it hovers in the
> > 20-30MB/sec.
> 
> Is the application using "O_DIRECT"?
> If not, could be issue with how VM writeback is (not) working.

Or just mashing up the I/O horribly. Would also be worth turning the CFQ
scheduler off or applying Arjan van de Ven's patches to fix the ioprio of
the kernel writeout threads. That last patch makes a huge difference here.

Alan
