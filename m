From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Thu, 24 Apr 2008 12:48:32 +0900
Message-ID: <48100310.3060300@gmail.com>
References: <200804021524.27222.elendil@planet.nl> <20080415144748.GO7385@csclub.uwaterloo.ca> <48053AD1.8010007@gmail.com> <200804162008.27655.elendil@planet.nl> <480679D3.7030705@gmail.com> <20080417140506.GC7385@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.242]:53083 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753630AbYDXDsl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 23:48:41 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1699223rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 20:48:41 -0700 (PDT)
In-Reply-To: <20080417140506.GC7385@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Frans Pop <elendil@planet.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Lennart Sorensen wrote:
> After all I thought the whole point of all the ports listed in
> /proc/ioports was to indicate which io ports were currently reserved by
> which driver so that no other driver could try to access them.  If it
> doesn't in fact work that way then it probably should.

It does work most of the time and it's probably safe to load legacy / 
generic drivers on most configurations.  It's just that we're talking 
about 15+ years of gap between ISA and PCI-e and there could be some 
exceptions and we might need to tread a bit more carefully.  To me, it 
sounds reasonable.

Thanks.

-- 
tejun
