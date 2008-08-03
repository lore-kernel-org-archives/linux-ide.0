From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re : Re : dvd-9 trouble with TSSTcorp SH-S203D
Date: Sun, 3 Aug 2008 16:26:47 +0100
Message-ID: <20080803162647.26c188b2@lxorguk.ukuu.org.uk>
References: <547246.1958.qm@web26202.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55182 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756052AbYHCPo0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 11:44:26 -0400
In-Reply-To: <547246.1958.qm@web26202.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbg==?= <willy_the_cat@yahoo.com>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org


> [ 2002.943737] end_request: I/O error, dev sr0, sector 11697200
> [ 2003.112690] UDF-fs: Partition marked readonly; forcing readonly mount
> [ 2003.138034] UDF-fs INFO UDF: Mounting volume 'BROKEN_ARROW', timestamp 1999/12/29 19:42 (1078)

Partial access to a movie file. I assume you've checked the disc in
question is not copy protected. We don't support decrypting copy
protected disks for all the obvious reasons.
