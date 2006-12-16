From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to
  1
Date: Sat, 16 Dec 2006 12:19:35 -0500
Message-ID: <45842AA7.5060204@pobox.com>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com> <451F0BF7.1000200@gmail.com> <451F1148.5050604@emc.com> <451FBAFC.4040001@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35071 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161239AbWLPRTo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Dec 2006 12:19:44 -0500
In-Reply-To: <451FBAFC.4040001@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@kernel.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Ric Wheeler wrote:
> Just thinking out loud, but it would be really helpful to get drive 
> vendor's a basic set of tests for Linux systems -  error handling, 
> performance, SMART features, etc - that would run natively on linux.
> We would need to get something really easy to deploy, like a live CD 
> image with the test suite that could be booted on a pc, to get into an 
> environment that is used to booting DOS based floppies...

Strongly agreed.

I know some people use DOS-based environments; I would prefer the 
following test environment:

Equip systems with NICs that can do wake-on-lan and PXE.  To initiate 
testing of a system, perform a PXE boot, which downloads a 
custom-compiled kernel and initrd over the net.  The kernel boots, sets 
up a test environment in either ramfs or nfs (or a combination thereof), 
and runs a "do everything" script which starts the tests specified by 
the network admin.

The tests performed should be in three classes:  (1) data and non-data 
tests performed over a "direct submit" interface like SG_IO, (2) data 
tests performed by directly accessing the block device, and (3) data 
tests performed by accessing data through a common filesystem [ext3 or 
whatever is popular].

It is already trivial to write tests for #2 and #3.  Tests in class #1 
may require some thought and complexity, such as using multiple threads, 
to achieve maximal use of command queueing features.  I'm not aware of 
any userspace interface that allows fine-grained control of TCQ (Jens 
correct me here), or even an interface that does not require multiple 
threads to submit multiple tasks simultaneously.

	Jeff



