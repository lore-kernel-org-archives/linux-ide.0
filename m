From: Tejun Heo <tj@kernel.org>
Subject: Re: weird throughput on write to SATA disk
Date: Tue, 14 Oct 2008 18:17:56 +0900
Message-ID: <48F463C4.3070405@kernel.org>
References: <1223925629.3947.7.camel@duo>	 <da824cf30810131407m1a73bd11xa30fd118ee5a4c8f@mail.gmail.com>	 <1223932956.3947.22.camel@duo>	 <da824cf30810131434r34179666kc8d075c7eecdbbae@mail.gmail.com>	 <1223936351.3947.41.camel@duo>	 <da824cf30810131833g6e509d0dvb6cce6c7220a1a28@mail.gmail.com> <1223975694.3947.77.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38394 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbYJNJT7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 05:19:59 -0400
In-Reply-To: <1223975694.3947.77.camel@duo>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

kenneth johansson wrote:
> On Mon, 2008-10-13 at 18:33 -0700, Grant Grundler wrote:
>> On Mon, Oct 13, 2008 at 3:19 PM, kenneth johansson <ken@kenjo.org> wrote:
>> ...
>>>> Can you try "dd oflag=direct if=/dev/null of=/dev/sdb bs=64k"?
>>> I changed to use O_DIRECT and it's much more consistent now. 69-75 with
>>> 74 about 95% of the time.
>> That's low but it could be worse. Many things can contribute to slow
>> disks. 
> Well my main problem was that it was fluctuating so much that can't be
> right. 
> 
>> Favorites are overtemp (See SMART field 194) and vibration (no
>> measurement possible w/o special equipment). "dd" isn't exactly a
>> performance application until one uses really big block sizes (1MB or
>> larger).
> All my numbers comes from using 1MB blocks. but I'm not using dd.
> After removing the logic that actually put some data into the buffers I
> do get about 105 MB/sec using O_DIRECT. I'm doing a full disk write now
> to get a reference plot. Not using O_DIRECT should be almost identical. 
> 
> 
>>> the disk is supposed to have 105 115 sustained
>>> data rate.
>> Where did 105-115 number come from?
> datasheet . they listed two drives in the same column so that was not
> the range it was sustained OD and the model I have max out at 105. 

Can you try deadline scheduler?

-- 
tejun
