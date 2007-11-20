From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_nv: fix ATAPI issues with memory over 4GB (v3)
Date: Tue, 20 Nov 2007 14:49:36 +0900
Message-ID: <47427570.5030103@gmail.com>
References: <473A7677.6080007@shaw.ca> <473BA332.9030406@gmail.com> <473BC5DF.1040302@shaw.ca> <474230DC.8020308@gmail.com> <47426FDC.4030800@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:2710 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbXKTFtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 00:49:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2255385wah
        for <linux-ide@vger.kernel.org>; Mon, 19 Nov 2007 21:49:41 -0800 (PST)
In-Reply-To: <47426FDC.4030800@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> It looks like the problem is that even though we set the DMA mask after
> we allocate the PRD and pad buffers, when the other port is set up, the
> DMA mask is already over 64-bit and so it allocates its buffers over 4GB
> and fails. I think we just need to explicitly set to 32-bit first,
> getting the reporter to try that one now.

Ah.. right.  That makes sense.  Thanks.

-- 
tejun
