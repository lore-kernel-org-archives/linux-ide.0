From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-pata works on ICH4-M
Date: Thu, 13 Apr 2006 18:20:47 -0400
Message-ID: <443ECEBF.9050604@rtr.ca>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu> <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58298 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932473AbWDMWUs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 18:20:48 -0400
In-Reply-To: <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

For now, several hdparm flags work fine with libata SCSI drives.

Eg. hdparm -W1, hdparm I, ..

Sometime in the next month or two, I hope to update hdparm to use SGIO
where possible/necessary to enable most of the remaining flags to function.

Cheers
