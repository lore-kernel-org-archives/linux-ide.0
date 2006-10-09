From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Date: Mon, 09 Oct 2006 16:57:00 +0900
Message-ID: <452A00CC.4080205@gmail.com>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com>	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org> <215036450610090044n56ec3a9dg62573a16d63ab00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:43665 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932336AbWJIH5K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 03:57:10 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1887991nfb
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 00:57:09 -0700 (PDT)
In-Reply-To: <215036450610090044n56ec3a9dg62573a16d63ab00c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Jin <lkmaillist@gmail.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Joe Jin wrote:
>> > It's against libata development tree.  So, you downloaded the tar.gz 
>> and
>> > tested it?
> 
> no, but at latest kernel 2.6.19-rc1 use the same tree as you said, and
> it also can worked

I see.  It's irrelevant anyway.

>> And, one more thing to try.  The following patch should fix your
>> problem.  It's against v2.6.18.
>>
> 
> while applied the patch, error info gone :)
> 
> A question: if the status register return 0xFF means the device not exist?
> why not use ata_devchk()?

Many SATA controllers emulate TF registers and pass devchk even when no 
device is attached.  I don't know whether the two conditions can happen 
together - 0xFF status is usually seen on PATA.  Anyways, it's more 
reliable to test 0xFF.  Also, that's what driver/ide has been doing for 
a long long time and we don't want to deviate from it if possible.

-- 
tejun
