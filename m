From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: IDENTIFY backwards
 for drive side cable detection
Date: Fri, 23 Mar 2007 00:44:09 +0900
Message-ID: <4602A449.2070009@gmail.com>
References: <20070322132419.GK6152@htj.dyndns.org> <20070322143712.64551edf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44600 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbXCVPoQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 11:44:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so731809uga
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 08:44:14 -0700 (PDT)
In-Reply-To: <20070322143712.64551edf@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, xhejtman@mail.muni.cz

Alan Cox wrote:
> On Thu, 22 Mar 2007 22:24:19 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> For drive side cable detection to work correctly, drives need to be
>> identified backwards such that the slave device releases PDIAG- before
>> the mater drive tries to detect cable type.  ata_bus_probe() was fixed
>> by commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c but the new EH path
>> wasn't fixed.  This patch makes new EH path do IDENTIFY backwards.
>>
>> ata_dev_configure() for new devices are still performed master first.
>> This is to keep the detection messages in forward order.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> Why do we have two implementations of the same code ?

ata_bus_probe() is scheduled to be killed once all old-EH code is
removed.  That's the old probe path.

-- 
tejun
