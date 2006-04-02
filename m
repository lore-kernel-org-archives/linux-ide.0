From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/15] libata: implement ata_dev_enabled and disabled()
Date: Sun, 02 Apr 2006 09:54:23 +0900
Message-ID: <442F20BF.9090705@gmail.com>
References: <11438230983412-git-send-email-htejun@gmail.com> <442EB878.90201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:44774 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbWDBAyd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 19:54:33 -0500
Received: by zproxy.gmail.com with SMTP id o37so1359747nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 16:54:30 -0800 (PST)
In-Reply-To: <442EB878.90201@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

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
> Tangent thought:  perhaps instead of ata_dev_present() you could 
> implement its antonym, ata_dev_absent().  It seems like a lot of the 
> constructs are "!dev_present()" anyway.
> 

Interesting. I'll bite that. :)

-- 
tejun
