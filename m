From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Wed, 25 Feb 2009 11:24:59 -0500
Message-ID: <49A570DB.8090401@rtr.ca>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <20090224171044.52e70a6b@dhcp-100-2-144.bos.redhat.com> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46328 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756762AbZBYQZD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 11:25:03 -0500
In-Reply-To: <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Norman Diamond wrote:
..
> Does anyone know when this bug was added?  2.6.19 is too old for my needs,
> but the range 2.6.24 to 2.6.26 might be OK if they had taskfiles working.
> Maybe I should look for a Slax version that had a kernel from 2.6.24 or so,
> since I can probably customize it in a single day by now.  But if the bug
> was already present in 2.6.24 then it would be a waste of time.
..

Heh.. the question could be more like, does anyone know which few kernels
that HDIO_DRIVE_TASKFILE ever worked completely on?  :)

I know I have to patch drivers/ide rather heavily to get a working,
reliable HDIO_DRIVE_TASKFILE on it.

Much better is to move to libata, and use ATA_16 with SG_IO,
for a standard, working way of doing this kind of stuff.

Cheers
