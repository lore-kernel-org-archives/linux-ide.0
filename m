From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 19:34:59 -0400
Message-ID: <h5qar4$4qf$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic> <4A7F85DB.40604@duda.tzo.com> <4A809AC2.70206@duda.tzo.com> <20090810233618.0c8e183f@lxorguk.ukuu.org.uk> <h5q989$lbo$1@ger.gmane.org> <20090810232140.GA21759@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44919 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbZHJXfN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 19:35:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MaeOT-0001z8-9N
	for linux-ide@vger.kernel.org; Mon, 10 Aug 2009 23:35:09 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 23:35:09 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 23:35:09 +0000
In-Reply-To: <20090810232140.GA21759@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 08/10/2009 07:21 PM, Jim Paris wrote:
>
> that sounds normal.  Are you sure about the tape size?

Yeah, you have a good point.  The tapes are technically 10G (native) 20G (compressed).
Maybe I just need to review the backup data in more detail.
The same backup data set used to work in older kernels, but I may be missing some detail.

Jim



