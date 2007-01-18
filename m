From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/3] libata: Initialize nbytes for internal sg commands
Date: Thu, 18 Jan 2007 10:35:43 +0900
Message-ID: <45AECEEF.6020008@gmail.com>
References: <11690587311891-patch-mail.ibm.com> <200701171832.l0HIWMB7025070@d03av04.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:36098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXARBfw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 20:35:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so43972uga
        for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 17:35:51 -0800 (PST)
In-Reply-To: <200701171832.l0HIWMB7025070@d03av04.boulder.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Brian King wrote:
> Some LLDDs, like ipr, use nbytes and pad_len to determine
> the total data transfer length of a command. Make sure
> nbytes gets initialized for internally generated commands.

I think it's better to apply the following patch instead of this one.

http://article.gmane.org/gmane.linux.ide/14792

-- 
tejun
