From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Thu, 12 Mar 2009 08:00:09 +0900 (JST)
Message-ID: <20090311230009.50404.qmail@web4108.mail.ogk.yahoo.co.jp>
References: <200903112333.05478.bzolnier@gmail.com>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web4108.mail.ogk.yahoo.co.jp ([124.83.200.70]:24896 "HELO
	web4108.mail.ogk.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750897AbZCKXAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 19:00:12 -0400
In-Reply-To: <200903112333.05478.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Chuck Ebbert <cebbert@redhat.com>, Robert Hancock <hancockrwd@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, n0diamond@yahoo.co.jp

Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 March 2009, Norman Diamond wrote:
>>
>> Knoppix 6.0.1 is built on kernel 2.6.28.4.  Legacy
>> IDE drivers still claim /dev/hda and /dev/hdc (the
>> Knoppix CD being on /dev/hdc).
>> 
>> When I try to do a TASKFILE WRITE_DMA (LBA28), the
>> process hangs.  No dump.  Ctrl+C and Ctrl+Z were
>> ignored. 
> 
> Could you post source code of your program or at
> least the minimal test case reproducing the problem?

Sorry, that one was my fault, as mentioned last week.
When kernels 2.6.28.4, 2.6.24.3, etc., don't enable
DMA on Intel ICH7M chipsets, it is my fault for trying
to use WRITE_DMA.

I am leaning towards reverting to kernel 2.6.20,
because there was a Slax distribution for it, it
enabled DMA on Intel ICH7M chipsets, and on other
machines where ICH7 presented a SATA interface its
LIBATA could access LBA sector address 0x0fffffff.
I've been told (can't test personally) that 2.6.20
had trouble with AMD chipsets, but Intel users
outnumber AMD users.  I probably have to rebuild that
Slax with TASKFILEs enabled and see if they work.

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
