From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 19:07:52 -0400
Message-ID: <h5q989$lbo$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org>	<20090809072823.GA2130@liondog.tnic>	<4A7F85DB.40604@duda.tzo.com>	<4A809AC2.70206@duda.tzo.com> <20090810233618.0c8e183f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48348 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbZHJXIG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 19:08:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MadyF-00015t-GK
	for linux-ide@vger.kernel.org; Mon, 10 Aug 2009 23:08:03 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 23:08:03 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 23:08:03 +0000
In-Reply-To: <20090810233618.0c8e183f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


>
> At what distance into the 20G did it fill ?

I write the backup using tar czf (compressed)
When I read it back, I get around 15G uncompressed.

I haven't tried writing raw (no compression).

In in the process of trying libata without ide-* drivers now ...

Jim
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


