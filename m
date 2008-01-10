From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Thu, 10 Jan 2008 09:40:57 +0900
Message-ID: <47856999.5020806@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com> <474E2F5E.1010509@23palmer.net> <47836C36.4040701@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022BC5E7@orsmsx420.amr.corp.intel.com> <47855E4C.7010504@23palmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.154]:12495 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbYAJAlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 19:41:02 -0500
Received: by po-out-1718.google.com with SMTP id c31so847058poi.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 16:41:02 -0800 (PST)
In-Reply-To: <47855E4C.7010504@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <tom@23palmer.net>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

Thomas Evans wrote:
> I stopped seeing this message when I started using rc4.
> 
> I upgraded to rc7 with your patch - the dmesg is attached.
> 
> The link speed seems limited to 1.5Gbps now though, which hasn't been
> the case in rc3->rc6.

So, yours works fine w/o the patch, right?

-- 
tejun
