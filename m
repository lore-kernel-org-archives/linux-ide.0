From: Tejun Heo <tj@kernel.org>
Subject: Re: Synopsis SATA AHCI support
Date: Thu, 19 Feb 2009 17:57:15 +0900
Message-ID: <499D1EEB.3000200@kernel.org>
References: <3fb94e50902182156y62da0f6dhfb5d99ad5de9d0fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59711 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbZBSI5F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 03:57:05 -0500
In-Reply-To: <3fb94e50902182156y62da0f6dhfb5d99ad5de9d0fd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Sagar Borikar wrote:
> Hi
> 
> Can you let me know whether Synopsis SATA AHCI is already supported in
> 2.6? and if yes then please point me to the sources.

I don't have any experience with the synopsis one but if it's standard
ahci, the ahci driver should work but sometimes controllers require
certain quirks to work properly.  Why don't you give it a try and
report how it works?

Thanks.

-- 
tejun
