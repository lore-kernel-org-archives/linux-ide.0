From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: rename ata_dev_id_[c_]string()
Date: Wed, 15 Feb 2006 11:00:32 +0900
Message-ID: <43F28B40.4050608@gmail.com>
References: <11397520242535-git-send-email-htejun@gmail.com> <43EF8BB8.2020609@pobox.com> <20060213010246.GA9621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.202]:23109 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbWBOCAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2006 21:00:35 -0500
Received: by xproxy.gmail.com with SMTP id h26so1004873wxd
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 18:00:35 -0800 (PST)
In-Reply-To: <20060213010246.GA9621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch renames ata_dev_id_[c_]string() to ata_id_[c_]string().
> All other functions which read data from ATA ID data start with ata_id
> and those two function names were getting too long.
> 

Jeff, can you ACK or NACK it?  So I can base following patches 
accordingly.  BTW, thanks a lot for the prompt reviews!

:-)

-- 
tejun
