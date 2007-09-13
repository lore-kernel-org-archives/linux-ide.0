From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA problems
Date: Thu, 13 Sep 2007 10:55:43 +0200
Message-ID: <46E8FB0F.3030904@gmail.com>
References: <4671366B.7090702@lbsd.net>	<46716B1D.1070902@garzik.org>	<20070614182854.GC1223@redhat.com>	<20070618200703.GB13344@redhat.com>	<46776223.3050402@lbsd.net>	<46D68CC2.3030206@lbsd.net> <20070910020243.1101cf7a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:55150 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbXIMI5a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2007 04:57:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so332343rvb
        for <linux-ide@vger.kernel.org>; Thu, 13 Sep 2007 01:57:30 -0700 (PDT)
In-Reply-To: <20070910020243.1101cf7a.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nigel Kukard <nkukard@lbsd.net>, Dave Jones <davej@redhat.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Thu, 30 Aug 2007 09:24:18 +0000 Nigel Kukard <nkukard@lbsd.net> wrote:
> 
>> Hrmmm,
>>
>>>>  > 
>>>>  >  > > Jun 14 07:55:52 nigel-m2v kernel: ATA: abnormal status 0x7F on port
>>>>  >  > > 0x0001c807
>>>>  >  > > Jun 14 07:55:52 nigel-m2v kernel: ATA: abnormal status 0x7F on port
>>>>  >  > > 0x0001c807
>>>>  > 
>>>>  > Unrelated to the other error, but I've been meaning to ask for a while..
>>>>  > If this is 'abnormal', why does every SATA box I've seen do it?
>>>>
>>>> *crickets*

It's removed (finally).  :-)

-- 
tejun
