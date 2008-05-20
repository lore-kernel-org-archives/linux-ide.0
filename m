From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: improve EH retry delay handling
Date: Tue, 20 May 2008 13:02:22 +0900
Message-ID: <48324D4E.1040109@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>	<1211217475951-git-send-email-htejun@gmail.com> <20080519193311.01b5b928@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:29506 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbYETEC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 00:02:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1604920wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 21:02:27 -0700 (PDT)
In-Reply-To: <20080519193311.01b5b928@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

Alan Cox wrote:
> On Tue, 20 May 2008 02:17:52 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> EH retries were delayed by 5 seconds to ensure that resets don't occur
>> back-to-back.  However, this 5 second delay is superflous or excessive
>> in many cases.  For example, after IDENTIFY times out, there's no
>> reason to wait five more seconds before retrying.
> 
> You'll crash some ATAPI CD-ROM drives without that delay - at least for
> PATA. As in power cycle required to get it back.
> 
> Perhaps we should check cable type here ?

No, no, the five secs is still there.

e.g. Previously:

	reset (fail) - 5s retry wait - reset
	reset - IDENTIFY (30s timeout) - 5s retry wait - reset

Now:

	reset (fail) - 5s retry wait - reset
	reset - IDENTIFY (30s timeout) - reset

So, the inter-reset delay is never shorter than 5s.

-- 
tejun
