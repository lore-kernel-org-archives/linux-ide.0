From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA_SIL
Date: Thu, 01 Nov 2007 08:40:31 +0900
Message-ID: <4729126F.1000108@gmail.com>
References: <1193781389.26314.9.camel@ws1.fransdb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:50274 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbXJaXkj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 19:40:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so283221rvb
        for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 16:40:39 -0700 (PDT)
In-Reply-To: <1193781389.26314.9.camel@ws1.fransdb.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans de Boer <frans@fransdb.nl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Frans de Boer wrote:
> Dear Sir,
> 
> I know, I am not the only one to find out that we can't upgrade to a
> newer kernel when using SUSE 10.3. It seems that in 2.6.23 the sil
> modules have been updated (newer versions) and thus render the current
> system mostly unuseable. I noticed that in the sata_sil24.c source there
> where a significant number of chances, which are probally not easy to
> change. Overwriting the newer versions with the versions from 2.6.22.9
> might work, but for how long.

Those are backported PMP changes and the code base very similar to
2.6.24-rc1.

> Is this a problem SUSE introduced, you forgot to take legacy into
> account or is it a "feature".
> Is this problem adjusted in 2.6.24-rc1?

Please file a bug report at bugzilla.novell.com, attach
/var/log/boot.msg and the result of "hwinfo --all" and assign it to
teheo@novell.com.

Thanks.

-- 
tejun
