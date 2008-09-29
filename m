From: Tejun Heo <tj@kernel.org>
Subject: Re: Report drive which perform frequent head unloads under Linux
Date: Mon, 29 Sep 2008 16:35:04 +0900
Message-ID: <48E08528.5010300@kernel.org>
References: <25740.14711.qm@web25404.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58132 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYI2Hgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:36:47 -0400
In-Reply-To: <25740.14711.qm@web25404.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Henriet <aladin7501-01@yahoo.de>
Cc: linux-ide@vger.kernel.org

Stefan Henriet wrote:
> Following Laptop is affected by frequent head unloads.
> 
> Laptop: HP G5000
> workaround: set APM to 255 

How much does the load cycle count increase per hour without any adjustment?

Thanks.

-- 
tejun
