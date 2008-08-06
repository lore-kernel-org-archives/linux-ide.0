From: Tejun Heo <tj@kernel.org>
Subject: Re: Issue with AHCI driver
Date: Thu, 07 Aug 2008 08:15:19 +0900
Message-ID: <489A3087.1020500@kernel.org>
References: <12755613.1218041955162.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33681 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbYHFXQI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Aug 2008 19:16:08 -0400
In-Reply-To: <12755613.1218041955162.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> which would you recommend?  We tried 2.6.24.7 and saw problems...

The latest one 2.6.26.2.  Hmmm.. IIRC 2.6.24.7 should have the class
code matching tho.  Anyways, please give a shot at 2.6.26.2.

-- 
tejun
