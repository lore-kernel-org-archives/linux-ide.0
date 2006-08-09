From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patch] libata: improve initialization and legacy handling,
 take #3
Date: Wed, 09 Aug 2006 14:50:17 +0900
Message-ID: <44D97799.806@gmail.com>
References: <44D62D33.9070601@gmail.com> <44D9764E.7000801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:48581 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965079AbWHIFu0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 01:50:26 -0400
Received: by py-out-1112.google.com with SMTP id z74so197253pyg
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2006 22:50:21 -0700 (PDT)
In-Reply-To: <44D9764E.7000801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hello,
>>
>> tj-upstream, tj-pata-drivers, tj-ALL have been updated per Alan's 
>> comment[1].  tj-upstream-fixes isn't affected.  Diff against the last 
>> take[L] is attached.
> 
> What's the difference?
> 
> The patch you attached seems to be exactly the same as what Alan 
> objected to...

Sorry, diff was done the other way around.  That part is removed.

-- 
tejun
