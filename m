From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Fri, 31 Mar 2006 08:36:17 +0900
Message-ID: <442C6B71.4090302@gmail.com>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com> <20060325054008.GG5288@htj.dyndns.org> <20060325061215.GH5288@htj.dyndns.org> <442C54AB.2040306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:7791 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751155AbWC3Xgn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 18:36:43 -0500
Received: by zproxy.gmail.com with SMTP id o37so643759nzf
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2006 15:36:42 -0800 (PST)
In-Reply-To: <442C54AB.2040306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This patch renames ata_dev_present() to ata_dev_enabled() and adds
>> ata_dev_disabled().  This is to discern the state where a device is
>> present but disabled from not-present state.  This disctinction is
>> necessary when configuring transfer mode because device selection
>> timing must not be violated even if a device fails to configure.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK patches 1-2.  can you please rediff against current #upstream and 
> resend?
> 

Hello, Jeff.

Can you please hold a bit? This patch went through interface change last 
night in my repository to support probing retry. I've been diddling with 
new EH like crazy last few days and it's taking more days than I thought 
but new EH looks really good now. I think it can go out today, well, 
unless I hit another unexpected slab corruption. ;(

Thanks.

-- 
tejun
