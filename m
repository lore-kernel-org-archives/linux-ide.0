From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: update EH speed down logic, take #2
Date: Fri, 23 Nov 2007 10:07:48 +0900
Message-ID: <474627E4.8080802@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:31338 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbXKWBID (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 20:08:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3332649wah
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 17:08:02 -0800 (PST)
In-Reply-To: <1194241515653-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
> 
> This is the second take of update-EH-speed-down-logic patchset.
> Changes from the last take[1] are...
> 
> * Updated to apply & build against the current linus#master.  Recently
>   committed error-passthhrough-for-non-IO-command change broke build
>   with this patchset applied.
> 
> This patchset is against the current linux#master (b55d1b18).

Ping.

-- 
tejun
