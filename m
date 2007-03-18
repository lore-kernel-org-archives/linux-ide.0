From: Tejun Heo <htejun@gmail.com>
Subject: Re: Via VT6421 PATA support
Date: Sun, 18 Mar 2007 14:45:46 +0900
Message-ID: <45FCD20A.3070100@gmail.com>
References: <BA4CEFA0-4132-412E-815C-687B253AF6A2@styfsoftware.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:31156 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbXCRFpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 01:45:51 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1026169wry
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 22:45:50 -0700 (PDT)
In-Reply-To: <BA4CEFA0-4132-412E-815C-687B253AF6A2@styfsoftware.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Isak Styf <isak@styfsoftware.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Isak Styf wrote:
> Hi!
> 
> I am wondering why VT6421 PATA support is still on the todo list in
> sata_via.c although patches have been posted that makes it work?
> 
> I am currently looking at 2.6.20-1.2925.fc6. I had hoped that the
> support would be added in that kernel, but unfortunately it seems to
> have been left out. Why is this? Have you been notified about any
> stability issues?
> 
> I am now running a manually patched 2.6.19-1.2895, but i would of course
> prefer to have this functionality in the stock kernel.

Will be in 2.6.21.

-- 
tejun
