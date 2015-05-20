From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: Fix regression when the NCQ Send and Receive
 log page is absent
Date: Wed, 20 May 2015 23:27:51 +0300
Message-ID: <555CEE47.40904@cogentembedded.com>
References: <1432079057-11262-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36493 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbETV0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2015 17:26:47 -0400
Received: by wizk4 with SMTP id k4so169600286wiz.1
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2015 14:26:46 -0700 (PDT)
In-Reply-To: <1432079057-11262-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org, sergey.senozhatsky@gmail.com

Hello.

On 05/20/2015 02:44 AM, Martin K. Petersen wrote:

> Commit 5d3abf8ff67f allowed us to fall back to the unqueued READ LOG

     Please also specify that commit's summary line in parens.

> variant if the queued version failed. However, if the device did not
> support the page at all we would end up looping due to a merge snafu.

> Ensure we only take the fallback path once.

> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
[...]

WBR, Sergei

