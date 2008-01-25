From: Tejun Heo <htejun@gmail.com>
Subject: Re: AMD SB600  64 bit DMA issue
Date: Fri, 25 Jan 2008 12:21:21 +0900
Message-ID: <479955B1.3030600@gmail.com>
References: <B90463BC30D2E446BA423D888DC85E5016993C@sshaexmb1.amd.com> <478D73C2.2070307@gmail.com> <B90463BC30D2E446BA423D888DC85E50169AC4@sshaexmb1.amd.com> <478D9572.4030404@gmail.com> <B90463BC30D2E446BA423D888DC85E50169B96@sshaexmb1.amd.com> <B90463BC30D2E446BA423D888DC85E50169CF4@sshaexmb1.amd.com> <478ED021.2010502@gmail.com> <B90463BC30D2E446BA423D888DC85E50169DD1@sshaexmb1.amd.com> <478EE947.1020805@gmail.com> <B90463BC30D2E446BA423D888DC85E50169F82@sshaexmb1.amd.com> <478F6ED3.4050102@gmail.com> <B90463BC30D2E446BA423D888DC85E5016A15B@sshaexmb1.amd.com> <B90463BC30D2E446BA423D888DC85E5016A698@sshaexmb1.amd.com> <47955DD2.3040405@gmail.com> <B90463BC30D2E446BA423D888DC85E5016A6EB@sshaexmb1.amd.com> <B90463BC30D2E446BA423D888DC85E5016A709@sshaexmb1.amd.com> <479923CD.4070701@gmail.
 com> <B90463BC30D2E446BA423D888DC85E501BF82D@sshaexmb1.amd.com> <47993EBC.4000504@gmail.com> <B90463BC30D2E446BA423D888DC85E501BF86A@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:38839 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYAYDV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 22:21:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so788984wah.23
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 19:21:27 -0800 (PST)
In-Reply-To: <B90463BC30D2E446BA423D888DC85E501BF86A@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

Thanks, hmmm... weird.  The log is w/ MSI disabled, right?  SB600 is
reporting MSI capability alright.  I wonder why MSI is not enabled with
the quirk lifted.  Can you please post full boot log and the result of
'lspci -nnvvvxxx' w/ the quirk removed?

Thanks.

-- 
tejun
