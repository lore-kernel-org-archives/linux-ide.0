From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 11:32:27 +0900
Message-ID: <4B9EEDBB.7030106@gmail.com>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de> <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com> <4B9EED55.10201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45467 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937358Ab0CPCcj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2010 22:32:39 -0400
In-Reply-To: <4B9EED55.10201@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Aieee... critical typo.

On 03/16/2010 11:30 AM, Tejun Heo wrote:
> partition table which some BIOSs actually try to do.  The problem is
> that to determine the two parameters you need to equations matching
                                                ^^
                                                two
> CHSs and LBAs

-- 
tejun
