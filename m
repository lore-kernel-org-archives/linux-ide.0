From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems w/ Sil3124 + Port Multiplier
Date: Thu, 03 May 2007 11:08:51 +0200
Message-ID: <4639A6A3.20001@gmail.com>
References: <463828F6.7020209@jogback.se> <46388862.1020709@gmail.com> <4638928E.60700@jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:43460 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030802AbXECJJu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2007 05:09:50 -0400
Received: by py-out-1112.google.com with SMTP id a29so349317pyi
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2007 02:09:49 -0700 (PDT)
In-Reply-To: <4638928E.60700@jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

Lars Michael Jogb=E4ck wrote:
>> I think the disk attached to port 0 might be bad.  Please report the
>> result of 'smartctl -d ata -a /dev/sdX' where sdX is the device atta=
ched
>> to the failing port.
>>
>>  =20
> SMART Error Log Version: 1
> No Errors Logged

I was hoping to see some error logs but no.  Hardware_ECC_Recovered
count seems high (385707184) but I dunno whether the value is normal or
not.  Different manufacturers use different norms in counting them.  If
you have other disks of the same model, you can compare the values and
see whether if it's unusually high.

--
tejun
