From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 07:05:50 -0500
Message-ID: <4B2A1E9E.30009@garzik.org>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com> <19241.63911.160765.909812@pilspetsen.it.uu.se> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com> <4B2A1008.9070202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:46521 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZLQMFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 07:05:52 -0500
In-Reply-To: <4B2A1008.9070202@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Romain Kubany <rkubany@ikoula.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/17/2009 06:03 AM, Jeff Garzik wrote:
> On 12/17/2009 05:04 AM, Romain Kubany wrote:
>> Here is the new kernel config file : http://pastebin.com/f65fd472b
>
> I would definitely be interested in seeing the 'dmesg' output for
> libata, and results from a more recent kernel.

Also, what does 'hdparm -I /dev/XXXX' output look like?

	Jeff



