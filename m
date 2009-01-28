From: Mark Lord <liml@rtr.ca>
Subject: Re: ide/libata: fix ata_id_is_cfa() ..  hdparm-9.10
Date: Wed, 28 Jan 2009 10:03:30 -0500
Message-ID: <498073C2.3040106@rtr.ca>
References: <200901271619.53025.sshtylyov@ru.mvista.com> <497F2EAD.4080705@rtr.ca> <497F3366.5020608@ru.mvista.com> <200901281051.35030.gdu@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57648 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbZA1PDd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jan 2009 10:03:33 -0500
In-Reply-To: <200901281051.35030.gdu@mns.spb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Gryazin <gdu@mns.spb.ru>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, navy-patches@mns.spb.ru

For the convenience of folks looking at CF cards and other issues here,
I've just put out hdparm-9.10 https://sourceforge.net/projects/hdparm/
with improved CF card detection, and corrected reporting of CF mwdma modes.

If you haven't upgraded in a while, this might be an excuse to do so.

Cheers

Mark
