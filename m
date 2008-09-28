From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Mon, 29 Sep 2008 08:20:12 +0900
Message-ID: <48E0112C.7010901@gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com> <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com> <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com> <48DA0C8B.3000406@gmail.com> <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com> <20080925032437.6802.qmail@science.horizon.com> <48DCEC6D.1040305@gmail.com> <20080928210422.2578.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:33195 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYI1XVj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 19:21:39 -0400
Received: by ti-out-0910.google.com with SMTP id b6so784938tic.23
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 16:21:36 -0700 (PDT)
In-Reply-To: <20080928210422.2578.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

George Spelvin wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>>> Q: Does the fact that I'm using the GART IOMMU mean that I'm not really using
>>> using 64-bit DMA at all?
>> Can you turn it off and see what happens?
> 
> I can if I can verify that every other bus-master PCI device in the
> system can do 64-bit DMA.
> 
> Do you know how to check that?  I haven't found a file under /sys or
> /proc that tells me what the DMA masks are of various system
> drivers, but that doesn't mean that it doesn't exist.

It doesn't really matter.  The kernel will bounce buffers as
necessary.

-- 
tejun
