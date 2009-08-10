From: Jim Paris <jim@jtan.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 19:21:40 -0400
Message-ID: <20090810232140.GA21759@psychosis.jim.sh>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic> <4A7F85DB.40604@duda.tzo.com> <4A809AC2.70206@duda.tzo.com> <20090810233618.0c8e183f@lxorguk.ukuu.org.uk> <h5q989$lbo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jim.sh ([75.150.123.25]:51858 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZHJXVo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 19:21:44 -0400
Content-Disposition: inline
In-Reply-To: <h5q989$lbo$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

Jim Duda wrote:
>
>>
>> At what distance into the 20G did it fill ?
>
> I write the backup using tar czf (compressed)
> When I read it back, I get around 15G uncompressed.

As far as I can tell, your tape drive (STT2000A) only holds 10G, so
that sounds normal.  Are you sure about the tape size?

See e.g.
  http://www.tech-archive.net/Archive/Windows/microsoft.public.windows.server.general/2005-03/0639.html

-jim
