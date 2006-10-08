From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sis only recognizing primary drive in 2.6.18
Date: Sun, 08 Oct 2006 13:24:37 +0900
Message-ID: <45287D85.1050302@gmail.com>
References: <20061006065816.GA5782@jim.sh> <45263683.408@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:24146 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751131AbWJHMqV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 08:46:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so1922382pyg
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 05:46:21 -0700 (PDT)
In-Reply-To: <45263683.408@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jim Paris <jim@jtan.com>, linux-ide@vger.kernel.org, muthas@mit.edu, fragmede@gmail.com

Hi!

Uwe Koziolek wrote:
> Hi Jim,
> 
> the sata_sis is running without slave support in the versions from
> kernel.org. That is ok if you are using
> a SiS964 and 965L chip. The SiS 965, SiS180 and SiS966 needs a slave
> support.
> 
> The attached patch against 2.6.18 should help.
> 
> feedback, log and output of lspci -vvxxx are welcome.

Can you make separate port_info for controllers which support 4 ports 
and send a properly formatted patch?

Thanks.

-- 
tejun

