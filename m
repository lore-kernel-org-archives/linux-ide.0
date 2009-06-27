From: Tejun Heo <htejun@gmail.com>
Subject: Re: sil3132 is resetting continuously
Date: Sun, 28 Jun 2009 07:54:36 +0900
Message-ID: <4A46A32C.8020306@gmail.com>
References: <3fb94e50906270830q436e5aa4n8a40741cd0d738b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:62017 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZF0Wyi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Jun 2009 18:54:38 -0400
Received: by rv-out-0506.google.com with SMTP id f6so917765rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 27 Jun 2009 15:54:41 -0700 (PDT)
In-Reply-To: <3fb94e50906270830q436e5aa4n8a40741cd0d738b8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Sagar Borikar wrote:
> Hi list,
> 
> I am using sil3132 PCIe card on my ARM platform and I find that
> whenever the system boots, the device gets hard reset. I am not able
> see the device node as well. It always say that the controller is in
> dubious state.  following is platform information:
> 
> CPU: cortex A8
> kernel: 2.6.24

Looks like it could be an IRQ routing problem.

-- 
tejun
