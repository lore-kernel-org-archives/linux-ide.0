From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: libata PM question
Date: Sun, 29 Nov 2009 21:47:41 -0600
Message-ID: <4B13405D.6040407@gmail.com>
References: <1259547765.2076.48.camel@pasglop> <1259547943.2076.50.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55852 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbZK3Drh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Nov 2009 22:47:37 -0500
Received: by yxe26 with SMTP id 26so2714135yxe.4
        for <linux-ide@vger.kernel.org>; Sun, 29 Nov 2009 19:47:43 -0800 (PST)
In-Reply-To: <1259547943.2076.50.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11/29/2009 08:25 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 13:22 +1100, Benjamin Herrenschmidt wrote:
>> Hi there !
>>
>> So I (finally !) resumed work on pata_macio.c to replace ide/pmac.c :-)
>>
>> I've started looking at the suspend/resume stuff. It looks like most of
>> it just comes for free thanks to libata, yay ! :-)
>
>   .../...
>
> Oh, another question... where do we spin the disk down&  park it on
> suspend ? I'm missed at least that part :-)

sd driver handles that part (it issues a START STOP UNIT command which 
gets translated into STANDBY IMMEDIATE).
