From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Tue, 06 Jan 2009 02:25:59 +0100
Message-ID: <4962B327.1020209@s5r6.in-berlin.de>
References: <fa.+H1UnEqOmFht/vMPmVy8ellbQi0@ifi.uio.no> <fa.RLz5WOGorLui5GRkc963Ww1kXqg@ifi.uio.no> <fa.x4ejZ7Kj7ZZRu88Sond1Cap6XxY@ifi.uio.no> <49628720.6050101@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:55687 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZAFB0j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 20:26:39 -0500
In-Reply-To: <49628720.6050101@yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Jens Axboe <jens.axboe@oracle.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Sitsofe Wheeler wrote:
> How about cheapseek? fastrandom? flash? ssd? However the internal flag
> is called QUEUE_FLAG_NONROT so it kind of makes sense just to leave it
> as nonrot...

It is not necessary to obfuscate an interface to userspace just because
some internally used cpp macro got an awkward name.
-- 
Stefan Richter
-=====-==--= ---= --==-
http://arcgraph.de/sr/
