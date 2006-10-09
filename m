From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Date: Mon, 09 Oct 2006 16:00:33 +0900
Message-ID: <4529F391.3030504@gmail.com>
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>	 <451E7BD2.7020002@gmail.com>	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>	 <4529BCC4.8060906@gmail.com> <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:2268 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751699AbWJIHAp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 03:00:45 -0400
Received: by py-out-1112.google.com with SMTP id n25so2207785pyg
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 00:00:45 -0700 (PDT)
In-Reply-To: <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Jin <lkmaillist@gmail.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Joe Jin wrote:
>> SRST failure would have still occurred but 30sec timeout should have
>> gone.  Can you post full dmesg?
> 
> Yes it is.
> attachment is the output of dmesg

Great.

>> Also, please test the patch in the following mail.  You can use either
>> git or download the full kernel tarball to get the modified kernel.
>>
> 
> Did the pathc against 2.6.19-rc1?
> I have test it, but it have not any change and timeout also appeared :(

It's against libata development tree.  So, you downloaded the tar.gz and 
tested it?

Thanks.

-- 
tejun
