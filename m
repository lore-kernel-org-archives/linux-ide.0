From: kenneth johansson <ken@kenjo.org>
Subject: Re: weird throughput on write to SATA disk
Date: Mon, 13 Oct 2008 23:22:36 +0200
Message-ID: <1223932956.3947.22.camel@duo>
References: <1223925629.3947.7.camel@duo>
	 <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:45427 "EHLO
	amd.kenjo.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756004AbYJMVWj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 17:22:39 -0400
In-Reply-To: <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2008-10-13 at 14:07 -0700, Grant Grundler wrote:
> On Mon, Oct 13, 2008 at 12:19 PM, kenneth johansson <ken@kenjo.org> wrote:
> > When writing data to /dev/sdb (that is the whole disk and no filesystem)
> > it starts out ok around 100MB/sec but soon end up doing considerably
> > worse. For prolonged times lasting several minutes it hovers in the
> > 20-30MB/sec.
> 
> Is the application using "O_DIRECT"?

no just open then write no fancy stuff

> If not, could be issue with how VM writeback is (not) working.

the access pattern is the simplest possible. Is there any knobs I could
try to adjust.

> Can you reproduce this using fio or even "dd"?
> (See git://git.kernel.dk/fio)

dd is having the same effect. 


