From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata:  PHY reset requires writing 0x4 to SControl
Date: Sun, 16 Jul 2006 12:27:26 +0900
Message-ID: <44B9B21E.70900@gmail.com>
References: <20060705190613.GD16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:59085 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964850AbWGPD0K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 23:26:10 -0400
Received: by nz-out-0102.google.com with SMTP id x7so312429nzc
        for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 20:26:09 -0700 (PDT)
In-Reply-To: <20060705190613.GD16658@bork.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Hicks <mort@bork.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Martin Hicks wrote:
> Hi,
> 
> Reading the Intel VSC and AHCI it seems like writing 0x302 is incorrect.
> The only valid values are 4, 1 and 0.  Writing 4 disables the
> PHY.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

Thanks for spotting this.

-- 
tejun
