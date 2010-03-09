From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 9 Mar 2010 17:46:58 -0500
Message-ID: <87f94c371003091446h62e50257qf884b278c69cfbfa@mail.gmail.com>
References: <4B947393.2050002@kernel.org>
	 <1268031640.4389.11.camel@mulgrave.site> <4B94ACE8.4060400@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:56252 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0CIWq6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 17:46:58 -0500
In-Reply-To: <4B94ACE8.4060400@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, mkp@mkp.net

<snip>
>
> As far as partitioning... I believe we should be using GPT partition =
tables
> where possible. =A0Even on non-EFI systems, it's simply a much better
> partition table format.
>
> =A0 =A0 =A0 =A0-hpa

GPT can not be used for boot disks in non-EFI systems, right?

Greg
