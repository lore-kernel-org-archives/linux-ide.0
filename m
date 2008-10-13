From: "Grant Grundler" <grundler@google.com>
Subject: Re: weird throughput on write to SATA disk
Date: Mon, 13 Oct 2008 14:34:00 -0700
Message-ID: <da824cf30810131434r34179666kc8d075c7eecdbbae@mail.gmail.com>
References: <1223925629.3947.7.camel@duo>
	 <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
	 <1223932956.3947.22.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:59681 "EHLO
	smtp-out3.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752425AbYJMVeS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 17:34:18 -0400
In-Reply-To: <1223932956.3947.22.camel@duo>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 13, 2008 at 2:22 PM, kenneth johansson <ken@kenjo.org> wrote:
> On Mon, 2008-10-13 at 14:07 -0700, Grant Grundler wrote:
>> On Mon, Oct 13, 2008 at 12:19 PM, kenneth johansson <ken@kenjo.org> wrote:
>> > When writing data to /dev/sdb (that is the whole disk and no filesystem)
>> > it starts out ok around 100MB/sec but soon end up doing considerably
>> > worse. For prolonged times lasting several minutes it hovers in the
>> > 20-30MB/sec.
>>
>> Is the application using "O_DIRECT"?
>
> no just open then write no fancy stuff
>
>> If not, could be issue with how VM writeback is (not) working.
>
> the access pattern is the simplest possible. Is there any knobs I could
> try to adjust.
>
>> Can you reproduce this using fio or even "dd"?
>> (See git://git.kernel.dk/fio)
>
> dd is having the same effect.

Can you try "dd oflag=direct if=/dev/null of=/dev/sdb bs=64k"?

Or try with "sgp_dd"? It's part of sg3-utils package.

thanks,
grant
