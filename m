From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-rc5 regression: hd don't show up
Date: Fri, 02 Oct 2009 17:59:11 +0900
Message-ID: <4AC5C0DF.50706@kernel.org>
References: <h63737$b2a$1@ger.gmane.org> <4A852BC0.1090404@kernel.org> <4A8559D7.6090405@klingt.org> <4A8774E5.4070609@kernel.org> <4A87D9FC.9070408@klingt.org> <4A96460F.3020600@kernel.org> <4A965E3B.3000808@klingt.org> <4A966F7D.60707@kernel.org> <4A97B9C0.9090003@klingt.org> <4A9B7E1E.8060909@kernel.org> <4A9DAF78.4070703@klingt.org> <4A9DD6D9.50407@kernel.org> <4A9E371A.5040208@klingt.org> <4A9FCD8C.6010107@kernel.org> <4AA18F57.8030107@klingt.org> <4AA1ACF8.7030101@kernel.org> <4AA6C569.9090901@klingt.org> <4AB04B39.7030907@kernel.org> <4AB079FC.6000906@kernel.org> <4AB09562.3010501@klingt.org> <4AB0D34A.2010502@kernel.org> <4ABC44FE.5050904@kernel.org> <4ABC7543.90407@klingt.org> <4ABC7714.2030709@kernel.org> <4ABCADE2.1020300@klingt.org> <4ABCC3DB.1000202@kernel.org> <4AC58D9C.60103
 06@kernel.org> <4AC5AC0D.9020901@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42305 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbZJBI7O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Oct 2009 04:59:14 -0400
In-Reply-To: <4AC5AC0D.9020901@klingt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

Tim Blechmann wrote:
> since i have this kernel running, i didn't see any of these messages,
> still, my hds always showed up ...
> not sure, if this is related to your patch or if the buggy behavior,
> just didn't occur ...

Can you please reboot several times and see whether libata probing
messages show anything interesting?

Thanks.

-- 
tejun
