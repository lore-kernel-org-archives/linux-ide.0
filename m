From: Tejun Heo <tj@kernel.org>
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver
Date: Wed, 08 Dec 2010 11:07:14 +0100
Message-ID: <4CFF58D2.4040006@kernel.org>
References: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com> <4CFEE569.4030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35245 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811Ab0LHKGw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Dec 2010 05:06:52 -0500
In-Reply-To: <4CFEE569.4030204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jian Peng <jipeng@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>

Hello,

On 12/08/2010 02:54 AM, Robert Hancock wrote:
> On 12/07/2010 01:43 AM, Jian Peng wrote:
>> Recently, while bringing up a new AHCI host controller, I found out
>> that current AHCI driver (in 2.6.37-rc3) may violate AHCI spec in
>> function libahci.c: ahci_start_engine().
>>
>> From end of section 10.1.2 in AHCI 1.3 spec, it claims
>>
>> Software shall not set PxCMD.ST to '1' until it is determined that
>> a functional device is present on the port as determined by
>> PxTFD.STS.BSY = '0', PxTFD.STS.DRQ = '0', and PxSSTS.DET = 3h.
>>
>> It seems working well on most controller without this extra
>> checking, but does cause problem in our new core. Since toggling
>> PxCMD.SUD already initiated reset process at early time, and by the
>> time of ahci_start_engine() got called, BSY bit may not be cleared
>> yet, and forcing PxCMD.ST bit to 1 will cause problem for HW in
>> this case.

Hmmm... interesting.  Yeah, we have never had any problem in that area
and would like to avoid changing unless necessary but then again if
it's broken, well, we should.  What kind of problem is the controller
showing?

Thanks.

-- 
tejun
