From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 11:13:31 -0400
Message-ID: <20150514151331.GI11388@htj.duckdns.org>
References: <1431567319-3380-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36834 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbENPNf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 11:13:35 -0400
Received: by qkgw4 with SMTP id w4so11003775qkg.3
        for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 08:13:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431567319-3380-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: wenxiong@linux.vnet.ibm.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, bjking1@us.ibm.com, wenxiong@us.ibm.com

Hello, Wen.

On Wed, May 13, 2015 at 08:35:19PM -0500, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> This patch adds the callback functions to support EEH error
> recovery in ahci driver. Also adds the code in ahci_error_handler
> to issue an MMIO load then check if it is in EEH. If it is in EEH,
> ahci_error_handler will wait until EEH recovery is completed.

Can you please explain why we would want this?  What does it buy us?

Thanks.

-- 
tejun
