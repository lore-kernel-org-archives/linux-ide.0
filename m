From: Tejun Heo <tj@kernel.org>
Subject: Re: frequent head unloads
Date: Sun, 04 Oct 2009 12:27:12 +0900
Message-ID: <4AC81610.20505@kernel.org>
References: <op.uyjnnefmv46o6b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42839 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbZJDD0z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Oct 2009 23:26:55 -0400
In-Reply-To: <op.uyjnnefmv46o6b@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Sumner <msumner828@btinternet.com>
Cc: linux-ide@vger.kernel.org

Mike Sumner wrote:
> This is the info for my new SONY VAIO FW31E
> 
> It was doing an unload cycle every 15 seconds.

Noted in ATA known issues wiki and added to storage-fixup.

> I have found that the setting does not stick on re-boot or after
> suspend.  Any suggestions?

You can use storage-fixup.

  http://git.kernel.org/?p=linux/kernel/git/tj/storage-fixup.git

Thanks.

-- 
tejun
