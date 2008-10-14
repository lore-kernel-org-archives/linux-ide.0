From: "Grant Grundler" <grundler@google.com>
Subject: Re: weird throughput on write to SATA disk
Date: Tue, 14 Oct 2008 09:09:21 -0700
Message-ID: <da824cf30810140909y11bdd92akf9046c996c367130@mail.gmail.com>
References: <1223925629.3947.7.camel@duo>
	 <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>
	 <1223932956.3947.22.camel@duo>
	 <da824cf30810131434r34179666kc8d075c7eecdbbae@mail.gmail.com>
	 <1223936351.3947.41.camel@duo>
	 <da824cf30810131833g6e509d0dvb6cce6c7220a1a28@mail.gmail.com>
	 <1223975694.3947.77.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:7686 "EHLO
	smtp-out3.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbYJNQJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 12:09:38 -0400
In-Reply-To: <1223975694.3947.77.camel@duo>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 14, 2008 at 2:14 AM, kenneth johansson <ken@kenjo.org> wrote:
...
> All my numbers comes from using 1MB blocks. but I'm not using dd.
> After removing the logic that actually put some data into the buffers I
> do get about 105 MB/sec using O_DIRECT.

Ok. Good.

> I'm doing a full disk write now to get a reference plot.

See http://hdperf.sourceforge.net/  and http://nathan.laredo.name/hdperf/
Simple tool to (relatively) quickly measure the perf across the disk platter.

> Not using O_DIRECT should be almost identical.

*should* - but there are known problems with writeback.
Some of them are described nicely by Dave Chinner as "Random Thought #3":
    http://iou.parisc-linux.org/lsf2008/linux_storage_scalability-Dave_Chinner.odp

Look for "writeback" for a summary of the discussion:
    http://iou.parisc-linux.org/lsf2008/SUMMARY-Storage.txt

hth,
grant
