From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Fri, 26 Sep 2008 23:06:37 +0900
Message-ID: <48DCEC6D.1040305@gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com> <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com> <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com> <48DA0C8B.3000406@gmail.com> <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com> <20080925032437.6802.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:48169 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbYIZOIJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Sep 2008 10:08:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so403910tic.23
        for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2008 07:08:07 -0700 (PDT)
In-Reply-To: <20080925032437.6802.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

George Spelvin wrote:
> Just a little followup... I currently have the machine with 8 GB RAM,
> all 4 SB600 channels populated, and 64-bit DMA enabled, operating in
> production.  No problems so far.
> 
> Q: Does the fact that I'm using the GART IOMMU mean that I'm not really using
> 64-bit DMA at all?

Can you turn it off and see what happens?

-- 
tejun
