From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 7/7] libata: reorganize ata_bus_probe()
Date: Tue, 21 Feb 2006 00:16:06 +0900
Message-ID: <43F9DD36.4050808@gmail.com>
References: <113999544950-git-send-email-htejun@gmail.com> <43F99D47.4060603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:39321 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030281AbWBTPQJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 10:16:09 -0500
Received: by zproxy.gmail.com with SMTP id n1so987522nzf
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 07:16:08 -0800 (PST)
In-Reply-To: <43F99D47.4060603@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Now that reset and configure are converted such that they don't modify
>> or disable libata core data structures, reorganize ata_bus_probe() to
>> reflect this change.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
> 
> the legacy phy_reset code path appears to call ata_port_probe() a second 
> time.  otherwise, seems OK.
> 

Hello, Jeff.

That is intentional. ->phy_reset disables port if something goes wrong 
during reset while the new model just offlines affected devices. The 
code there emulates new behavior by turning off all devices and enabling 
the port if the port gets disabled during ->phy_reset.

-- 
tejun
