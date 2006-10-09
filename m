From: Tejun Heo <htejun@gmail.com>
Subject: Re: feedback with VIA vt8251 and 2.6.17.4
Date: Mon, 09 Oct 2006 15:50:17 +0900
Message-ID: <4529F129.4050603@gmail.com>
References: <Pine.LNX.4.64.0610051835140.1955@s1.ckr-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:24687 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751660AbWJIGu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Oct 2006 02:50:26 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1872005nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 23:50:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0610051835140.1955@s1.ckr-solutions.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olivier Kaloudoff <kalou@kalou.net>
Cc: linux-ide@vger.kernel.org

Olivier Kaloudoff wrote:
> Hello,
> 
>     I just patched and installed kernel
> 2.6.17-1.2139_FC4 with patch [1] . Using 2x brand new
> "Maxtor 6V250F0 Rev: VA11", and a md raid 1 array, I
> got the following errors in my log ([2] for full details);

Please give a shot at 2.6.18.  libata and ahci received major revamp in 
error handling department and should behave much better now.

Thanks.

-- 
tejun
