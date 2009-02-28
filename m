From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Fri, 27 Feb 2009 21:14:34 -0600
Message-ID: <49A8AC1A.1000900@gmail.com>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca> <200902252035.05347.bzolnier@gmail.com> <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600> <49A5C9A5.20005@rtr.ca> <B2BE4BF16058416F88555755CB1823DF@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:34600 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZB1DOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Feb 2009 22:14:42 -0500
Received: by ewy25 with SMTP id 25so1564582ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 19:14:40 -0800 (PST)
In-Reply-To: <B2BE4BF16058416F88555755CB1823DF@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Norman Diamond wrote:
>> Libata should be used for any new setup that doesn't have a strict legacy
>> requirement now.
> 
> 90% agreed.  However, I've read that libata will never support add-on IDE
> boards.

Huh? It already does support most or all that one is likely to see..
