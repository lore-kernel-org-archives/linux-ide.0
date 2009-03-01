From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Sun, 1 Mar 2009 01:16:27 +0000
Message-ID: <20090301011627.3a1c5017@lxorguk.ukuu.org.uk>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600>
	<26917692A9574F3A9363ED5253B42D2F@DIAMOND8600>
	<49A570DB.8090401@rtr.ca>
	<200902252035.05347.bzolnier@gmail.com>
	<DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600>
	<49A5C9A5.20005@rtr.ca>
	<B2BE4BF16058416F88555755CB1823DF@DIAMOND8600>
	<49A8AC1A.1000900@gmail.com>
	<BB2D271BB5CF41EF91FCE9D3A0A1F2BB@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46311 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694AbZCABQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Feb 2009 20:16:09 -0500
In-Reply-To: <BB2D271BB5CF41EF91FCE9D3A0A1F2BB@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: Robert Hancock <hancockrwd@gmail.com>, Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> If anyone here knows how to put libata in control of chipsets that could be 
> claimed by either libata or legacy ide, please say.  As mentioned I found 

Just compile in the libata drivers you need not the old IDE ones. Simple
as that.

Alan
