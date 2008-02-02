From: Tejun Heo <htejun@gmail.com>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sun, 03 Feb 2008 08:14:30 +0900
Message-ID: <47A4F956.6030005@gmail.com>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com> <20080202173723.GA26461@solitudo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:46407 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357AbYBBXOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 18:14:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1113000rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 15:14:36 -0800 (PST)
In-Reply-To: <20080202173723.GA26461@solitudo.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tuomas Jormola <tj@solitudo.net>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Tuomas Jormola wrote:
> 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
> 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)

That's MCP61 which is GENERIC variant in sata_nv which does not support
hotplugging.  Robert, is this hardware restriction or do we just need
more info?

-- 
tejun
