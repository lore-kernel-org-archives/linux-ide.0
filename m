From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/4] libata: reorder HSM_ST_FIRST for easier decoding
Date: Sat, 31 Mar 2007 16:27:57 +0900
Message-ID: <460E0D7D.6070109@gmail.com>
References: <460E08AF.8070900@tw.ibm.com> <460E0A24.6000105@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:58270 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbXCaH2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:28:05 -0400
Received: by nz-out-0506.google.com with SMTP id s1so618884nze
        for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 00:28:04 -0700 (PDT)
In-Reply-To: <460E0A24.6000105@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> patch 1/4:
>   Reorder HSM_ST_FIRST, such that the task state transition is easier decoded with human eyes.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
