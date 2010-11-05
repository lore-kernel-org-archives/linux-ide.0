From: Mark Lord <kernel@teksavvy.com>
Subject: Re: TRIM support in drivers and dm/md?
Date: Thu, 04 Nov 2010 22:44:29 -0400
Message-ID: <4CD36F8D.7000700@teksavvy.com>
References: <4CD2B2EF.4050005@att.net> <20101104134014.GB21931@parisc-linux.org> <4CD2C755.3000908@att.net> <4CD2E32D.9030303@garzik.org> <4CD2F3E1.8040700@att.net> <4CD31647.7070301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:22200 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753112Ab0KECoc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Nov 2010 22:44:32 -0400
In-Reply-To: <4CD31647.7070301@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeff Layton <laytonjb@att.net>, Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

sata_sil didn't support trim the last time I checked (the hardware can do it 
though).
sata_sil24 does, though, along with ahci, sata_mv, etc..

Cheers
