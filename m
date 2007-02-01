From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: Initialize nbytes for internal sg commands
Date: Thu, 01 Feb 2007 10:26:36 +0900
Message-ID: <45C141CC.6010008@gmail.com>
References: <1170178343430-patch-mail.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:42213 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161215AbXBAB05 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 20:26:57 -0500
Received: by an-out-0708.google.com with SMTP id b33so252790ana
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 17:26:57 -0800 (PST)
In-Reply-To: <1170178343430-patch-mail.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, brazilnut@linux.vnet.ibm.com

Brian King wrote:
> Some LLDDs, like ipr, use nbytes and pad_len to determine
> the total data transfer length of a command. Make sure
> nbytes gets initialized for internally generated commands.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
