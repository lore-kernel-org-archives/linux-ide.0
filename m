From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] sata_nv: kill not-working hotplug code
Date: Tue, 20 Jun 2006 18:14:05 +0900
Message-ID: <4497BC5D.80701@gmail.com>
References: <11505269952304-git-send-email-htejun@gmail.com> <4497BB42.4070008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:32271 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965225AbWFTJOD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 05:14:03 -0400
Received: by nz-out-0102.google.com with SMTP id 18so1186915nzp
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 02:14:02 -0700 (PDT)
In-Reply-To: <4497BB42.4070008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> applied 1-6, then applied a cset to s/spin_lock_irqsave/spin_lock/

Thanks.  I'm too accustomed to irqsave/restore.  I'll try to remember 
next time.  :-p

-- 
tejun
